//
//  CheckBox.swift
//  Clink
//
//  Created by Julio Sampaio on 18/07/26.
//

import Foundation
import SwiftUI

struct CheckBox: View {
    @Binding var isMarked: Bool
    var color: Color
    
    var body: some View {
        Button{
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                isMarked.toggle()
            }
        } label: {
            ZStack{
                if isMarked {
                    Circle()
                        .fill(Color(color))
                    Image(systemName: "checkmark")
                        .foregroundColor(Color(.white))
                        .font(.system(size: 14, weight: .bold))
                } else{
                    Circle()
                        .stroke(color, lineWidth: 3)
                }
            }
            .contentShape(Circle())
            .aspectRatio(1, contentMode: .fit)
        }
        .buttonStyle(.plain)
    }
}

struct teste: View {
    @State private var isAgreed = false
    var color = Color(.red)

    var body: some View {
        HStack(spacing: 12) {
            CheckBox(isMarked: $isAgreed, color: .red)

            Text("Exemplo de lembrete aqui")
                .font(.body)
                .foregroundColor(.primary)
        }
        .frame(height: 32)
        .padding()
    }
}


#Preview {
    @State var isMarked = false
    teste()
}
