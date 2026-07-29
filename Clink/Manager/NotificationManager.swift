//
//  NotificationManager.swift
//  Clink
//
//  Created by Julio Sampaio on 29/07/26.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Permissão para notificações concedida!")
            } else if let error = error {
                print("Erro ao pedir permissão de notificação: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleNotification(for reminder: Reminder) {
        cancelNotification(for: reminder.id.uuidString)
        
        guard !reminder.isCompleted,
              let dueDate = reminder.dueDate,
              dueDate > Date() else { return }
        
        let content = UNMutableNotificationContent()
        content.title = reminder.title
        content.body = reminder.description ?? "Você tem um lembrete pendente!"
        content.sound = .default
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: reminder.id.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Erro ao agendar notificação: \(error.localizedDescription)")
            } else {
                print("Notificação agendada com sucesso para: \(reminder.title)")
            }
        }
    }
    
    func cancelNotification(for id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
