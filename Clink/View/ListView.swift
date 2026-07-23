//
//  ListView.swift
//  Clink
//
//  Created by Julio Sampaio on 19/07/26.
//

import Foundation
import SwiftUI

struct ListView: View {
    @State private var showSheetReminder = false
    @EnvironmentObject var viewModel: ReminderViewModel
    
    let list: ReminderList
    
    var listRemindersIndices: [Int] {
        viewModel.reminders.indices.filter {
            viewModel.reminders[$0].listId == list.id
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView{
                VStack {
                    //Title(title: title, subtitle: nil)
                    
                    ForEach(listRemindersIndices, id: \.self) { index in
                        // Passando o Binding ($) direto da fonte de verdade
                        ReminderCard(reminder: $viewModel.reminders[index])
                    }
                }
                .toolbar {
                    SelectedListToolBar(displaySheet: $showSheetReminder)
                }
                .sheet(isPresented: $showSheetReminder) {
                    SheetEditView()
                        .presentationDragIndicator(.visible)
                }
            }
            
        }
    }
}

#Preview {
    
    var list = ReminderList(id: 3, title: "Trabalho", color: .listColor1, icon: "briefcase.fill")
    
    ListView(list: list)
        .environmentObject(ReminderViewModel())
}
