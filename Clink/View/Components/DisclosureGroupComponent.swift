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
    let indices: [Int]
    @State var isExpanded: Bool = true
    @Binding var reminders: [Reminder]
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            
            if !indices.isEmpty{
                ForEach(indices, id: \.self) { index in
                       ReminderCard(reminder: $reminders[index])
                           .padding(.top, 15)
                }
            } else{
                Text("Nenhum lembrete.")
            }
            
            
        } label: {
            Text(title)
                .foregroundColor(Color(.font))
                .font(.system(size: 17, weight: .semibold))
        }
        //.background(Color(.cardBackground))
        .cornerRadius(12)
        
        Spacer()
    }
}

#Preview {
    struct DisclosurePreviewWrapper: View {
        @State var mockReminders = ReminderViewModel().reminders
        
        var body: some View {
            ScrollView {
                DisclosureGroupComponent(title: "Hoje", indices: [1, 5, 7] ,reminders: $mockReminders)
                    .padding()
            }
        }
    }
    
    return DisclosurePreviewWrapper()
}
