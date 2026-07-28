//
//  Untitled.swift
//  Clink
//
//  Created by Vitor Silva Souza on 21/07/26.
//

import SwiftUI

enum SortOrder {
    case newest
    case oldest
}

struct HomeToolBar: ToolbarContent {

    @Binding var sortOrder: SortOrder
    @Binding var showConcluded: Bool
    @Binding var showLocked: Bool
    
    // closures (ações) para avisar a HomeView que a lixeira e o add foram clicados
    var onTrashTapped: () -> Void
    var onAddTapped: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            Menu {
                Picker("Organizar", selection: $sortOrder) {
                    Text("Mais recentes primeiro").tag(SortOrder.newest)
                    Text("Mais antigos primeiro").tag(SortOrder.oldest)
                }
            } label: {
                Image(systemName: "arrow.up.arrow.down")
            }
            
            Button(action: {
                onAddTapped()
            }) {
                Image(systemName: "plus")
            }
            
            Menu {
                Toggle(isOn: $showConcluded) {
                    Label("Mostrar concluídos", systemImage: "checkmark.circle")
                }
                
                Toggle(isOn: $showLocked) {
                    Label("Mostrar trancados", systemImage: "lock")
                }
                
                Divider()
                
                Button(role: .destructive, action: {
                    onTrashTapped()
                }) {
                    Label("Lixeira", systemImage: "trash")
                }
                
            } label: {
                Image(systemName: "ellipsis")
            }
        }
    }
}

enum ListSortOrder {
    case alphabetical
    case creation
}

struct AllListsToolBar: ToolbarContent {
    
    @Binding var sortOrder: ListSortOrder
    
    var body: some ToolbarContent {

        ToolbarItem(placement: .topBarTrailing) {
            Menu {
                Picker("Organizar", selection: $sortOrder) {
                    Text("Ordem alfabética").tag(ListSortOrder.alphabetical)
                    Text("Ordem de criação").tag(ListSortOrder.creation)
                }
            } label: {
                Image(systemName: "arrow.up.arrow.down")
            }
        }
    }
}

struct SelectedListToolBar: ToolbarContent {
    @Binding var displaySheet: Bool
    var color: Color? = .blue
    
    var body: some ToolbarContent {
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                displaySheet.toggle()
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 36, height: 36)
                    .background((color ?? .blue))
                    .clipShape(Circle())
            }
        } .sharedBackgroundVisibility(.hidden)
    }
}
struct SheetReminderToolBar: ToolbarContent {
    
    let actionCancel: () -> Void
    let actionConfirm: () -> Void
    let actionDiscard: () -> Void
    let actionDelete: () -> Void
    let disableAdd: Bool
    var isEditing: Bool
    
    var color: Color?
    
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
                Button("Descartar", role: .destructive) {
                    actionDiscard()
                }
                
                Button("Continuar Editando", role: .cancel) { }
                
            } message: {
                Text("Deseja mesmo descartar a edição deste lembrete?")
            }
        }
        
        ToolbarItem(placement: .principal) {
            Text("Editar")
                .font(.system(size: 20, weight: .semibold))
        }
        if isEditing {
            ToolbarItem(placement: .destructiveAction){
                Button(action: {
                    actionDelete()
                }) {
                    Image(systemName: "trash")
                        .foregroundStyle(.white)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.circle)
                .tint(.red)
                .disabled(disableAdd)
            }
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
            .tint(color)
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
    
    var onClearTapped: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Menu {
                Button(role: .destructive, action: {
                    onClearTapped()
                }) {
                    Label("Esvaziar lixeira", systemImage: "trash")
                }
            } label: {
                Image(systemName: "ellipsis")
            }
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





