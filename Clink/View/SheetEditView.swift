//
//  SheetEditView.swift
//  Clink
//
//  Created by Vitor Silva Souza on 21/07/26.
//

import SwiftUI

struct SheetEditView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var showingDiscardAlert = false
    
    @State private var newTitle = ""
    @State private var notas = ""
    
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
        !newTitle.isEmpty || !notas.isEmpty || isDateEnabled || notification
    }
    
    var body: some View {
        NavigationStack {
            Form {
                DetailsSectionView(newTitle: $newTitle, notas: $notas)
                
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
                            showingDiscardAlert = true
                        } else {
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
