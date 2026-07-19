//
//  ReminderCard.swift
//  Clink
//
//  Created by Julio Sampaio on 18/07/26.
//

import Foundation


import SwiftUI

struct ReminderCard: View {
    var body: some View {
        VStack{
            
            HStack{
                
            }
            Text("to testando um texto bem longo")
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .background(Color(.black))
        .cornerRadius(30)
        .foregroundColor(Color(.blue))
        .padding(.leading, 20)
        .padding(.trailing, 20)


        
        
        VStack{
            Text("Hello, World!")
        }
    }
}

#Preview {
    ReminderCard()
}
