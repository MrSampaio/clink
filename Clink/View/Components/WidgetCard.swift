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
    var colorBackground: Color
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(image)
                    .font(.system(size: 35))
                Spacer()
                Image(systemName: "ellipsis")
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Text(mensagem)
                .font(.headline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .padding()
        .frame(width: 165, height: 165)
        .background(colorBackground)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
    }
}

struct AddWidgetCard: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "plus")
                .font(.system(size: 35))
            
            Text("Clique para criar seu Widget")
                .font(.headline)
                .multilineTextAlignment(.center)
        }
        .foregroundColor(.primary)
        .padding()
        .frame(width: 165, height: 165)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
    }
}
