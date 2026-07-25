// IMPORTANTE: faz uma lógica de receber as cores da lista quando edita o lembrete

import SwiftUI

struct SheetEditView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ReminderViewModel
    
    var list: ReminderList?
    var reminderToEdit: Reminder?
    
    @State private var selectedListId: Int
    @State private var showErrorAlert = false
    @State private var showingDeleteAlert = false
    @State private var errorMessage = ""
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
    @State private var subtasks: [SubTask] = []

    // lógica que faz com que a lista da qual o usuário veio já venha selecionada por padrão
    init(list: ReminderList? = nil, reminderToEdit: Reminder? = nil) {
        self.list = list
        self.reminderToEdit = reminderToEdit
        
        // caso tenha lembrete pra editar, já preenche os inputs com os dados dele.
        // caso contrário, seta os valores como vazio
        _selectedListId = State(initialValue: reminderToEdit?.listId ?? list?.id ?? 1)
        _newTitle = State(initialValue: reminderToEdit?.title ?? "")
        _description = State(initialValue: reminderToEdit?.description ?? "")
        _subtasks = State(initialValue: reminderToEdit?.subtasks ?? [])
        _lockReminder = State(initialValue: reminderToEdit?.isLocked ?? false)
        _signposted = State(initialValue: reminderToEdit?.isImportant ?? false)
        
        if let existingDate = reminderToEdit?.dueDate {
            _isDateEnabled = State(initialValue: true)
            _selectedDate = State(initialValue: existingDate)
        } else {
            _isDateEnabled = State(initialValue: false)
            _selectedDate = State(initialValue: Date())
        }
    }
    
    var hasChanges: Bool {
        !newTitle.isEmpty || !description.isEmpty || isDateEnabled || notification || repeatReminder || lockReminder || signposted || !subtasks.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                DetailsSectionView(newTitle: $newTitle, description: $description)
                
                SubtaskSectionView(subtasks: $subtasks, color: list?.color ?? .blue)
                
                AlertSectionView(isDateEnabled: $isDateEnabled, isTimeEnabled: $isTimeEnabled, selectedDate: $selectedDate, color: list?.color)
                
                NotificationSectionView(notification: $notification, repeatReminder: $repeatReminder, color: list?.color)
                
                PrivacySectionView(lockReminder: $lockReminder, color: list?.color)
                
                OrganizationSectionView(signposted: $signposted, selectedListId: $selectedListId, color: list?.color)
                
                AttachmentSectionView()
            }
            .alert("Não foi possível criar o lembrete", isPresented: $showErrorAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(errorMessage)
                }
            .alert("Apagar Lembrete", isPresented: $showingDeleteAlert) {
                Button("Cancelar", role: .cancel) {}
                
                Button("Apagar", role: .destructive) {
                    if let existingReminder = reminderToEdit {
                        viewModel.deleteReminder(id: existingReminder.id)
                        withAnimation{
                            dismiss()
                        }
                        
                    }
                }
            } message: {
                Text("Tem certeza de que deseja apagar este lembrete? Esta ação não pode ser desfeita.")
            }
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled(hasChanges)
            .toolbar {
                SheetReminderToolBar(
                    actionCancel: {
                        if hasChanges {
                            showingDiscardAlert = true
                        } else {
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

//                        if isDateEnabled && selectedDate < Date() {
//                            errorMessage = "O lembrete não pode estar em uma data ou hora passadas."
//                            showErrorAlert = true
//                            return
//                        }
                        
                        if lockReminder && newTitle.count < 3 {
                            errorMessage = "Lembretes trancados precisam ter um título com pelo menos 3 caracteres."
                            showErrorAlert = true
                            return
                        }
                        
                        let validSubtasks = subtasks.filter { subtask in
                            !subtask.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                        }
                        
//                        for subtask in subtasks {
//                            if subtask.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
//                                
//                                
//                                errorMessage = "Todas as subtarefas devem ter um título."
//                                showErrorAlert = true
//                                return
//                            }
//                        }
                        

                        
                        if let existingReminder = reminderToEdit {
                            viewModel.updateReminder(
                                id: existingReminder.id,
                                listId: selectedListId,
                                isLocked: lockReminder,
                                title: newTitle,
                                description: description,
                                subtasks: validSubtasks,
                                dueDate: isDateEnabled ? selectedDate : nil,
                                isImportant: signposted
                            )
                            dismiss()
                            
                        } else {
                            let newReminder = viewModel.addNewReminder(
                                listId: selectedListId,
                                isLocked: lockReminder,
                                title: newTitle,
                                description: description,
                                subtasks: validSubtasks,
                                dueDate: isDateEnabled ? selectedDate : nil,
                                isImportant: signposted
                            )
                            
                            if newReminder != nil {
                                dismiss()
                            } else {
                                errorMessage = "Erro interno ao criar lembrete. Tente novamente."
                                showErrorAlert = true
                            }
                        }
                        
                        //dismiss()
                        
                    },
                    actionDiscard: {
                        dismiss()
                    },
                    
                    actionDelete: {
                        showingDeleteAlert = true
                    },
                    
                    disableAdd: false,
                    
                    isEditing: reminderToEdit != nil,
                                        
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
