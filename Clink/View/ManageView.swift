//
//  ManageView.swift
//  Clink
//
//  Created by Julio Sampaio on 19/07/26.
//

import Foundation
import SwiftUI

struct ManageView: View {
    @State private var selectedTab = 0
    
    var currentCount: String {
        switch selectedTab {
        case 0: return "15"
        case 1: return "2"
        case 2: return "4"
        default: return "0"
        }
    }
    
    var currentDescription: String {
        switch selectedTab {
        case 0: return "Lembretes concluídos"
        case 1: return "Lembretes apagados"
        case 2: return "Lembretes trancados"
        default: return ""
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                Title(title: "Gerenciar", subtitle: "")
                    .padding(16)
                VStack {
                    Picker("dada", selection: $selectedTab) {
                        Text("Concluidos").tag(0)
                        Text("Apagados").tag(1)
                        Text("Trancados").tag(2)
                    }
                    .pickerStyle(.segmented)
                    .padding(16)
                }
                VStack (spacing: 12) {
                    Text(currentCount)
                        .font(.system(size: 41, weight: .bold))
                    Text(currentDescription)
                }
                .padding(38)
            }
            .toolbar {
                ManageToolBar()
                
            }
        }
    }
}

#Preview {
    ManageView()
}
