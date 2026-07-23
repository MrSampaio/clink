//
//  SheetEditView.swift
//  Clink
//
//  Created by Vitor Silva Souza on 21/07/26.
//

import SwiftUI

struct SheetEditView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: ReminderViewModel
    
    let list: ReminderList?
    
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    // também faz uma função pra conseguir editar um lembrete já criado!!!!
    
    @State private var showingDiscardAlert = false
    
    @State private var newTitle = ""
    @State private var description = ""
    
    @State private var isDateEnabled = false
    @State private var isTimeEnabled = false
    @State private var selectedDate = Date()
    
    @State private var notification = false
    @State private var repeatReminder = false
    @State private var lockReminder = false
    
    @State private var signposted = false
    @State private var priority = "Nenhuma"
    
    // depois faz uma lógica pra chamar a sheetview pela home view e outra pra chamar ela direto pela página da lista individual, aí ela recebe como parâmetro o nome da lista pra aparecer no modal de "mover para a lista"
    @State private var selectedListId: Int = 1
    
    var hasChanges: Bool {
        !newTitle.isEmpty || !description.isEmpty || isDateEnabled || notification
    }
    
    var body: some View {
        NavigationStack {
            Form {
                DetailsSectionView(newTitle: $newTitle, description: $description)
                
                SubtaskSectionView()
                
                AlertSectionView(isDateEnabled: $isDateEnabled, isTimeEnabled: $isTimeEnabled, selectedDate: $selectedDate, color: list?.color)
                
                NotificationSectionView(notification: $notification, repeatReminder: $repeatReminder)
                
                PrivacySectionView(lockReminder: $lockReminder)
                
                OrganizationSectionView(signposted: $signposted, selectedListId: $selectedListId)
                
                AttachmentSectionView()
            }
            .alert("Não foi possível criar o lembrete", isPresented: $showErrorAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(errorMessage)
                }
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled(hasChanges)
            .toolbar {
                SheetReminderToolBar(
                    actionCancel: {
                        if hasChanges {
                            print(selectedDate)
                            print($newTitle)
                            showingDiscardAlert = true
                        } else {
                            print("confirmou")
                            print(selectedDate)
                            print($newTitle)
                            dismiss()
                        }
                    },
                    actionConfirm: {
                        
                        // Validação do Título
                        if newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            errorMessage = "Insira um título para o lembrete."
                            showErrorAlert = true
                            return
                        }

                        if isDateEnabled && selectedDate < Date() {
                            errorMessage = "O lembrete não pode estar em uma data ou hora passadas."
                            showErrorAlert = true
                            return
                        }
                        
                        if lockReminder && newTitle.count < 3 {
                            errorMessage = "Lembretes trancados precisam ter um título com pelo menos 3 caracteres."
                            showErrorAlert = true
                            return
                        }
                        
                        let newReminder = viewModel.addNewReminder(listId: selectedListId, isLocked: lockReminder, title: newTitle, description: description, subtasks: nil, dueDate: selectedDate, isImportant: signposted)
                        
                        if newReminder != nil {
                            dismiss()
                        } else {
                            errorMessage = "Não foi possível encontrar a lista selecionada. Tente novamente."
                            showErrorAlert = true
                        }
                        
                        //dismiss()
                        
                    },
                    actionDiscard: {
                        dismiss()
                    },
                    
                    disableAdd: false,
                                        
                    color: list?.color,
                    
                    showingDiscardAlert: $showingDiscardAlert
                )
                
            }
            
        }
    }
}

#Preview {
    SheetEditView(list: nil)
        .environmentObject(ReminderViewModel())
}
