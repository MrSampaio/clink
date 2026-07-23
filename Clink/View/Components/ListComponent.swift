//
//  ListComponent.swift
//  Clink
//
//  Created by Julio Sampaio on 22/07/26.
//

import Foundation
import SwiftUI

public struct ListComponent: View {
    
    var list: ReminderList
    @EnvironmentObject var viewModel: ReminderViewModel
    
    public var body: some View {
        NavigationLink(destination: ListView(list: list)){
            HStack{
                HStack(spacing: 15){
                    Image(systemName: list.icon)
                        .foregroundColor(Color(.tag))
                        .frame(width: 50, height: 50)
                        .background(Color(list.color))
                        .cornerRadius(50)
                        
                    VStack(alignment: .leading, spacing: 0){
                        Text(list.title)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(Color(.font))
                        
                        Text("\(viewModel.countReminders(for: list.id)) tarefas")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(Color(.font))
                            .opacity(0.5)
                    }
                }
                
                Spacer()
                
                HStack(spacing: 15){
                    
                    if viewModel.countReminders(for: list.id) > 0{
                        Text("\(viewModel.completionPercentage(for: list.id))%")
                            .foregroundColor(.font)
                            .opacity(0.7)
                    } else{
                        Text("Nenhum lembrete.")
                            .foregroundColor(.font)
                            .opacity(0.7)
                    }
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
               
            }
            .frame(maxWidth: .infinity)
            //.padding(.horizontal, 30)
           
        }
    }
}
#Preview {
    
    let reminder = ReminderList(id: 1, title: "Trabalho", color: .listColor1, icon: "briefcase.fill")
    
    NavigationStack{
        ListComponent(list: reminder)
            .environmentObject(ReminderViewModel())
    }
   
}
