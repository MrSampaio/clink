//
//  ReminderCard.swift
//  Clink
//
//  Created by Julio Sampaio on 18/07/26.
//

import Foundation
import SwiftUI

struct ReminderCard: View {
    @EnvironmentObject var viewModel: ReminderViewModel
    @Binding var reminder: Reminder
    
    @StateObject private var securityVM = SecurityViewModel()
    
    @State private var showEditSheet = false
    @State private var showDeleteAlert = false
    var enableEdit: Bool = true
    
    var forceUnlock: Bool = false
    
    var isContentVisible: Bool {
        !reminder.isLocked || forceUnlock || securityVM.isAuthenticated
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if isContentVisible {

                HStack(alignment: .top, spacing: 12) {
                    CheckBox(isMarked: $reminder.isCompleted, color: reminder.color)
                        .frame(width: 24, height: 24)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(reminder.title)
                            .font(.headline)
                            .foregroundColor(.font)
                        
                        Text(reminder.description ?? "")
                            .font(.subheadline)
                            .foregroundColor(.font)
                    }
                    
                    Spacer()
                    
                    if enableEdit {
                        Button(action: { showEditSheet = true }) {
                            Image(systemName: "info.circle")
                                .foregroundColor(reminder.color)
                                .font(.system(size: 22, weight: .bold))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                if let subtasksBinding = Binding($reminder.subtasks), !subtasksBinding.wrappedValue.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(subtasksBinding) { $subtask in
                            HStack(spacing: 12) {
                                CheckBox(isMarked: $subtask.isCompleted, color: reminder.color)
                                    .frame(width: 24, height: 24)
                                
                                Text(subtask.title)
                                    .font(.subheadline)
                                    .foregroundColor(.font)
                            }
                        }
                    }
                    .padding(.leading, 36)
                }
                
            } else {
                
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "lock.fill")
                        .foregroundColor(reminder.color)
                        .font(.system(size: 25, weight: .bold))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Lembrete trancado")
                            .font(.headline)
                            .foregroundColor(.font)
                        
                        Text("Toque para desbloquear o conteúdo")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    securityVM.authenticate()
                }
            }
            
            Divider()
                .background(Color(.gray))
            
            HStack {
                if let safeDate = reminder.dueDate {
                    BadgeView(text: safeDate.formatted(date: .abbreviated, time: .omitted), color: reminder.color, icon: nil)
                    BadgeView(text: safeDate.formatted(date: .omitted, time: .shortened), color: reminder.color, icon: nil)
                }
                
                BadgeView(text: reminder.category, color: reminder.color, icon: "briefcase.fill")
                
                Spacer()
                
                if reminder.isImportant {
                    Image(systemName: "flag.fill")
                        .foregroundColor(Color(.red))
                }
            }
        }
        .padding(25)
        .background(Color(.cardBackground))
        .cornerRadius(30)
        
        .sheet(isPresented: $showEditSheet) {
            SheetEditReminderView(reminderToEdit: reminder)
                .presentationDragIndicator(.visible)
        }
        
        .contextMenu {
            if enableEdit {
                Button(role: .destructive) {
                    showDeleteAlert = true
                } label: {
                    Label("Apagar Lembrete", systemImage: "trash")
                }
            }
        }
        
        .alert("Tem certeza que deseja apagar o lembrete?", isPresented: $showDeleteAlert) {
            Button("Cancelar", role: .cancel) { }
            
            Button("Apagar", role: .destructive) {
                viewModel.deleteReminder(id: reminder.id)
            }
        } message: {
            Text("O lembrete será movido para a lixeira e essa ação não poderá ser desfeita.")
        }
    }
}

#Preview {
    struct ReminderCardPreviewWrapper: View {
        @State var mockReminder = Reminder(
            listId: 1,
            isLocked: false,
            title: "Campanha",
            description: "Aprovar textos e layouts para os posts sobre economia circular e lixo eletrônico.",
            isCompleted: true,
            subtasks: [
                SubTask(title: "Revisar calendário de posts", isCompleted: true)
            ],
            dueDate: Date(),
            isImportant: true,
            color: .listColor1,
            category: "Trabalho"
        )
        
        var body: some View {
            
            VStack{
                ReminderCard(reminder: $mockReminder)
                    .padding()
            }
            .frame(maxHeight: .infinity)
            .background(Color(.background))
            
        }
    }
    
    return ReminderCardPreviewWrapper()
        .environmentObject(ReminderViewModel())
}
