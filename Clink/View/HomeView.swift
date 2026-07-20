//
//  HomeView.swift
//  Clink
//
//  Created by Julio Sampaio on 19/07/26.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @State private var isExpanded = false
    
    @EnvironmentObject var viewModel: ReminderViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView{

                VStack{
                    Title(title: "Todos", subtitle: "x lembretes")
                        .padding(.bottom, 30)
                    
                    ForEach($viewModel.reminders) { $reminder in
                        
                        if Calendar.current.isDateInToday(reminder.dueDate) {
                            
                        }
                    }
                
                DisclosureGroupComponent(title: "Hoje", reminders: $viewModel.reminders)
                    
                }

            }
            .padding(.horizontal, 25)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(ReminderViewModel())
}
