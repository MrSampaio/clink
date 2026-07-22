//
//  ModelExample.swift
//  Clink
//
//  Created by Julio Sampaio on 18/07/26.
//

import Foundation
import SwiftUI

//struct ReminderList: Identifiable{
//    let id = UUID()
//    var title: String
//    var reminders: [Reminder]
//}

struct SubTask: Identifiable{
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct ReminderList: Identifiable {
    let id: Int // -> depois muda aqui pra UUID, quando a página de inserir lembrete estiver pronta
    var title: String
    var color: Color
}

struct Reminder: Identifiable {
    let id = UUID()
    var listId: Int // -> depois muda aqui pra UUID, quando a página de inserir lembrete estiver pronta
    var title: String
    var description: String
    var isCompleted: Bool = false
    var subtasks: [SubTask]
    var dueDate: Date
    var isImportant: Bool
    var color: Color // -> quando a página de inserir lembrete estiver pronta, pode tirar essa linha
    var category: String // -> quando a página de inserir lembrete estiver pronta, pode tirar essa linha
}
