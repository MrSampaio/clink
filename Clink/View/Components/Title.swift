//
//  Title.swift
//  Clink
//
//  Created by Julio Sampaio on 19/07/26.
//

import Foundation
import SwiftUI

struct title: View {
    let title: String
    let subtitle: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text(title)
                .font(.system(size: 34, weight: .bold))
                .bold()
                .foregroundColor(.font)
            
            Text(subtitle ?? "")
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.font)
                .opacity(0.5)
        }
        
    }
}

#Preview {
    title(title: "Página", subtitle: "Descrição da página")
}
