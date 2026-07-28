import WidgetKit
import SwiftUI

// MARK: - 1. A Entry (O "Pacote" de Dados)
// Agora ela carrega todas as informações que o Widget precisa!
struct SimpleEntry: TimelineEntry {
    let date: Date
    let title: String
    let icon: String
    let colorHex: String
    let description: String
    let dateString: String
}

// MARK: - 2. O Provider (O Motor)
struct Provider: TimelineProvider {
    
    // Função auxiliar para ler os dados do App Group e montar o pacote (Entry)
    private func fetchEntry(for date: Date) -> SimpleEntry {
        // Lemos os dados uma única vez aqui no motor!
        let defaults = UserDefaults.sharedWidget
        
        let title = defaults?.string(forKey: "widgetTitle") ?? "Nenhum lembrete"
        let icon = defaults?.string(forKey: "widgetIcon") ?? "📌"
        let colorHex = defaults?.string(forKey: "widgetColorHex") ?? "2196F3"
        let description = defaults?.string(forKey: "widgetDescription") ?? ""
        let dateString = defaults?.string(forKey: "widgetDate") ?? ""
        
        return SimpleEntry(
            date: date,
            title: title,
            icon: icon,
            colorHex: colorHex,
            description: description,
            dateString: dateString
        )
    }

    func placeholder(in context: Context) -> SimpleEntry {
        fetchEntry(for: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = fetchEntry(for: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        // Quando você aperta o botão no app e chama o "reloadAllTimelines",
        // o iOS cai exatamente aqui. Ele vai ler os dados frescos e gerar a tela!
        let entry = fetchEntry(for: Date())
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

// MARK: - 3. A View (A Interface)
struct ClinkWidgetEntryView : View {
    var entry: Provider.Entry
    
    // NOTA: Removemos todos os @AppStorage daqui! A view agora é limpa e
    // apenas desenha o que recebe da variável 'entry'.

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            HStack {
                Text(entry.icon) // <-- Usando entry.icon
                    .font(.system(size: 28))
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Spacer(minLength: 0)
            
            Text(entry.title) // <-- Usando entry.title
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(1)
            
            if !entry.description.isEmpty { // <-- Usando entry.description
                Text(entry.description)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.85))
                    .lineLimit(2)
            }
            
            if !entry.dateString.isEmpty { // <-- Usando entry.dateString
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
        // <-- Usando entry.colorHex
        .containerBackground(Color(hex: entry.colorHex), for: .widget)
    }
}

// MARK: - 4. Configuração Principal
@main
struct ClinkWidget: Widget {
    let kind: String = "ClinkWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ClinkWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Lembrete Clink")
        .description("Tenha seu lembrete favorito sempre na tela inicial.")
    }
}

// A sua extensão continua igual, certifique-se apenas de que o nome
// do App Group aqui é o mesmo que você colocou na aba de Capabilities (ex: group.sampaio.clink.dados)
extension UserDefaults {
    static let sharedWidget = UserDefaults(suiteName: "group.sampaio.clink.dados")
}
