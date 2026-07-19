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
        
        VStack(alignment: .leading, spacing: 16){
            HStack(alignment: .center, spacing: 12){
                CheckBox(isMarked: $reminder.isCompleted, color: .purple)
                    .frame(height: 24)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(reminder.title)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(reminder.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
//        VStack{
//            HStack{
//                //CheckBox(isMarked: Binding<Bool>, color: .red)
//            }
//            Text("to testando um texto bem longo")
//        }
//        .frame(maxWidth: .infinity)
//        .frame(height: 200)
//        .background(Color(.black))
//        .cornerRadius(30)
//        .foregroundColor(Color(.blue))
//        .padding(.leading, 20)
//        .padding(.trailing, 20)
//        
//        VStack{
//            Text("Hello, World!")
//        }
    }
}

#Preview {
    ReminderCard(reminder: .constant(
        Reminder(
            title: "Enviar relatório",
            description: "Terminar o projeto e enviar o relatório",
            isCompleted: false,
            subtasks: [
                SubTask(title: "Falar com o chefe", isCompleted: true)
            ],
            date: "27 Jun 2026",
            time: "15:00",
            category: "Trabalho"
        )
    ))
}
