//
//  SheetSections.swift
//  Clink
//
//  Created by Vitor Silva Souza on 22/07/26.
//

import SwiftUI

struct DetailsSectionView: View {
    @Binding var newTitle: String
    @Binding var description: String
    
    var body: some View {
        Section {
            TextField("Título", text: $newTitle)
            
            TextField("Escreva uma descrição", text: $description, axis: .vertical)
                .lineLimit(3...5)
        }
    }
}

struct SubtaskSectionView: View {
    var body: some View {
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
    }
}

struct AlertSectionView: View {
    @Binding var isDateEnabled: Bool
    @Binding var isTimeEnabled: Bool
    @Binding var selectedDate: Date
    
    var body: some View {
        
        Section(header: Text("Alerta")) {
            Toggle(isOn: $isDateEnabled) {
                Text("Data")
            }
            if isDateEnabled {
                HStack {
                    Image(systemName: "calendar")
                    
                    DatePicker(
                        "",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .labelsHidden()
                    .datePickerStyle(.compact)
                    
                    // muda a linguagem do calendário depois
                    //.typesettingLanguage(.explicit(Locale.Language))
                }
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(Color(.systemGray4))
                .clipShape(RoundedRectangle(cornerRadius: 28))
            }
        }
        
        Section(footer: Text("Um horário precisa de uma data definida.")) {
            Toggle(isOn: $isTimeEnabled) {
                Text("Hora")
            }
            if isTimeEnabled {
                HStack {
                    Image(systemName: "clock")
                    
                    DatePicker(
                        "",
                        selection: $selectedDate,
                        displayedComponents: .hourAndMinute
                    )
                    .labelsHidden()
                    .datePickerStyle(.compact)
                }
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(Color(.systemGray4))
                .clipShape(RoundedRectangle(cornerRadius: 28))
            }
        }
        
        
    }
}

struct NotificationSectionView: View {
    @Binding var notification: Bool
    @Binding var repeatReminder: Bool
    
    var body: some View {
        Section {
            HStack {
                Image(systemName: "bell")
                Toggle("Notificações", isOn: $notification)
            }
            HStack {
                Image(systemName: "repeat")
                Toggle("Repetir lembrete", isOn: $repeatReminder)
            }
        }
    }
}

struct PrivacySectionView: View {
    @Binding var lockReminder: Bool
    
    var body: some View {
        Section(header: Text("Privacidade"), footer: Text("Ao trancar um lembrete, você só poderá acessá-lo com o FaceID.")) {
            HStack {
                Image(systemName: "lock")
                Toggle("Trancar lembrete", isOn: $lockReminder)
            }
        }
    }
}

struct OrganizationSectionView: View {
    @Binding var signposted: Bool
    @Binding var selectedListId: Int
    
    @EnvironmentObject var viewModel: ReminderViewModel
    
    var body: some View {
        Section(header: Text("Classificar")) {
            Toggle(isOn: $signposted) {
                Label("Sinalizar", systemImage: "flag")
            }
            .foregroundColor(.primary)
            
            Picker("Mover para lista", selection: $selectedListId) {
                
                ForEach(viewModel.customLists) { list in
                    
                    Text(list.title).tag(list.id)
                    
                }
            }
        }
    }
}

struct AttachmentSectionView: View {
    var body: some View {
        Section(header: Text("Mídia")) {
            HStack(spacing: 12) {
                Image(systemName: "paperclip")
                    .foregroundColor(.primary)
                
                Text("Anexo")
                    .foregroundColor(.primary)
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
            }
        }
    }
}
