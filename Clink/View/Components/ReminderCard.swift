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
                CheckBox(isMarked: $reminder.isCompleted, color: reminder.color)
                    .frame(width: 24, height: 24)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(reminder.title)
                        .font(.headline)
                        .foregroundColor(.font)
                    
                    Text(reminder.description)
                        .font(.subheadline)
                        .foregroundColor(.font)
                }
                
                Spacer()
                
                Image(systemName: "info.circle")
                    .foregroundColor(Color(reminder.color))
                    .font(.title3)
            }
            
            if let subtasksBinding = Binding($reminder.subtasks), !subtasksBinding.wrappedValue.isEmpty{
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(subtasksBinding) { $subtask in
                        HStack(spacing: 12) {
                            CheckBox(isMarked: $subtask.isCompleted, color: reminder.color)
                                .frame(width: 24, height: 24)
                            
                            Text(subtask.title)
                                .font(.subheadline)
                                .foregroundColor(.font)
                        }
                    }
                }
                .padding(.leading, 36)
            }
            
            Divider()
                .background(Color(.gray))
            
            HStack {
                BadgeView(text: reminder.dueDate.formatted(date: .abbreviated, time: .omitted), color: reminder.color, icon: nil)
                BadgeView(text: reminder.dueDate.formatted(date: .omitted, time: .shortened), color: reminder.color, icon: nil)
                BadgeView(text: reminder.category, color: reminder.color, icon: "briefcase.fill")
                
                Spacer()
                
                if reminder.isImportant{
                    Image(systemName: "flag.fill")
                        .foregroundColor(Color(.red))
                }
                
            }
        }
        .padding(25)
        .background(Color(.cardBackground))
        .cornerRadius(30)
    }
}

#Preview {
    struct ReminderCardPreviewWrapper: View {
        @State var mockReminder = Reminder(
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
        )
        
        var body: some View {
            
            VStack{
                ReminderCard(reminder: $mockReminder)
                    .padding()
            }
            .frame(maxHeight: .infinity)
            .background(Color(.background))
            
        }
    }
    
    return ReminderCardPreviewWrapper()
}
