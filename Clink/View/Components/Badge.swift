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
                    .font(.system(size: 13))
                    .foregroundColor(Color(.white))
            }
            Text(text)
                .font(.system(size: 14, weight: .semibold))
                .lineLimit(1)
                .minimumScaleFactor(0.6)
                .foregroundColor(Color(.white))
        }
        .frame(maxWidth: .infinity, alignment: .init(horizontal: .center, vertical: .center))
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Color(color))
        .cornerRadius(14)
    }
}

#Preview {
    BadgeView(text: "Titulo", color: .purple, icon: "briefcase.fill")
}
