//
//  WidgetCard.swift
//  Clink
//
//  Created by Vitor Silva Souza on 23/07/26.
//

import SwiftUI

struct WidgetCard: View {
    var image: String
    var mensagem: String
    var colorBackground: LinearGradient
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
//                Image(systemName: image)
                Text("📌")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)

                Spacer()
                Image(systemName: image)
                    .foregroundColor(.white.opacity(0.8))
                
            }
            
            Spacer()
            
            Text(mensagem)
                .font(.headline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
        }
        .padding()
        .frame(width: 165, height: 165)
        .background(colorBackground)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: .black.opacity(0.15), radius: 1, x: 0, y: 0)
    }
}
