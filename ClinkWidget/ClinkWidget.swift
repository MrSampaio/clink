import WidgetKit
import SwiftUI
import AppIntents

struct ReminderEntity: AppEntity {
    var id: String
    var title: String
    var colorHex: String
    var description: String
    var dateString: String
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Lembrete"
    static var defaultQuery = ReminderQuery()
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: LocalizedStringResource(stringLiteral: title))
    }
}

struct ReminderQuery: EntityQuery {
    func entities(for identifiers: [String]) async throws -> [ReminderEntity] {
        return allReminders().filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() async throws -> [ReminderEntity] {
        return allReminders()
    }
    
    func defaultResult() async -> ReminderEntity? {
        return allReminders().first
    }
    
    func allReminders() -> [ReminderEntity] {
        guard let sharedDefaults = UserDefaults(suiteName: "group.sampaio.clink.dados"),
              let data = sharedDefaults.data(forKey: "widget_shared_reminders"),
              let reminders = try? JSONDecoder().decode([Reminder].self, from: data) else {
            return []
        }
        
        return reminders.map { reminder in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM, HH:mm"
            let dateStr = reminder.dueDate != nil ? formatter.string(from: reminder.dueDate!) : ""
            
            return ReminderEntity(
                id: reminder.id.uuidString,
                title: reminder.title,
                colorHex: reminder.color.toHex(),
                description: reminder.description ?? "",
                dateString: dateStr
            )
        }
    }
}

struct SelectReminderIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Escolher Lembrete"
    static var description = IntentDescription("Escolha qual lembrete mostrar neste widget.")

    @Parameter(title: "Lembrete")
    var selectedReminder: ReminderEntity?
    
    init() {}
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let title: String
    let icon: String
    let colorHex: String
    let description: String
    let dateString: String
}

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), title: "Seu Lembrete", icon: "📌", colorHex: "2196F3", description: "Descrição do lembrete", dateString: "Hoje")
    }

    func snapshot(for configuration: SelectReminderIntent, in context: Context) async -> SimpleEntry {
        createEntry(for: configuration.selectedReminder)
    }

    func timeline(for configuration: SelectReminderIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let entry = createEntry(for: configuration.selectedReminder)
        return Timeline(entries: [entry], policy: .never) // Só atualiza quando o app manda
    }
    
    private func createEntry(for entity: ReminderEntity?) -> SimpleEntry {
        if let entity = entity {
            return SimpleEntry(
                date: Date(),
                title: entity.title,
                icon: "📌",
                colorHex: entity.colorHex,
                description: entity.description,
                dateString: entity.dateString
            )
        } else {
            return SimpleEntry(
                date: Date(),
                title: "Nenhum Selecionado",
                icon: "⚠️",
                colorHex: "808080",
                description: "Segure para editar o widget",
                dateString: ""
            )
        }
    }
}

struct ClinkWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(entry.icon)
                    .font(.system(size: 28))
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                Spacer()
                Image(systemName: "ellipsis")
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Spacer(minLength: 0)
            
            Text(entry.title)
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(1)
            
            if !entry.description.isEmpty {
                Text(entry.description)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.85))
                    .lineLimit(2)
            }
            
            if !entry.dateString.isEmpty {
                Text(entry.dateString)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 4)
                    .background(Color.black.opacity(0.25))
                    .cornerRadius(6)
                    .padding(.top, 2)
            }
        }
        .padding()
        .containerBackground(Color(hex: entry.colorHex) ?? Color.blue, for: .widget)
    }
}

private func allReminders() -> [ReminderEntity] {
    guard let sharedDefaults = UserDefaults(suiteName: "group.sampaio.clink.dados"),
          let data = sharedDefaults.data(forKey: "widget_shared_reminders") else {
        print("Widget: Não encontrou dados no App Group")
        return []
    }
    
    do {
        let reminders = try JSONDecoder().decode([Reminder].self, from: data)
        print("Widget: Carregou \(reminders.count) lembretes com sucesso!")
        
        return reminders.map { reminder in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM, HH:mm"
            let dateStr = reminder.dueDate != nil ? formatter.string(from: reminder.dueDate!) : ""
            
            return ReminderEntity(
                id: reminder.id.uuidString,
                title: reminder.title,
                colorHex: reminder.color.toHex(),
                description: reminder.description ?? "",
                dateString: dateStr
            )
        }
    } catch {
        print("Widget: Erro ao decodificar os lembretes: \(error)")
        return []
    }
}


    private func createEntry(for entity: ReminderEntity?) -> SimpleEntry {
        if let entity = entity {
            return SimpleEntry(
                date: Date(),
                title: entity.title,
                icon: "📌",
                colorHex: entity.colorHex,
                description: entity.description,
                dateString: entity.dateString
            )
        } else {
            let allRemindersCount = ReminderQuery().allReminders().count
            
            if allRemindersCount == 0 {
                return SimpleEntry(
                    date: Date(),
                    title: "Erro de Conexão",
                    icon: "⚠️",
                    colorHex: "FF3B30",
                    description: "O Widget não conseguiu ler os dados. Verifique o App Group.",
                    dateString: ""
                )
            } else {
                return SimpleEntry(
                    date: Date(),
                    title: "Lembrete Perdido",
                    icon: "❓",
                    colorHex: "FF9500",
                    description: "Selecione novamente. (Lembretes lidos: \(allRemindersCount))",
                    dateString: ""
                )
            }
        }
    }

@main
struct ClinkWidget: Widget {
    let kind: String = "ClinkWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: SelectReminderIntent.self, provider: Provider()) { entry in
            ClinkWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Lembrete Clink")
        .description("Tenha seus lembretes favoritos na tela inicial.")
    }
}
