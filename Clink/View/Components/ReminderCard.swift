//
//  ReminderCard.swift
//  Clink
//
//  Created by Julio Sampaio on 18/07/26.
//

import Foundation
import SwiftUI

struct ReminderCard: View {
    @Binding var reminder: Reminder
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            HStack(alignment: .top, spacing: 12) {
                CheckBox(isMarked: $reminder.isCompleted, color: .purple)
                    .frame(width: 24, height: 24)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(reminder.title)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(reminder.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "info.circle")
                    .foregroundColor(Color(.purple))
                    .font(.title3)
            }
            
            if reminder.subtasks.isEmpty == false {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach($reminder.subtasks) { $subtask in
                        HStack(spacing: 12) {
                            CheckBox(isMarked: $subtask.isCompleted, color: .purple)
                                .frame(width: 24, height: 24)
                            
                            Text(subtask.title)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.leading, 36)
            }
            
            Divider()
                .background(Color(.gray))
            
            HStack {
                BadgeView(text: reminder.dueDate.formatted(date: .abbreviated, time: .omitted), color: .purple, icon: nil)
                BadgeView(text: reminder.dueDate.formatted(date: .omitted, time: .shortened), color: .purple, icon: nil)
                BadgeView(text: reminder.category, color: .purple, icon: "briefcase.fill")
                
                Spacer()
                
                Image(systemName: "flag.fill")
                    .foregroundColor(Color(.purple))
            }
        }
        .padding(25)
        .background(Color(.black))
        .cornerRadius(30)
    }
}

#Preview {
    struct ReminderCardPreviewWrapper: View {
        @State var mockReminder = Reminder(
            title: "Enviar relatório",
            description: "Terminar o projeto e enviar o relatório",
            isCompleted: false,
            subtasks: [
                SubTask(title: "Falar com o chefe", isCompleted: true)
            ],
            dueDate: Date(),
            category: "Trabalho"
        )
        
        var body: some View {
            ReminderCard(reminder: $mockReminder)
                .padding()
        }
    }
    
    return ReminderCardPreviewWrapper()
}
