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
        ReminderList(id: 1, title: "Trabalho", color: .listColor1),
        ReminderList(id: 2, title: "Estudos", color: .listColor2),
        ReminderList(id: 3, title: "Geral", color: .listColor3),
        ReminderList(id: 4, title: "Finanças", color: .listColor4),
    ]
    @Published var reminders: [Reminder] = [
        Reminder(
            listId: 1,
            title: "Campanha",
            description: "Aprovar textos e layouts para os posts sobre economia circular e lixo eletrônico.",
            isCompleted: false,
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
    
    // lembretes de hoje
    var todayRemindersIndices: [Int] {
        reminders.indices.filter {
            Calendar.current.isDateInToday(reminders[$0].dueDate)
        }
    }
    
    // lembretes dessa semana
    var thisWeekRemindersIndices: [Int] {
        reminders.indices.filter {
            // testa se é da mesma semana
            let isSameWeek = Calendar.current.isDate(reminders[$0].dueDate, equalTo: Date(), toGranularity: .weekOfYear)
            // remove os que já apareceram nos lembretes do dia
            let isNotToday = !Calendar.current.isDateInToday(reminders[$0].dueDate)
            
            return isSameWeek && isNotToday
        }
    }
    
    // lembretes desse mês
    var thisMonthRemindersIndices: [Int] {
        reminders.indices.filter {
            // testa se é do mesmo mês
            let isSameMonth = Calendar.current.isDate(reminders[$0].dueDate, equalTo: Date(), toGranularity: .month)
            // remove os que já apareceram essa semana (acaba tirando os de "hoje" também)
            let isNotThisWeek = !Calendar.current.isDate(reminders[$0].dueDate, equalTo: Date(), toGranularity: .weekOfYear)
            
            return isSameMonth && isNotThisWeek
        }
    }
    
    // lembretes atrasados
    var overdueRemindersIndices: [Int] {
        let startOfToday = Calendar.current.startOfDay(for: Date())
        return reminders.indices.filter {
            reminders[$0].dueDate < startOfToday && !reminders[$0].isCompleted
        }
    }
    
    var totalReminders: Int {
        reminders.count
    }
    
}
    
    // ----------------------- futuras funções para criar lembretes e listas---------------
    
//    @Published var customLists: [ReminderList] = []
//    @Published var reminders: [Reminder] = []
//    func addNewList(title: String, color: Color) {
//        let newList = ReminderList(id: Int, title: title, color: color)
//        customLists.append(newList)
//    }
//    
//    
//        
//    func addNewReminder(title: String, description: String, listId: Int, dueDate: Date, isImportant: Bool, color: Color) {
//        let newReminder = Reminder(
//            listId: listId,
//            title: title,
//            description: description,
//            isCompleted: false,
//            subtasks: [],
//            dueDate: dueDate,
//            isImportant: isImportant,
//            color: color
//        )
//        reminders.append(newReminder)
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
