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
    
    @State private var sortOrder: SortOrder = .newest
    @State private var showConcluded: Bool = true
    @State private var showLocked: Bool = false
    @State private var searchText = ""
    @State private var showSheetReminder = false
    
    var filteredIndices: [Int] {
        if searchText.isEmpty {
            return []
        } else {
            let matchingSearch = viewModel.reminders.indices.filter { index in
                let reminder = viewModel.reminders[index]
                let matchTitle = reminder.title.localizedCaseInsensitiveContains(searchText)
                let matchDescription = reminder.description?.localizedCaseInsensitiveContains(searchText) ?? false
                return matchTitle || matchDescription
            }
            return applyFilters(to: matchingSearch)
        }
    }
    
    private func applyFilters(to indices: [Int]) -> [Int] {
        return indices.filter { index in
            let reminder = viewModel.reminders[index]
            
            if !showConcluded && reminder.isCompleted { return false }
        
            if !showLocked && reminder.isLocked { return false }
            
            return true
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    
                    if searchText.isEmpty {
                        
                        let visibleCount = applyFilters(to: Array(viewModel.reminders.indices)).count
                        
                        Title(title: "Lembretes", subtitle: " \(visibleCount) lembretes criados!")
                            .padding(.bottom, 30)
                        
                        switch sortOrder {
                        case .newest:
                            DisclosureGroupComponent(title: "Hoje", indices: applyFilters(to: viewModel.todayRemindersIndices), reminders: $viewModel.reminders)
                            
                            DisclosureGroupComponent(title: "Esta semana", indices: applyFilters(to: viewModel.thisWeekRemindersIndices), reminders: $viewModel.reminders)
                            
                            DisclosureGroupComponent(title: "Este mês", indices: applyFilters(to: viewModel.thisMonthRemindersIndices), reminders: $viewModel.reminders)
                            
                            DisclosureGroupComponent(title: "Futuros", indices: applyFilters(to: viewModel.futureRemindersIndices), reminders: $viewModel.reminders)
                            
                            DisclosureGroupComponent(title: "Atrasados", indices: applyFilters(to: viewModel.overdueRemindersIndices), reminders: $viewModel.reminders)
                            
                        case .oldest:
                            DisclosureGroupComponent(title: "Atrasados", indices: applyFilters(to: viewModel.overdueRemindersIndices), reminders: $viewModel.reminders)
                            
                            DisclosureGroupComponent(title: "Este mês", indices: applyFilters(to: viewModel.thisMonthRemindersIndices), reminders: $viewModel.reminders)
                            
                            DisclosureGroupComponent(title: "Esta semana", indices: applyFilters(to: viewModel.thisWeekRemindersIndices), reminders: $viewModel.reminders)
                            
                            DisclosureGroupComponent(title: "Hoje", indices: applyFilters(to: viewModel.todayRemindersIndices), reminders: $viewModel.reminders)
                            
                            DisclosureGroupComponent(title: "Futuros", indices: applyFilters(to: viewModel.futureRemindersIndices), reminders: $viewModel.reminders)
                        }
                        
                    } else {
                        
                        if filteredIndices.isEmpty {
                            Text("Nenhum lembrete encontrado")
                                .frame(maxWidth: .infinity)
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
                HomeToolBar(
                    sortOrder: $sortOrder,
                    showConcluded: $showConcluded,
                    showLocked: $showLocked,
                    onTrashTapped: {
                        viewModel.managePickerSelection = 1
                        viewModel.selectedTab = 3
                    },
                    onAddTapped: {
                        showSheetReminder = true
                    }
                )
            }
            .searchable(text: $searchText, prompt: "Buscar lembretes...")
            .sheet(isPresented: $showSheetReminder) {
                SheetEditReminderView(list: nil, reminderToEdit: nil)
                    .presentationDragIndicator(.visible)
            }
            .onTapGesture {
                #if canImport(UIKit)
                    hideKeyboard()
                #endif
            }
            .scrollDismissesKeyboard(.interactively)
            
        }
    }
}
#Preview {
    HomeView()
        .environmentObject(ReminderViewModel())
}
