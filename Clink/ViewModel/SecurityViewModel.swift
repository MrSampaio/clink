//
//  SecurityViewModel.swift
//  Clink
//
//  Created by Julio Sampaio on 25/07/26.
//

import Foundation
import LocalAuthentication
import Combine
import SwiftUI

class SecurityViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var authError: String? = nil
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Autentique para gerenciar seus lembretes."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                DispatchQueue.main.async {
                    if success {
                        self.isAuthenticated = true
                        self.authError = nil
                    } else {
                        self.isAuthenticated = false
                        self.authError = "Autenticação falhou ou foi cancelada."
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.isAuthenticated = false
                self.authError = "Biometria não disponível neste dispositivo."
            }
        }
    }
    
    func lock() {
        isAuthenticated = false
    }
}
