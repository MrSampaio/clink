//
//  HomeView.swift
//  Clink
//
//  Created by Julio Sampaio on 19/07/26.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @State private var estaAberto = false
    
    var body: some View {
        NavigationStack {
            ScrollView{

                VStack{
                    Title(title: "Todos", subtitle: "x lembretes")
                    
                    
                    

                            }
                            .padding()
                }
                .padding(.horizontal, 25)
                
            }
            
        }
    }

#Preview {
    HomeView()
}
