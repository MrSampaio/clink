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
    @State private var selectedPicker = 0
    //@State private var securityPicker = 0
    
    var currentCount: String {
        switch selectedPicker {
        case 0: return "15"
        case 1: return "2"
        case 2: return "4"
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
            ScrollView {
                
                Title(title: "Gerenciar", subtitle: "")
                    .padding(16)
                VStack {
                    Picker("FilterManage", selection: $selectedPicker) {
                        Text("Concluídos").tag(0)
                        Text("Apagados").tag(1)
                        Text("Trancados").tag(2)
                    }
                    .pickerStyle(.segmented)
                    .padding(16)
                    //.onChange(of: selectedPicker) { oldValue, newValue in
                    //  if newValue == 2 {
                    //      faceidManage()
                    //  } else {
                    //      securityPicker = newValue
                    //    }
                    //  }
                }
                
                VStack(spacing: 12) {
                    Text(currentCount)
                        .font(.system(size: 41, weight: .bold))
                    Text(currentDescription)
                    
                    if (selectedPicker == 0){
                        ForEach(viewModel.concludedRemindersIndices, id: \.self) { index in
                            ReminderCard(reminder: $viewModel.reminders[index])
                                   .padding(.top, 15)
                        }
                    } else if(selectedPicker == 1){
                        ForEach($viewModel.deletedReminders) { $deletedReminder in
                            ReminderCard(reminder: $deletedReminder)
                                .padding(.top, 15)
                        }
                    } else if(selectedPicker == 2){
                        ForEach(viewModel.lockedRemindersIndices, id: \.self) { index in
                            ReminderCard(reminder: $viewModel.reminders[index])
                                   .padding(.top, 15)
                        }
                    }
                    
                    
                }
                .padding(.horizontal, 5)
            }
            .toolbar {
                ManageToolBar()
            }
        }
    }
}
    
//    func faceidManage() {
//        let context = LAContext()
//        var error: NSError?
//        
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//            let reason = "Autentique para ver seus lembretes trancados."
//            
//            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
//                DispatchQueue.main.async {
//                    if success {
//                        self.securityPicker = 2
//                    } else {
//                        self.selectedPicker = self.securityPicker
//                    }
//                }
//            }
//        } else {
//            print("Biometria não configurada.")
//            DispatchQueue.main.async {
//                self.selectedPicker = self.securityPicker
//            }
//        }
//    }
//}

#Preview {
    ManageView()
        .environmentObject(ReminderViewModel())
}
