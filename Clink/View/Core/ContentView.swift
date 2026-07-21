//
//  ContentView.swift
//  Clink
//
//  Created by Julio Sampaio on 18/07/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var reminderViewModel = ReminderViewModel()
    
    var body: some View {
        TabViewComponent()
            .environmentObject(reminderViewModel)
    }
}

#Preview {
    ContentView()
}
