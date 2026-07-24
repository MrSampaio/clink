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
                Text(image)
                    .font(.system(size: 35))
                    .shadow(color: .black, radius: 2, x: 0, y: 2)

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
        .shadow(color: .black.opacity(0.15), radius: 1, x: 0, y: 0)
    }
}

struct AddWidgetCard: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "plus")
                .font(.system(size: 35))
            
            Text("Clique para criar seu Widget")
                .font(.default)
                .multilineTextAlignment(.center)
        }
        .foregroundColor(.primary)
        .padding()
        .frame(width: 165, height: 165)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: .black.opacity(0.15), radius: 1, x: 0, y: 0)

    }
}
