//
//  Untitled.swift
//  Clink
//
//  Created by Vitor Silva Souza on 21/07/26.
//

import SwiftUI

struct HomeToolBar: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                print("Pequisar Clicado") }) { Image(systemName: "magnifyingglass")}
        }
        
        ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Organizar Clicado") }) { Image(systemName: "arrow.up.arrow.down")}
                    
                    Button(action: {
                        print("Lixo Clicado")}) { Image(systemName: "trash")}
                    
                    Button(action: {
                        print("Configurações Clicado") }) { Image(systemName: "ellipsis")}
        }
    }
}

struct AllListsToolBar: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                print("Pequisar Clicado") }) { Image(systemName: "magnifyingglass")}
        }
        
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            Button(action: {
                print ("Organizar Clicado") }) { Image(systemName: "arrow.2.circlepath.circle")}
            
            Button (action: {
                print ("Compartilhar Clicado") }) { Image(systemName: "square.and.arrow.up")}
            
            Button (action: {
                print ("Configuration Clicado") }) { Image(systemName: "elliipsis")}
        }
    }
}
