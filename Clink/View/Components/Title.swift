//
//  Title.swift
//  Clink
//
//  Created by Julio Sampaio on 19/07/26.
//

import Foundation
import SwiftUI

struct Title: View {
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
        
        .frame(maxWidth: .infinity, alignment: .leading)
        //.border(Color(.red))
        
    }
}

#Preview {
    Title(title: "Página", subtitle: "Descrição da página")
}
