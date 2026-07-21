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
        DisclosureGroup() {
            ForEach(indices, id: \.self) { index in
                   ReminderCard(reminder: $reminders[index])
                       .padding(.top, 15)
            }
            
        } label: {
            Text("Hoje")
                .foregroundColor(Color(.font))
                .font(.system(size: 17, weight: .semibold))
               
                
        }
        .background(Color.black.opacity(0.05))
        .cornerRadius(12)
        
        Spacer()
    }
}

#Preview {
    struct DisclosurePreviewWrapper: View {
        @State var mockReminders = ReminderViewModel().reminders
        
        var body: some View {
            ScrollView {
                DisclosureGroupComponent(title: "Hoje", indices: [3, 2, 4] ,reminders: $mockReminders)
                    .padding()
            }
        }
    }
    
    return DisclosurePreviewWrapper()
}
