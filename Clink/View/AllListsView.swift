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
                        ForEach(viewModel.customLists){ list in
                            ListComponent(list: list)
                            
                            Divider()
                                .padding(.horizontal, 30)
                        }
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    .background(Color(.cardBackground))
                    .cornerRadius(28)
                    
                    
                }
                .padding(.horizontal, 20)
            }
            .background(Color(.background))
            .toolbar {
                AllListsToolBar()
            }
        }
    }
}

#Preview {
    AllListsView()
        .environmentObject(ReminderViewModel())
}

