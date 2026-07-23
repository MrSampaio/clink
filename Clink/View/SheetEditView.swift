//
//  SheetEditView.swift
//  Clink
//
//  Created by Vitor Silva Souza on 21/07/26.
//

import SwiftUI

struct SheetEditView: View {
    @Environment(\.dismiss) var dismiss
    
    // depois faz uma lógica pra chamar a sheetview pela home view e outra pra chamar ela direto pela página da lista individual, aí ela recebe como parâmetro o nome da lista pra aparecer no modal de "mover para a lista"
    
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
    let prioridades = ["Nenhuma", "Trabalho", "Academia", "Comida"]
    
    var hasChanges: Bool {
        !newTitle.isEmpty || !description.isEmpty || isDateEnabled || notification
    }
    
    var body: some View {
        NavigationStack {
            Form {
                DetailsSectionView(newTitle: $newTitle, description: $description)
                
                SubtaskSectionView()
                
                AlertSectionView(isDateEnabled: $isDateEnabled, isTimeEnabled: $isTimeEnabled, selectedDate: $selectedDate)
                
                NotificationSectionView(notification: $notification, repeatReminder: $repeatReminder)
                
                PrivacySectionView(lockReminder: $lockReminder)
                
                OrganizationSectionView(signposted: $signposted, priority: $priority, prioridades: prioridades)
                
                AttachmentSectionView()
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
                        dismiss()
                        
                    },
                    actionDiscard: {
                        dismiss()
                    },
                    
                    disableAdd: newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, showingDiscardAlert: $showingDiscardAlert)
            }
            
        }
    }
}

#Preview {
    SheetEditView()
}
