//
//  CheckBox.swift
//  Clink
//
//  Created by Julio Sampaio on 18/07/26.
//

import Foundation
import SwiftUI

// 1. O Componente Reutilizável
struct PurpleCheckbox: View {
    // Usamos @Binding para que a view pai possa ler e alterar o estado
    @Binding var isChecked: Bool
    
    // Cor roxa baseada na sua imagem
    let checkboxColor = Color(red: 0.45, green: 0.35, blue: 1.0)
    
    var body: some View {
        Button {
            // Adiciona uma animação suave ao clicar
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                isChecked.toggle()
            }
        } label: {
            ZStack {
                if isChecked {
                    // Estado Marcado: Círculo preenchido + Ícone
                    Circle()
                        .fill(checkboxColor)
                    
                    Image(systemName: "checkmark")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                } else {
                    // Estado Desmarcado: Apenas a borda do círculo
                    Circle()
                        .stroke(checkboxColor, lineWidth: 3)
                }
            }
            .frame(width: 44, height: 44) // Tamanho do checkbox
            .contentShape(Circle()) // Garante que a área de clique seja o círculo inteiro, mesmo quando vazado
        }
        .buttonStyle(.plain) // Remove efeitos padrão de botão do iOS
    }
}

// 2. Exemplo de como usar o componente na sua tela principal
//struct ContentView: View {
//    @State private var isAgreed = false
//    
//    var body: some View {
//        HStack(spacing: 12) {
//            PurpleCheckbox(isChecked: $isAgreed)
//            
//            Text("Li e aceito os termos")
//                .font(.body)
//                .foregroundColor(.primary)
//                
//            Spacer()
//        }
//        .padding()
//    }
//}

#Preview {
    @State var isAgreed = true
    PurpleCheckbox(isChecked: $isAgreed)
}
