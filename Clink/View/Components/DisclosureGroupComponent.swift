//
//  DisclosureGroupComponent.swift
//  Clink
//
//  Created by Julio Sampaio on 19/07/26.
//

import Foundation
import SwiftUI


struct DisclosureGroupComponent: View {
    
    // depois tira a variavel de ambiente
   
//    @EnvironmentObject var viewModel: ReminderViewModel
    let title: String
    @State var isExpanded: Bool = true
    @Binding var reminders: [Reminder]
    
    var body: some View {
        DisclosureGroup() {
            ForEach($reminders) { $reminder in
                ReminderCard(reminder: $reminder)
                    .padding(.top, 15)
            }
            
        } label: {
            Text("Hoje")
                .foregroundColor(Color(.font))
                .font(.system(size: 17, weight: .semibold))
               
                
        }
        .padding()
        .background(Color.black.opacity(0.05))
        .cornerRadius(12)
        
        Spacer()
    }
}

#Preview {
    struct DisclosurePreviewWrapper: View {
        // Criamos um estado falso puxando os dados do seu ViewModel
        @State var mockReminders = ReminderViewModel().reminders
        
        var body: some View {
            ScrollView {
                // Passamos a lista usando o $
                DisclosureGroupComponent(title: "Hoje", reminders: $mockReminders)
                    .padding()
            }
        }
    }
    
    return DisclosurePreviewWrapper()
}
