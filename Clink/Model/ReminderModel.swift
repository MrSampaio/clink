//
//  ModelExample.swift
//  Clink
//
//  Created by Julio Sampaio on 18/07/26.
//

import Foundation
import SwiftUI

struct SubTask: Identifiable{
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct Reminder: Identifiable{
    let id = UUID()
    var title: String
    var description: String
    var isCompleted: Bool = false
    var subtasks: [SubTask]
    var dueDate: Date
    var isImportant: Bool
    var category: String
    var color: Color
}
