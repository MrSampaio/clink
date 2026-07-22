//
//  SheetEditView.swift
//  Clink
//
//  Created by Vitor Silva Souza on 21/07/26.
//

import SwiftUI

struct SheetEditView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var newTitle = ""
    @State private var notas = ""
    
    @State private var isDateEnabled = false
    @State private var isTimeEnabled = false
    @State private var selectedDate = Date()
    
    @State private var notification = false
    @State private var repeatReminder = false
    @State private var LockReminder = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Título", text: $newTitle)
                    
                    TextField("Escreva uma descrição", text: $notas, axis: .vertical)
                        .lineLimit(3...5)
                }
                
                Section {
                    HStack(spacing: 16) {
                        Image(systemName: "circle")
                            .foregroundColor(.gray)
                            .font(.system(size: 20))
                        
                        Text("Subtarefa 1")
                            .foregroundColor(.primary)
                    }
                    HStack(spacing: 16) {
                        Text("Adicionar subtarefa")
                    }
                    .foregroundColor(.blue)
                }
                
                Section(header: Text("Alerta")) {
                    
                    Toggle(isOn: $isDateEnabled) {
                        Text("Data")
                    }
                    if isDateEnabled {
                        DatePicker(
                            "Selecionar Data",
                            selection: $selectedDate,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.compact)
                    }
                    
                    Toggle(isOn: $isTimeEnabled) {
                        Text("Hora")
                    }
                    if isTimeEnabled {
                        DatePicker(
                            "Selecionar Hora",
                            selection: $selectedDate,
                            displayedComponents: .hourAndMinute
                        )
                        .datePickerStyle(.compact)
                    }
                }
                
                Section {
                    HStack {
                        Image(systemName: "bell")
                        Toggle("Notificações", isOn: $notification)
//                        if notification {
//                            Text("Notificações ativadas")
//                        }
                    }
                    HStack {
                        Image(systemName: "repeat")
                        Toggle("Repetir lembrete", isOn: $repeatReminder)
                    }
                }
                
                Section(header: Text("Privacidade")) {
                    HStack {
                        Image(systemName: "lock")
                        Toggle("Trancar lembrete", isOn: $LockReminder)
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                CreateReminderToolBar(
                    actionCancel: { dismiss() },
                    actionConfirm: { dismiss() },
                    disableAdd: newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                )
            }
        }
    }
}

#Preview {
    SheetEditView()
}
