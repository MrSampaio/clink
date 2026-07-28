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

struct SubTask: Identifiable, Codable{
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct ReminderList: Identifiable, Codable{
    let id: Int // -> depois muda aqui pra UUID, quando a página de inserir lembrete estiver pronta
    var title: String
    var color: Color
    var icon: String
    //var reminderCount: Int
}


// -> não esquece de fazer uma lógica pra adicionar as horas no lembrete!!!!
struct Reminder: Identifiable, Codable{
    let id = UUID()
    var listId: Int // -> depois muda aqui pra UUID, quando a página de inserir lembrete estiver pronta
    var isLocked: Bool
    var title: String
    var description: String?
    var isCompleted: Bool = false
    var subtasks: [SubTask]?
    var dueDate: Date? = Date()
    var isImportant: Bool
    var color: Color // -> quando a página de inserir lembrete estiver pronta, pode tirar essa linha
    var category: String // -> quando a página de inserir lembrete estiver pronta, pode tirar essa linha
}

extension Color: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let red = try container.decode(Double.self, forKey: .red)
        let green = try container.decode(Double.self, forKey: .green)
        let blue = try container.decode(Double.self, forKey: .blue)
        let opacity = try container.decode(Double.self, forKey: .opacity)
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let uic = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        uic.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        try container.encode(Double(red), forKey: .red)
        try container.encode(Double(green), forKey: .green)
        try container.encode(Double(blue), forKey: .blue)
        try container.encode(Double(alpha), forKey: .opacity)
    }

    private enum CodingKeys: String, CodingKey {
        case red, green, blue, opacity
    }
}
