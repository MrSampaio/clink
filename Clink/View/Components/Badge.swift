//
//  BadgeView.swift
//  Clink
//
//  Created by Julio Sampaio on 18/07/26.
//

import Foundation
import SwiftUI

struct BadgeView: View {
    let text: String
    let color: Color
    let icon: String?
    
    var body: some View {
        HStack(spacing: 4){
            if let icon = icon {
                Image(systemName: icon)
                    .font(.system(size: 12))
            }
            Text(text)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color(.white))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color(color))
        .cornerRadius(14)
    }
}

#Preview {
    BadgeView(text: "Titulo", color: .purple, icon: nil)
}
