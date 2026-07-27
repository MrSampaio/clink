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
    
    @State private var searchText = ""
    
    var filteredIndices: [Int] {
        if searchText.isEmpty {
            return []
        } else {
            return viewModel.reminders.indices.filter { index in
                let reminder = viewModel.reminders[index]
                let matchTitle = reminder.title.localizedCaseInsensitiveContains(searchText)
                let matchDescription = reminder.description?.localizedCaseInsensitiveContains(searchText) ?? false
                
                return matchTitle || matchDescription
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView{
                
                VStack(spacing: 10){
                    
                    if searchText.isEmpty {
                    
                        Title(title: "Lembretes", subtitle: " \(viewModel.totalReminders) lembretes")
                            .padding(.bottom, 30)
                        
                        DisclosureGroupComponent(
                            title: "Hoje",
                            indices: viewModel.todayRemindersIndices,
                            reminders: $viewModel.reminders
                        )
                        
                        DisclosureGroupComponent(
                            title: "Esta Semana",
                            indices: viewModel.thisWeekRemindersIndices,
                            reminders: $viewModel.reminders
                        )
                        
                        DisclosureGroupComponent(
                            title: "Este Mês",
                            indices: viewModel.thisMonthRemindersIndices,
                            reminders: $viewModel.reminders
                        )
                        
                        DisclosureGroupComponent(
                            title: "Atrasados",
                            indices: viewModel.overdueRemindersIndices,
                            reminders: $viewModel.reminders
                        )
                    } else {
                        if filteredIndices.isEmpty {
                            Text("Nenhum lembrete encontrado.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(.top, 40)
                        } else {
                            ForEach(filteredIndices, id: \.self) { index in
                                ReminderCard(reminder: $viewModel.reminders[index])
                                    .padding(.vertical, 5)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .background(Color(.background))
            .toolbar {
                HomeToolBar()
            }
            .searchable(text: $searchText, prompt: "Buscar lembretes...")
            
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(ReminderViewModel())
}
