# 📝 Clink: A Comprehensive Reminder and Task Management Application
Clink is a feature-rich, powerful task management and reminder app that helps you to keep your life organized and on top of your tasks. With its user-friendly interface and extensive feature set, Clink provides a seamless experience to manage reminders, tasks, and notifications. The application is built with Swift, SwiftUI and other frameworks, which ensures its reliable and efficient operation.

## 🚀 Features
* **Reminder Management**: Create, edit, and delete reminders with ease, including custom lists, subtasks, and due dates.
* **Biometric Authentication**: Protect your reminders with Face ID or Touch ID authentication.
* **Notification Management**: Get notified about upcoming reminders and events.
* **Widget Support**: The Clink widget gives you access to your reminders and tasks from your home screen.
* **Live Activity**: Show a dynamic island on the lock screen or in the notification center with the state of the timer.
* **Customizable**: Personalize your experience with settings and preferences.

## 🛠️ Tech Stack
* **Swift**: The primary programming language used for development.
* **SwiftUI**: A framework for building user interfaces in Swift.
* **Combine**: A framework for reactive programming.
* **WidgetKit**: A framework for creating widgets.
* **AppIntents**: A framework for defining intents and behaviors.
* **ActivityKit**: A framework for creating live activities.
* **Foundation**: A framework for working with data and other core functionality.
* **UserNotifications**: A framework for managing notifications.
* **LocalAuthentication**: A framework for handling biometric authentication.

## ⚙️ System Requirements
Before you begin, ensure your development environment meets the following minimum requirements:
* **IDE:** Xcode 15.0 or later.
* **iOS Target:** iOS 17.0+ (Required for native `Charts` and modern SwiftUI shapes).
* **macOS Target:** macOS 14.0+ (Sonoma) or later.


## 📦 Installation
To install Clink, follow these steps:
1. Clone the repository using Git.
2. Open the project in Xcode.
3. Build and run the application on a physical device or simulator.

## 💻 Usage
1. Launch the application and create a new reminder or task.
2. Customize your reminder or task with due dates, subtasks, and other options.
3. Secure your reminders with biometric authentication.
4. Access your reminders and tasks directly from your home screen using the Clink widget.
5. Receive notifications for upcoming reminders and events.

## 📂 Project Structure
```markdown
Clink
├── Clink
│   ├── ClinkApp.swift
│   ├── ViewModel
│   │   ├── SecurityViewModel.swift
│   │   ├── ReminderViewModel.swift
│   ├── Model
│   │   ├── ReminderModel.swift
│   ├── Manager
│   │   ├── NotificationManager.swift
│   ├── View
│   │   ├── Core
│   │   │   ├── ContentView.swift
│   │   ├── HomeView.swift
├── ClinkWidget
│   ├── ClinkWidget.swift
│   ├── ClinkWidgetControl.swift
│   ├── ClinkWidgetLiveActivity.swift
```

<!--## 📸 Screenshots -->

## 🍎 Thank you, Apple Developer Academy
This project was developed in collaboration with @vitorssza at Apple Developer Academy.
