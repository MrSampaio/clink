//
//  TabView.swift
//  Clink
//
//  Created by Julio Sampaio on 19/07/26.
//

import Foundation
import SwiftUI

public struct TabViewComponent: View {
    public init() {}
    
    public var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Label("Todos", systemImage: "checkmark.circle")
                }
            
            AllListsView()
                .tabItem {
                    Label("All Lists", systemImage: "pencil.and.list.clipboard")
                }
            
            CreateWidgetsView()
                .tabItem {
                    Label("Create", systemImage: "widget.small.badge.plus")
                }
            
            ManageView()
                .tabItem {
                    Label("Manage", systemImage: "gear")
                }
        }
    }
}

#Preview {
    TabViewComponent()
}
