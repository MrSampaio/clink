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
        
        ToolbarItem(placement: .topBarTrailing) {
            
            HStack(spacing: 12) {
                Button(action: {
                    print("Pesquisar Clicado")
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.font)
                        .frame(width: 50, height: 50)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.border.opacity(0.3), lineWidth: 1)
                        )
                        .shadow(color: .border.opacity(0.15), radius: 5, x: 0, y: 4)
                }
                
                HStack(spacing: 20) {
                    Button(action: { print("Organizar Clicado") }) {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                    
                    Button(action: { print("Lixo Clicado") }) {
                        Image(systemName: "trash")
                    }
                    
                    Button(action: { print("Menu Clicado") }) {
                        Image(systemName: "ellipsis")
                    }
                }
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.font)
                .padding(.horizontal, 20)
                .frame(height: 50)
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
                .overlay(
                    Capsule().stroke(Color.border.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: .font.opacity(0.15), radius: 5, x: 0, y: 4)
                
            }
        } .sharedBackgroundVisibility(.hidden)
    }
}

struct SelectedListToolBar: ToolbarContent {
    @Binding var displaySheet: Bool
    
    var body: some ToolbarContent {
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                displaySheet.toggle()
            }) {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct SheetReminderToolBar: ToolbarContent {
    
    let actionCancel: () -> Void
    let actionConfirm: () -> Void
    let actionDiscard: () -> Void
    let disableAdd: Bool
    
    @Binding var showingDiscardAlert: Bool
    
    var body: some ToolbarContent {
        
        ToolbarItem(placement: .cancellationAction) {
            Button(action: {
                actionCancel()
            }) {
                Image(systemName: "xmark")
            }
            .confirmationDialog(
                "",
                isPresented: $showingDiscardAlert,
                titleVisibility: .hidden
            ) {
                Button("Descartar Lembrete", role: .destructive) {
                    actionDiscard()
                }
                
                Button("Continuar Editando", role: .cancel) { }
                
            } message: {
                Text("Deseja mesmo descartar esse lembrete?")
            }
        }
        
        ToolbarItem(placement: .principal) {
            Text("Editar")
                .font(.system(size: 20, weight: .semibold))
        }
        
        ToolbarItem(placement: .confirmationAction) {
            Button(action: {
                actionConfirm()
            }) {
                Image(systemName: "checkmark")
                    .foregroundStyle(.white)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.circle)
            .tint(.blue)
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

struct testToolbar: ToolbarContent{
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: {
                print ("Menu Clicada") }) { Image(systemName: "magnifyingglass")}.background(.red)
        }
    }
}





