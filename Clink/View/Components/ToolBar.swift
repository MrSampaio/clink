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
                        print("Menu Clicado") }) { Image(systemName: "ellipsis")}
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
                print("Organizar Clicado") }) { Image(systemName: "arrow.2.circlepath.circle")}
            
            Button(action: {
                print("Compartilhar Clicado") }) { Image(systemName: "square.and.arrow.up")}
            
            Button(action: {
                print("Menu Clicado") }) { Image(systemName: "elliipsis")}
        }
    }
}

struct EditReminderToolBar: ToolbarContent {
    @Binding var displaySheet: Bool
    
    var body: some ToolbarContent {
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                displaySheet.toggle() }) { Image(systemName: "plus")
            }
        }
    }
}

struct CreateReminderToolBar: ToolbarContent {
    
    let actionCancel: () -> Void
    let actionConfirm: () -> Void
    let disableAdd: Bool
    
    var body: some ToolbarContent {
        
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
                actionCancel() }) { Image(systemName: "xmark")}
        }
        
        ToolbarItem(placement: .principal) {
            Text("Editar")
                .font(.system(size: 20, weight: .semibold))

        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                actionConfirm()
            }) {
                Image(systemName: "checkmark")
            }
            .disabled(disableAdd)
        }
    }
}

struct WidgetToolBar: ToolbarContent {
    var body: some ToolbarContent {
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                print ("Ajuda Clicada") }) { Image(systemName: "questionmark.circle")}
        }
    }
}

struct ManageToolBar: ToolbarContent {
    var body: some ToolbarContent {
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                print ("Menu Clicada") }) { Image(systemName: "elliipsis")}
        }
    }
}





