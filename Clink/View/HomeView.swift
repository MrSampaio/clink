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
                    
                    DisclosureGroupComponent(
                            title: "Hoje",
                            indices: viewModel.todayIndices,
                            reminders: $viewModel.reminders
                    )
                    DisclosureGroupComponent(
                        title: "Esta Semana",
                        indices: viewModel.thisWeekIndices,
                        reminders: $viewModel.reminders
                    )
                    DisclosureGroupComponent(
                        title: "Este Mês",
                        indices: viewModel.thisMonthIndices,
                        reminders: $viewModel.reminders
                    )
                    DisclosureGroupComponent(
                        title: "Atrasados",
                        indices: viewModel.overdueIndices,
                        reminders: $viewModel.reminders
                    )
//
//                    DisclosureGroupComponent(
//                        title: "Hoje",
//                        reminders: $viewModel.todayReminders
//                    )
                
//                DisclosureGroupComponent(title: "Hoje", reminders: $viewModel.reminders)
                    
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
