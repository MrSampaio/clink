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
            ZStack {
                LinearGradient(
                    stops: [
                        .init(color: list.color.opacity(0.7), location: 0.1),
                        .init(color: Color(.background), location: 0.7)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView{
                    LazyVStack(spacing: 16){
                        Title(title: list.title, subtitle: "\(viewModel.countReminders(for: list.id)) lembretes")
                        
                        if viewModel.countReminders(for: list.id) > 0{
                            ForEach(viewModel.remindersIndicesByList(for: list.id), id: \.self) { index in

                                ReminderCard(reminder: $viewModel.reminders[index])
                            }
                            
                        } else{
                            Spacer()
                            Text("Nenhum lembrete adicionado.")
                            // põe uma imagem do clink aqui pra não ficar vazio
                        }
                        
                    }
                    
                    .padding(16)
                }
                .toolbar {
                    SelectedListToolBar(displaySheet: $showSheetReminder, color: list.color)
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
    
    var list = ReminderList(id: 2, title: "Trabalho", color: .listColor2, icon: "briefcase.fill")
    
    ListView(list: list)
        .environmentObject(ReminderViewModel())
}
