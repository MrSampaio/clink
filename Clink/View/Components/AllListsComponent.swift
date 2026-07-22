//
//  AllListsComponent.swift
//  Clink
//
//  Created by Julio Sampaio on 22/07/26.
//

import Foundation
import SwiftUI

public struct AllListsComponent: View {
    
    var list: ReminderList
    @EnvironmentObject var viewModel: ReminderViewModel
    
    var countReminders: Int {
        viewModel.reminders.filter { $0.listId == list.id }.count
    }
    
    var countCompleted: Int {
        viewModel.reminders.filter { $0.listId == list.id && $0.isCompleted }.count
    }
    
    var completionPercentage: Int {
        if countReminders == 0 { return 0 }
        
        let percentage = (Double(countCompleted) / Double(countReminders)) * 100
        return Int(percentage)
    }
    
    public var body: some View {
        NavigationLink(destination: ListView(title: list.title)){
            HStack{
                HStack(spacing: 15){
                    Image(systemName: list.icon)
                        .foregroundColor(Color(.tag))
                        .frame(width: 50, height: 50)
                        .background(Color(list.color))
                        .cornerRadius(50)
                        
                    VStack(alignment: .leading, spacing: 3){
                        Text(list.title)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(Color(.font))
                        
                        Text("\(countReminders) tarefas")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(Color(.font))
                            .opacity(0.5)
                    }
                }
                
                Spacer()
                
                HStack(spacing: 15){
                    Text("\(completionPercentage)%")
                        .foregroundColor(.font)
                        .opacity(0.7)
                        

                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
               
            }
            .padding(.horizontal, 30)
        }
        
    }
}
#Preview {
    
    let reminder = ReminderList(id: 1, title: "Trabalho", color: .listColor1, icon: "briefcase.fill")
    
    NavigationStack{
        AllListsComponent(list: reminder)
            .environmentObject(ReminderViewModel())
    }
   
}
