//
//  ClinkApp.swift
//  Clink
//
//  Created by Julio Sampaio on 18/07/26.
//

import SwiftUI

@main
struct ClinkApp: App {
    @StateObject var reminderViewModel = ReminderViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(reminderViewModel)
        }
    }
}
