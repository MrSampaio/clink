//
//  TabView.swift
//  Clink
//
//  Created by Julio Sampaio on 19/07/26.
//

import Foundation
import SwiftUI

public struct TabViewComponent: View {
    @EnvironmentObject var viewModel: ReminderViewModel
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $viewModel.selectedTab){
            HomeView()
                    .tabItem {
                        Label("Lembretes", systemImage: "checkmark.circle")
                    }
                    .tag(0)
            
            AllListsView()
                .tabItem {
                    Label("Listas", systemImage: "pencil.and.list.clipboard")
                }
                .tag(1)
            
            CreateWidgetsView()
                .tabItem {
                    Label("Widgets", systemImage: "widget.small.badge.plus")
                }
                .tag(2)
            
            ManageView()
                .tabItem {
                    Label("Gerenciar", systemImage: "gear")
                }
                .tag(3)
            }
        }
    }

#Preview {
    TabViewComponent()
        .environmentObject(ReminderViewModel())
}
