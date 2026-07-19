//
//  ReminderViewModel.swift
//  Clink
//
//  Created by Julio Sampaio on 18/07/26.
//

import Foundation
import SwiftUI

struct RemindersListView: View {
    @State private var reminders: [Reminder] = [
        Reminder(
            title: "Enviar relatório",
            description: "Terminar o projeto e enviar o relatorio",
            isCompleted: false,
            subtasks: [
                SubTask(title: "Falar com o chefe", isCompleted: true)
            ],
            dueDate: Date(),
            category: "Trabalho"
        ),
        
        Reminder(
            title: "Enviar relatório",
            description: "Terminar o projeto e enviar o relatorio",
            isCompleted: false,
            subtasks: [
                SubTask(title: "Falar com o chefe", isCompleted: true)
            ],
            dueDate: Date(),
            category: "Trabalho"
        ),
        
        Reminder(
            title: "Enviar relatório",
            description: "Terminar o projeto e enviar o relatorio",
            isCompleted: false,
            subtasks: [
                SubTask(title: "Falar com o chefe", isCompleted: true)
            ],
            dueDate: Date(),
            category: "Trabalho"
        ),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach($reminders) { $reminder in
                    ReminderCard(reminder: $reminder)
                }
            }
            .padding()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all)) 
    }
}

#Preview {
    RemindersListView()
}
