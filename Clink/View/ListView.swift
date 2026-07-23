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

    var body: some View {
        NavigationStack {
            ScrollView{
                VStack {
                    Title(title: list.title, subtitle: nil)
                    
                    ForEach(viewModel.remindersIndicesByList(for: list.id), id: \.self) { index in

                        ReminderCard(reminder: $viewModel.reminders[index])
                    }
                }
                
                .padding(16)
                
                .toolbar {
                    SelectedListToolBar(displaySheet: $showSheetReminder)
                }
                
                .sheet(isPresented: $showSheetReminder) {
                    SheetEditView()
                        .presentationDragIndicator(.visible)
                }
                
            }
            .background(Color(.background))
            
        }
    }
}

#Preview {
    
    var list = ReminderList(id: 2, title: "Trabalho", color: .listColor1, icon: "briefcase.fill")
    
    ListView(list: list)
        .environmentObject(ReminderViewModel())
}
