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
                Title(title: "Todos", subtitle: " \(viewModel.totalReminders) lembretes")
                    .padding(.bottom, 30)
                
                VStack(spacing: 10){

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
                }

            }
            .padding(.horizontal, 25)
            .background(Color(.background))
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(ReminderViewModel())
}
