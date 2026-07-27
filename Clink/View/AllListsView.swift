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
    var filteredIndices: [Int] {
        if searchText.isEmpty {
            return []
        } else {
            return viewModel.customLists.indices.filter { index in
                let list = viewModel.customLists[index]
                let matchTitle = list.title.localizedCaseInsensitiveContains(searchText)
                return matchTitle
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing: 25){
                    Title(title: "Listas", subtitle: "\(viewModel.totalLists) listas criadas")
                    
                   
                    VStack(spacing: 5){
                        NavigationLink(destination: CreateListView()){
                            HStack{
                                Text("Crie uma nova lista")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.font)
                                
                                Spacer()
                                
                                Image(systemName: "plus")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.font)
                            }
                            .padding(15)
                            .background(.buttonBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 28))
                            .overlay(
                                RoundedRectangle(cornerRadius: 28)
                                    .stroke(Color.border, lineWidth: 1)
                            )
                            
                        }
                        Text("Ao criar uma nova lista, é necessário definir seu nome, cor e ícone antes de concluir.")
                            .font(.system(size: 13, weight: .regular))
                            .padding(.horizontal, 10)
                    }
                    
                    
                    LazyVStack(spacing: 20){
                        
                        if searchText.isEmpty {
                            ForEach(viewModel.customLists){ list in
                                ListComponent(list: list)
                                
                                Divider()
                                    .padding(.horizontal, 30)
                            }
                        } else{
                            if filteredIndices.isEmpty {
                                Text("Nenhuma lista encontrada.")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .padding(.top, 40)
                            } else {
                                ForEach(filteredIndices, id: \.self) { index in
                                    ListComponent(list: viewModel.customLists[index])
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
            .toolbar{
                //testToolbar()
                AllListsToolBar()
            }
            .searchable(text: $searchText)
            .background(Color(.background))
            
        }
    }
}

#Preview {
    AllListsView()
        .environmentObject(ReminderViewModel())
}

