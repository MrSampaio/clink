//
//  AllListsView.swift
//  Clink
//
//  Created by Julio Sampaio on 19/07/26.
//

import Foundation
import SwiftUI

struct AllListsView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    Title(title: "Listas", subtitle: nil)
                    
                }
            }
        }
    }
}

#Preview {
    AllListsView()
}

