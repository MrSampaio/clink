//
//  SheetCreateListView.swift
//  Clink
//
//  Created by Julio Sampaio on 19/07/26.
//

import Foundation
import SwiftUI

struct SheetCreateListView: View {
    
    @EnvironmentObject var viewModel: ReminderViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var listName: String = ""
    @State private var selectedIcon: String = "list.bullet"
    @State private var selectedColor: Int = 0
    @State private var showingDiscardAlert = false
    @State private var showingDeleteAlert = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    var listToEdit: ReminderList?
    
    let palette: [LinearGradient] = [
        .pinkGradient, .redGradient, .orangeGradient, .brownGradient, .brownDarkGradient, .greenGradient, .mintGradient, .blueGradient, .indigoGradient, .purpleGradient
    ]
    
    let baseColors: [Color] = [
        .listColor9,  // Pink
        .listColor2,  // Red
        .listColor3,  // Orange
        .listColor10, // Brown
        .listColor1,  // Brown Dark
        .listColor5,  // Green
        .listColor4,  // Mint
        .listColor6,  // Blue
        .listColor7,  // Indigo
        .listColor8   // Purple
    ]
    
    init(listToEdit: ReminderList? = nil) {
        self.listToEdit = listToEdit
        
        _listName = State(initialValue: listToEdit?.title ?? "")
        _selectedIcon = State(initialValue: listToEdit?.icon ?? "list.bullet")
        
        let colors: [Color] = [
            .listColor9,  // Pink
            .listColor2,  // Red
            .listColor3,  // Orange
            .listColor10, // Brown
            .listColor1,  // Brown Dark
            .listColor5,  // Green
            .listColor4,  // Mint
            .listColor6,  // Blue
            .listColor7,  // Indigo
            .listColor8   // Purple
        ]
        
        if let existingColor = listToEdit?.color, let colorIndex = colors.firstIndex(of: existingColor) {
            _selectedColor = State(initialValue: colorIndex)
        } else {
            _selectedColor = State(initialValue: 0)
        }
    }
    
    var hasChanges: Bool {
        let originalTitle = listToEdit?.title ?? ""
        let originalIcon = listToEdit?.icon ?? "list.bullet"
        
        return listName != originalTitle || selectedIcon != originalIcon
    }
    
    var body: some View {
        
        NavigationStack {
            Form {
                IconAndTitleList(
                    listName: $listName,
                    selectedIcon: selectedIcon,
                    selectedGradient: palette[selectedColor % palette.count]
                )
                
                PresetsList()
                
                ColorsList(selectedColor: $selectedColor, palette: palette)
                
                IconList(selectedIcon: $selectedIcon, selectedGradient: palette[selectedColor])
            }
            .background(Color(.background))
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled(hasChanges)
            .toolbar {
                SheetListToolBar(
                    title: listToEdit == nil ? "Criar Lista" : "Editar Lista",
                    
                    actionCancel: {
                        if hasChanges {
                            showingDiscardAlert = true
                        } else {
                            dismiss()
                        }
                    },
                    
                    actionConfirm: {
                        if listName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            errorMessage = "Insira um nome para a lista."
                            showErrorAlert = true
                            return
                        }
                        
                        let actualColor = baseColors[selectedColor % baseColors.count]
                        
                        if let existingList = listToEdit {
                            viewModel.updateList(id: existingList.id, title: listName, color: actualColor, icon: selectedIcon)
                        } else {
                            viewModel.createNewList(title: listName, color: actualColor, icon: selectedIcon)
                        }
                        
                        dismiss()
                    },
                    
                    actionDiscard: {
                        dismiss()
                    },
                    
                    actionDelete: {
                        showingDeleteAlert = true
                    },
                    
                    disableAdd: listName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                    isEditing: listToEdit != nil,
                    color: .blue,
                    showingDiscardAlert: $showingDiscardAlert
                )
            }
            .onTapGesture {
#if canImport(UIKit)
                hideKeyboard()
#endif
            }
            .scrollDismissesKeyboard(.interactively)
            
            //Alertas
            .alert("Houve um erro ao executar a ação.", isPresented: $showErrorAlert) {
                Button("Tentar novamente", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            
            .alert("Tem certeza de que deseja apagar esta lista? ", isPresented: $showingDeleteAlert) {
                Button("Cancelar", role: .cancel) {}
                Button("Apagar", role: .destructive) {
                    if let existingList = listToEdit {
                        viewModel.deleteList(id: existingList.id)
                        dismiss()
                    }
                }
            } message: {
                Text("A lista e todos os lembretes dentro dela serão apagados permanentemente. Essa ação não poderá ser desfeita.")
            }
        }
    }
}

#Preview {
    SheetCreateListView()
        .environmentObject(ReminderViewModel())
}
