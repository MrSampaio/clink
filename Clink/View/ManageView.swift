//
//  ManageView.swift
//  Clink
//
//  Created by Julio Sampaio on 19/07/26.
//

import SwiftUI
import LocalAuthentication

struct ManageView: View {
    
    @EnvironmentObject var viewModel: ReminderViewModel
    @StateObject private var securityVM = SecurityViewModel()
    //@State private var selectedPicker = 0
    
    @State private var searchText = ""
    @State private var showClearAlert = false
    
    var currentCount: String {
        switch viewModel.managePickerSelection {
        case 0: return "\(viewModel.concludedRemindersIndices.count)"
        case 1: return "\(viewModel.deletedReminders.count)"
        case 2: return "\(viewModel.lockedRemindersIndices.count)"
        default: return "0"
        }
    }
    
    var currentDescription: String {
        switch viewModel.managePickerSelection {
        case 0: return "Lembretes concluídos"
        case 1: return "Lembretes apagados"
        case 2: return "Lembretes trancados"
        default: return ""
        }
    }
    
    var filteredConcludedIndices: [Int] {
        viewModel.concludedRemindersIndices.filter { index in
            let r = viewModel.reminders[index]
            return r.title.localizedCaseInsensitiveContains(searchText) ||
                   (r.description?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }
    
    var filteredDeleted: [Reminder] {
        viewModel.deletedReminders.filter { r in
            return r.title.localizedCaseInsensitiveContains(searchText) ||
                   (r.description?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }
    
    var filteredLockedIndices: [Int] {
        viewModel.lockedRemindersIndices.filter { index in
            let r = viewModel.reminders[index]
            return r.title.localizedCaseInsensitiveContains(searchText) ||
                   (r.description?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if securityVM.isAuthenticated {
                    mainContent
                } else {
                    lockedContent
                }
            }
            .toolbar {
                if securityVM.isAuthenticated {
                    ManageToolBar(onClearTapped: {
                        showClearAlert = true
                    })
                }
            }
            .alert("Tem certeza que deseja esvaziar a lixeira?", isPresented: $showClearAlert) {
                Button("Cancelar", role: .cancel) { }
                
                Button("Esvaziar", role: .destructive) {
                    viewModel.deletedReminders.removeAll()
                }
            } message: {
                Text("Isso irá apagar todos os lembretes da lixeira permanentemente e essa ação não poderá ser desfeita.")
            }
        }
        .onAppear {
            if !securityVM.isAuthenticated {
                securityVM.authenticate()
            }
        }
        .onDisappear {
            securityVM.lock()
        }
    }
    
    @ViewBuilder
    var mainContent: some View {
        ScrollView {
            
            if searchText.isEmpty {
                
                Title(title: "Gerenciar", subtitle: "Visualize seus lembretes concluídos, apagados ou trancados")
                    .padding(16)
                
                VStack {
                    Picker("FilterManage", selection: $viewModel.managePickerSelection) {
                        Text("Concluídos").tag(0)
                        Text("Lixeira").tag(1)
                        Text("Trancados").tag(2)
                    }
                    .pickerStyle(.segmented)
                    .padding(16)
                }
                
                VStack(spacing: 16) {
                    Text(currentCount)
                        .font(.system(size: 41, weight: .bold))
                    Text(currentDescription)
                    
                    switch viewModel.managePickerSelection {
                        case 0:
                            if viewModel.concludedRemindersIndices.isEmpty {
                               Text("Nenhum lembrete concluído foi encontrado.")
                                    .padding(.top, 40)
                            } else{
                                ForEach(viewModel.concludedRemindersIndices, id: \.self) { index in
                                    ReminderCard(reminder: $viewModel.reminders[index], enableEdit: false, forceUnlock: true)
                                }
                            }
                        case 1:
                            if viewModel.deletedReminders.isEmpty {
                                Text("Nenhum lembrete na lixeira foi encontrado.")
                                     .padding(.top, 40)
                            } else{
                                ForEach($viewModel.deletedReminders) { $deletedReminder in
                                    ReminderCard(reminder: $deletedReminder, enableEdit: false, forceUnlock: true)
                                }
                            }
                        case 2:
                            if viewModel.lockedRemindersIndices.isEmpty {
                                Text("Nenhum lembrete trancado foi encontrado.")
                                     .padding(.top, 40)
                            } else{
                                ForEach(viewModel.lockedRemindersIndices, id: \.self) { index in
                                    ReminderCard(reminder: $viewModel.reminders[index], forceUnlock: true)
                                }
                            }
                    default:
                        EmptyView()
                    }
                    
                }
                .padding(.horizontal, 5)
                
            } else {
                
                VStack(alignment: .leading, spacing: 20) {
                    if filteredConcludedIndices.isEmpty && filteredDeleted.isEmpty && filteredLockedIndices.isEmpty {
                        Text("Nenhum lembrete encontrado.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 40)
                    } else {
                        
                        if !filteredConcludedIndices.isEmpty {
                            Text("Encontrados em Concluídos")
                                .font(.title3.bold())
                                .padding(.horizontal, 10)
                            
                            ForEach(filteredConcludedIndices, id: \.self) { index in
                                ReminderCard(reminder: $viewModel.reminders[index], enableEdit: false, forceUnlock: true)
                            }
                        }
                        
                        if !filteredDeleted.isEmpty {
                            Text("Encontrados na lixeira")
                                .font(.title3.bold())
                                .padding(.horizontal, 10)
                                .padding(.top, 10)
                            
                            ForEach(filteredDeleted, id: \.id) { deletedReminder in
                                if let index = viewModel.deletedReminders.firstIndex(where: { $0.id == deletedReminder.id }) {
                                    ReminderCard(reminder: $viewModel.deletedReminders[index], enableEdit: false, forceUnlock: true)
                                }
                            }
                        }
                        
                        if !filteredLockedIndices.isEmpty {
                            Text("Encontrados em Trancados")
                                .font(.title3.bold())
                                .padding(.horizontal, 10)
                                .padding(.top, 10)
                            
                            ForEach(filteredLockedIndices, id: \.self) { index in
                                ReminderCard(reminder: $viewModel.reminders[index], forceUnlock: true)
                            }
                        }
                    }
                }
                .padding(.horizontal, 5)
            }
        }
        .background(Color(.background))
        .searchable(text: $searchText, prompt: "Buscar lembretes...")
        .onTapGesture {
            #if canImport(UIKit)
                hideKeyboard()
            #endif
        }
        .scrollDismissesKeyboard(.interactively)
    }
    
    @ViewBuilder
    var lockedContent: some View {
        VStack(spacing: 20) {
            Image(systemName: "lock.fill")
                .font(.system(size: 50))
                .foregroundColor(.blue)
            
            Text("Área Restrita")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Use o FaceID para acessar seus lembretes e lixeira.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            if let authError = securityVM.authError{
                Text(authError)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .padding(.top, 10)
            }
            
            Button("Tentar Novamente") {
                securityVM.authenticate()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.background))
    }
}
#Preview {
    ManageView()
}
