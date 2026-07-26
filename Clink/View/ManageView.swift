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
    @State private var selectedPicker = 0
    
    var currentCount: String {
        switch selectedPicker {
        case 0: return "\(viewModel.concludedRemindersIndices.count)"
        case 1: return "\(viewModel.deletedReminders.count)"
        case 2: return "\(viewModel.lockedRemindersIndices.count)"
        default: return "0"
        }
    }
    
    var currentDescription: String {
        switch selectedPicker {
        case 0: return "Lembretes concluídos"
        case 1: return "Lembretes apagados"
        case 2: return "Lembretes trancados"
        default: return ""
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
                    ManageToolBar()
                }
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
    
    // MARK: - Tela Principal (Conteúdo Liberado)
    @ViewBuilder
    var mainContent: some View {
        ScrollView {
            Title(title: "Gerenciar", subtitle: "Visualize seus lembretes concluídos, apagados ou trancados")
                .padding(16)
            
            VStack {
                Picker("FilterManage", selection: $selectedPicker) {
                    Text("Concluídos").tag(0)
                    Text("Apagados").tag(1)
                    Text("Trancados").tag(2)
                }
               
                .pickerStyle(.segmented)
                .padding(16)
            }
            
            VStack(spacing: 12) {
                Text(currentCount)
                    .font(.system(size: 41, weight: .bold))
                Text(currentDescription)
                
                if selectedPicker == 0 {
                    ForEach(viewModel.concludedRemindersIndices, id: \.self) { index in
                        ReminderCard(reminder: $viewModel.reminders[index], enableEdit: false)
                            .padding(.top, 15)
                    }
                } else if selectedPicker == 1 {
                    ForEach($viewModel.deletedReminders) { $deletedReminder in
                        ReminderCard(reminder: $deletedReminder, enableEdit: false)
                            .padding(.top, 15)
                    }
                } else if selectedPicker == 2 {
                    ForEach(viewModel.lockedRemindersIndices, id: \.self) { index in
                        ReminderCard(reminder: $viewModel.reminders[index], forceUnlock: true)
                            .padding(.top, 15)
                    }
                }
            }
            .padding(.horizontal, 5)
        } .background(Color(.background))
    }
    
    // lógica da tela de bloqueio
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
