//
//  ReminderViewModel.swift
//  Clink
//
//  Created by Julio Sampaio on 18/07/26.
//

import Foundation
import SwiftUI
import Combine

class ReminderViewModel: ObservableObject{
    @Published var customLists: [ReminderList] = [
        ReminderList(id: 1, title: "Geral", color: .blue, icon: "tray.fill"),
        ReminderList(id: 3, title: "Trabalho", color: .listColor1, icon: "briefcase.fill"),
        ReminderList(id: 2, title: "Estudos", color: .listColor2, icon: "graduationcap.fill"),
        ReminderList(id: 4, title: "Finanças", color: .listColor4, icon: "creditcard.fill"),
        ReminderList(id: 5, title: "Casa", color: .listColor9, icon: "house.fill"),
        ReminderList(id: 6, title: "Família", color: .listColor6, icon: "heart.fill")
    ]
    @Published var reminders: [Reminder] = [
        Reminder(
            listId: 1,
            isLocked: false,
            title: "Campanha",
            description: "Aprovar textos e layouts para os posts sobre economia circular e lixo eletrônico.",
            isCompleted: true,
            subtasks: [
                SubTask(title: "Revisar calendário de posts", isCompleted: true)
            ],
            dueDate: Date(), // Hoje
            isImportant: true,
            color: .listColor1,
            category: "Trabalho"
        ),
        Reminder(
            listId: 1,
            isLocked: true, // Deixei este como true para você testar o layout de trancado!
            title: "Otimizar banco Oracle SQL",
            description: "Verificar gargalos nas consultas e aplicar índices.",
            isCompleted: false,
            subtasks: [],
            dueDate: Date(timeIntervalSinceNow: 86400 * 4), // Esta semana
            isImportant: false,
            color: .listColor1,
            category: "Trabalho"
        ),
        Reminder(
            listId: 2,
            isLocked: false,
            title: "Revisão de Modelagem de Software",
            description: "Ler todos os tópicos centrais dos slides para a prova.",
            isCompleted: false,
            subtasks: [
                SubTask(title: "Revisar diagramas de classe", isCompleted: false)
            ],
            dueDate: Date(timeIntervalSinceNow: -86400 * 3), // Atrasado
            isImportant: true,
            color: .listColor2,
            category: "Estudos"
        ),
        Reminder(
            listId: 2,
            isLocked: false,
            title: "Layout do aplicativo",
            description: "Ajustar componentes customizados e bordas de input no SwiftUI.",
            isCompleted: false,
            subtasks: [],
            dueDate: Date(), // Hoje
            isImportant: true,
            color: .listColor2,
            category: "Estudos"
        ),
        Reminder(
            listId: 2,
            isLocked: false,
            title: "Prática de Estrutura de Dados",
            description: "Refazer os exercícios do último semestre.",
            isCompleted: false,
            subtasks: [],
            dueDate: Date(timeIntervalSinceNow: 86400 * 20), // Este mês
            isImportant: false,
            color: .listColor2,
            category: "Estudos"
        ),
        Reminder(
            listId: 3,
            isLocked: false,
            title: "Ligar para o filho",
            description: "Saber como estão as coisas e bater um papo.",
            isCompleted: false,
            subtasks: [],
            dueDate: Date(), // Hoje
            isImportant: true,
            color: .listColor3,
            category: "Geral"
        ),
        Reminder(
            listId: 3,
            isLocked: false,
            title: "Ajustar PC",
            description: "Testar compatibilidade da GPU e ver otimizações do AMD FSR 3.1.",
            isCompleted: false,
            subtasks: [],
            dueDate: Date(timeIntervalSinceNow: 86400 * 5), // Esta semana
            isImportant: false,
            color: .listColor3,
            category: "Geral"
        ),
        Reminder(
            listId: 3,
            isLocked: false,
            title: "Séries",
            description: "Verificar quando saem os novos episódios de Invincible e The Boys.",
            isCompleted: false,
            subtasks: [],
            dueDate: Date(timeIntervalSinceNow: 86400 * 15), // Este mês
            isImportant: false,
            color: .listColor3,
            category: "Geral"
        ),
        Reminder(
            listId: 4,
            isLocked: false,
            title: "App de Simulação Financeira",
            description: "Definir as perguntas guia da fase de investigação.",
            isCompleted: false,
            subtasks: [],
            dueDate: Date(timeIntervalSinceNow: -86400 * 1), // Atrasado
            isImportant: true,
            color: .listColor4,
            category: "Finanças"
        ),
        Reminder(
            listId: 4,
            isLocked: false,
            title: "Pagar fatura",
            description: "Acessar o aplicativo do banco para liberar o limite.",
            isCompleted: false,
            subtasks: [],
            dueDate: Date(timeIntervalSinceNow: 86400 * 2), // Esta semana
            isImportant: true,
            color: .listColor4,
            category: "Finanças"
        )
    ]
    
    @Published var deletedReminders: [Reminder] = [
        Reminder(
            listId: 1,
            isLocked: false,
            title: "Exemplo de lembrete apagado",
            description: "Esse aqui é só pra ver o lembrete apagado",
            isCompleted: true,
            subtasks: [],
            dueDate: Date(),
            isImportant: true,
            color: .listColor3,
            category: "Geral"
        ),
    ]
    
    @Published var selectedTab: Int = 0
    @Published var managePickerSelection: Int = 0
    
    // lembretes de hoje
    var todayRemindersIndices: [Int] {
        let indices = reminders.indices.filter { index in
            guard let date = reminders[index].dueDate else { return false }
            return Calendar.current.isDateInToday(date)
        }
        return indices.reversed()
    }
    
    // lembretes dessa semana
    var thisWeekRemindersIndices: [Int] {
        reminders.indices.filter { index in
            guard let date = reminders[index].dueDate else { return false }
            
            let isSameWeek = Calendar.current.isDate(date, equalTo: Date(), toGranularity: .weekOfYear)
            let isNotToday = !Calendar.current.isDateInToday(date)
            
            return isSameWeek && isNotToday
        }
    }
    
    // lembretes desse mês
    var thisMonthRemindersIndices: [Int] {
        reminders.indices.filter { index in
            
            guard let date = reminders[index].dueDate else { return false }
            
            // testa se é do mesmo mês
            let isSameMonth = Calendar.current.isDate(date, equalTo: Date(), toGranularity: .month)
            // remove os que já apareceram essa semana (acaba tirando os de "hoje" também)
            let isNotThisWeek = !Calendar.current.isDate(date, equalTo: Date(), toGranularity: .weekOfYear)
            
            return isSameMonth && isNotThisWeek
        }
    }
    
    // lembretes atrasados
    var overdueRemindersIndices: [Int] {
        let startOfToday = Calendar.current.startOfDay(for: Date())
        return reminders.indices.filter { index in
            guard let date = reminders[index].dueDate else { return false }
            
            return date < startOfToday && !reminders[index].isCompleted
        }
    }
    
    var futureRemindersIndices: [Int] {
        let now = Date()
        let indices = reminders.indices.filter { index in
            guard let date = reminders[index].dueDate else { return false }
            
            let isFuture = date > now
            
            let isNotThisMonth = !Calendar.current.isDate(date, equalTo: now, toGranularity: .month)
            let isNotThisWeek = !Calendar.current.isDate(date, equalTo: now, toGranularity: .weekOfYear)
            
            return isFuture && isNotThisMonth && isNotThisWeek
        }
        return indices.reversed()
    }
    
    var concludedRemindersIndices: [Int] {
        let indices = reminders.indices.filter { reminders[$0].isCompleted }
        
        return indices.reversed()
    }
    
    var lockedRemindersIndices: [Int] {
        let indices = reminders.indices.filter { reminders[$0].isLocked }
        
        return indices.reversed()
    }
    
    var totalReminders: Int {
        reminders.count
    }
    
    var totalLists: Int {
        customLists.count
    }
    
    var totalCompletedReminders: Int {
        reminders.filter { $0.isCompleted }.count
    }
    
    // MARK: esses são os filtros por listas individuais
    
    func remindersIndicesByList(for listId: Int) -> [Int] {
        let indices = reminders.indices.filter { reminders[$0].listId == listId }
        return indices.reversed()
        
    }
    
    // cálculos para o ListComponent
    
    func countReminders(for listId: Int) -> Int {
        reminders.filter { $0.listId == listId }.count
    }
    
    func countCompletedReminders(for listId: Int) -> Int {
        reminders.filter { $0.listId == listId && $0.isCompleted }.count
    }
    
    func completionPercentage(for listId: Int) -> Int {
        let total = countReminders(for: listId)
        if total == 0 { return 0 }
        
        let completed = countCompletedReminders(for: listId)
        let percentage = (Double(completed) / Double(total)) * 100
        return Int(percentage)
    }
    
    // MARK: funções para criar/editar lembretes e listas
    
    func addNewList(id: Int, title: String, color: Color, icon: String) {
        let newList = ReminderList(id: id, title: title, color: color, icon: icon)
        customLists.append(newList)
    }
    
    func addNewReminder(listId: Int, isLocked: Bool, title: String, description: String?, subtasks: [SubTask]?, dueDate: Date?, isImportant: Bool) -> Reminder?{
        
        guard let getListTitle = customLists.first(where: { $0.id == listId })?.title else { return nil }
        guard let getListColor = customLists.first(where: { $0.id == listId })?.color else { return nil }
        
        let newReminder = Reminder(
            listId: listId,
            isLocked: isLocked,
            title: title,
            description: (description?.isEmpty == true) ? nil : description,
            isCompleted: false,
            subtasks: subtasks?.isEmpty == true ? nil : subtasks,
            dueDate: (dueDate != nil) ? dueDate : Date(),
            isImportant: isImportant,
            color: getListColor,
            category: getListTitle
        )
        
        reminders.append(newReminder)
        return newReminder
    }
    
    func updateReminder(id: UUID, listId: Int, isLocked: Bool, title: String, description: String, subtasks: [SubTask]?, dueDate: Date?, isImportant: Bool) {
            
        if let index = reminders.firstIndex(where: { $0.id == id }) {
            
            let newListTitle = customLists.first(where: { $0.id == listId })?.title ?? "Geral"
            let newListColor = customLists.first(where: { $0.id == listId })?.color ?? .blue
            
            // atualiza as propriedades do lembrete
            reminders[index].listId = listId
            reminders[index].title = title
            reminders[index].description = description.isEmpty ? nil : description
            reminders[index].isLocked = isLocked
            reminders[index].subtasks = subtasks?.isEmpty == true ? nil : subtasks
            reminders[index].dueDate = dueDate
            reminders[index].isImportant = isImportant
            reminders[index].category = newListTitle
            reminders[index].color = newListColor
        }
    }
    
    func deleteReminder(id: UUID) {
        if let reminderToDelete = reminders.first(where: { $0.id == id }) {
            deletedReminders.insert(reminderToDelete, at: 0)
            
            reminders.removeAll(where: { $0.id == id })
        }
    }
    
    func createNewList(title: String, color: Color, icon: String) {
        let newId = (customLists.map { $0.id }.max() ?? 0) + 1
        
        let newList = ReminderList(
            id: newId,
            title: title,
            color: color,
            icon: icon
        )
        
        customLists.append(newList)
    }
    
    func updateList(id: Int, title: String, color: Color, icon: String) {
        if let index = customLists.firstIndex(where: { $0.id == id }) {
            customLists[index].title = title
            customLists[index].color = color
            customLists[index].icon = icon
            
            for i in reminders.indices where reminders[i].listId == id {
                reminders[i].category = title
                reminders[i].color = color
            }
        }
    }
    
    func deleteList(id: Int) {
        let remindersToDelete = reminders.filter { $0.listId == id }
        
        deletedReminders.insert(contentsOf: remindersToDelete, at: 0)
        
        reminders.removeAll(where: { $0.listId == id })
        
        customLists.removeAll(where: { $0.id == id })
    }
    
    
    func filteredAndSortedLists(searchText: String, sortOrder: ListSortOrder) -> [ReminderList] {
        var result = customLists
        
        if !searchText.isEmpty {
            result = result.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
        
        switch sortOrder {
        case .alphabetical:
            result.sort { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
        case .creation:
            result.reverse()
        }
        
        return result
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

// ----------------------- futuras funções para criar lembretes e listas---------------

//    @Published var customLists: [ReminderList] = []
//    @Published var reminders: [Reminder] = []

//

//
//    }

// -------------------------------------------------------------------------


//
//struct RemindersListView: View {
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 16) {
//
//                ForEach($reminders) { $reminder in
//
//                    if Calendar.current.isDateInToday(reminder.dueDate) {
//                        ReminderCard(reminder: $reminder)
//                    }
//
//                }
//            }
//            .padding()
//        }
//        .background(Color.white.edgesIgnoringSafeArea(.all))
//    }
//}
//
//#Preview {
//    RemindersListView()
//}
