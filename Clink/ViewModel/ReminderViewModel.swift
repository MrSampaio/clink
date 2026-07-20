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
    
    @Published var reminders: [Reminder] = [
        Reminder(
                title: "Enviar relatório",
                description: "Terminar o projeto e enviar o relatorio",
                isCompleted: false,
                subtasks: [
                    SubTask(title: "Falar com o chefe", isCompleted: true),
                    SubTask(title: "Anexar planilhas", isCompleted: false)
                ],
                dueDate: Date(),
                isImportant: true,
                category: "Trabalho",
                color: .blue
            ),
            Reminder(
                title: "Comprar mantimentos",
                description: "Ir ao mercado comprar itens da semana",
                isCompleted: false,
                subtasks: [
                    SubTask(title: "Fazer a lista de compras", isCompleted: true),
                    SubTask(title: "Passar no açougue", isCompleted: false)
                ],
                dueDate: Date(),
                isImportant: false,
                category: "Casa",
                color: .listColor1
            ),
            Reminder(
                title: "Pagar conta de luz",
                description: "O boleto vence hoje, pagar pelo app do banco",
                isCompleted: true,
                subtasks: [],
                dueDate: Date(), // Hoje
                isImportant: true,
                category: "Financeiro",
                color: .listColor2
            ),
            
            // MARK: - Semana Anterior
            Reminder(
                title: "Reunião de alinhamento",
                description: "Discutir os próximos passos do projeto",
                isCompleted: true,
                subtasks: [
                    SubTask(title: "Preparar os slides", isCompleted: true)
                ],
                dueDate: Date(timeIntervalSinceNow: -86400 * 3),
                isImportant: true,
                category: "Trabalho",
                color: .listColor3
            ),
            Reminder(
                title: "Limpar a casa",
                description: "Faxina geral de fim de semana",
                isCompleted: true,
                subtasks: [
                    SubTask(title: "Tirar o lixo", isCompleted: true),
                    SubTask(title: "Lavar o banheiro", isCompleted: true)
                ],
                dueDate: Date(timeIntervalSinceNow: -86400 * 6), // 6 dias atrás
                isImportant: false,
                category: "Casa",
                color: .listColor4
            ),
            Reminder(
                title: "Dentista",
                description: "Consulta de rotina para limpeza",
                isCompleted: true,
                subtasks: [],
                dueDate: Date(timeIntervalSinceNow: -86400 * 7), // 7 dias atrás
                isImportant: true,
                category: "Saúde",
                color: .listColor5
            ),
            
            Reminder(
                title: "Estudar SwiftUI",
                description: "Finalizar o módulo de animações e transições",
                isCompleted: false,
                subtasks: [
                    SubTask(title: "Ler a documentação", isCompleted: false),
                    SubTask(title: "Fazer o exercício prático", isCompleted: false)
                ],
                dueDate: Date(timeIntervalSinceNow: 86400 * 4),
                isImportant: true,
                category: "Estudos",
                color: .listColor6
            ),
            Reminder(
                title: "Renovar seguro do carro",
                description: "Falar com o corretor sobre a nova apólice",
                isCompleted: true,
                subtasks: [
                    SubTask(title: "Enviar documentos", isCompleted: true)
                ],
                dueDate: Date(timeIntervalSinceNow: -86400 * 15),
                isImportant: true,
                category: "Carro",
                color: .listColor7
            ),
            Reminder(
                title: "Aniversário de fulano",
                description: "Comprar presente e confirmar presença na festa",
                isCompleted: false,
                subtasks: [
                    SubTask(title: "Comprar presente", isCompleted: false)
                ],
                dueDate: Date(timeIntervalSinceNow: 86400 * 12),
                isImportant: false,
                category: "Pessoal",
                color: .listColor2
            ),
            Reminder(
                title: "Publicar App na Store",
                description: "Subir a versão de produção no App Store Connect",
                isCompleted: false,
                subtasks: [
                    SubTask(title: "Gerar os certificados", isCompleted: false),
                    SubTask(title: "Tirar novas screenshots", isCompleted: false),
                    SubTask(title: "Enviar para revisão", isCompleted: false)
                ],
                dueDate: Date(timeIntervalSinceNow: 86400 * 20),
                isImportant: true,
                category: "Trabalho",
                color: .listColor9
            )
    ]
    
    var todayReminders: [Reminder]{
        reminders.filter { reminder in
        Calendar.current.isDateInToday(reminder.dueDate)
        }
    }

    var overdueReminders: [Reminder]{
        reminders.filter { reminder in
            let startOfToday = Calendar.current.startOfDay(for: Date())
            return reminder.dueDate < startOfToday && !reminder.isCompleted
        }
    }
    
}
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
