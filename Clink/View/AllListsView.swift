//
//  AllListsView.swift
//  Clink
//
//  Created by Julio Sampaio on 19/07/26.
//

import Foundation
import SwiftUI

struct AllListsView: View {
    @EnvironmentObject var viewModel: ReminderViewModel
    
    @State var searchText: String = ""
    @State private var sortOrder: ListSortOrder = .creation
    @State var showSheetList = false
    @State var listToEdit: ReminderList?
    @State private var showDeleteAlert = false
    @State private var listToDelete: ReminderList?
    
    var displayedLists: [ReminderList] {
        viewModel.filteredAndSortedLists(searchText: searchText, sortOrder: sortOrder)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    Title(title: "Listas", subtitle: "\(viewModel.totalLists) listas criadas")
                    
                    VStack(spacing: 5) {
                        Button(action: {
                            showSheetList.toggle()
                        }) {
                            HStack {
                                Text("Crie uma nova lista")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Image(systemName: "plus")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.primary)
                            }
                        }
                        .padding(15)
                        .background(Color(.buttonBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                        .overlay(
                            RoundedRectangle(cornerRadius: 28)
                                .stroke(Color.border, lineWidth: 1)
                        )
                        
                        Text("Ao criar uma nova lista, é necessário definir seu nome, cor e ícone antes de concluir.")
                            .font(.system(size: 13, weight: .regular))
                            .padding(.horizontal, 10)
                    }
                    
                    LazyVStack(spacing: 20) {
                        if displayedLists.isEmpty {
                            
                            Text(searchText.isEmpty ? "Nenhuma lista criada." : "Nenhuma lista encontrada.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(.top, 20)
                            
                        } else {
                            ForEach(displayedLists) { list in
                                
                                ListComponent(list: list)
                                    .contextMenu {
                                        Button(action: {
                                            listToEdit = list
                                        }) {
                                            Label("Editar Lista", systemImage: "pencil")
                                        }
                                        
                                        Button(role: .destructive, action: {
                                            listToDelete = list
                                            showDeleteAlert = true
                                        }) {
                                            Label("Apagar Lista", systemImage: "trash")
                                        }
                                    }
                                
                                if searchText.isEmpty {
                                    Divider()
                                        .padding(.horizontal, 30)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    .background(Color(.cardBackground))
                    .cornerRadius(28)
                }
                .padding(16)
            }
            .toolbar {
                AllListsToolBar(sortOrder: $sortOrder)
            }
            .sheet(isPresented: $showSheetList) {
                SheetCreateListView(listToEdit: nil)
                    .presentationDragIndicator(.visible)
            }
            .sheet(item: $listToEdit) { selectedList in
                SheetCreateListView(listToEdit: selectedList)
                    .presentationDragIndicator(.visible)
            }
            .alert("Tem certeza de que deseja apagar esta lista? ", isPresented: $showDeleteAlert) {
                Button("Cancelar", role: .cancel) {
                    listToDelete = nil
                }
                Button("Apagar", role: .destructive) {
                    if let list = listToDelete {
                        viewModel.deleteList(id: list.id)
                    }
                    listToDelete = nil
                }
            } message: {
                Text("A lista e todos os lembretes dentro dela serão apagados permanentemente. Essa ação não poderá ser desfeita.")
            }
            .searchable(text: $searchText, prompt: "Buscar listas...")
            .background(Color(.background))
            .onTapGesture {
                #if canImport(UIKit)
                    hideKeyboard()
                #endif
            }
            .scrollDismissesKeyboard(.interactively)
        }
    }
}

#Preview {
    AllListsView()
        .environmentObject(ReminderViewModel())
}

