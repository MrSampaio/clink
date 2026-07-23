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
                    Label("Lembretes", systemImage: "checkmark.circle")
                }
            
            AllListsView()
                .tabItem {
                    Label("Listas", systemImage: "pencil.and.list.clipboard")
                }
            
            CreateWidgetsView()
                .tabItem {
                    Label("Widget", systemImage: "widget.small.badge.plus")
                }
            
            ManageView()
                .tabItem {
                    Label("Gerenciar", systemImage: "gear")
                }
        }
    }
}

#Preview {
    TabViewComponent()
}
