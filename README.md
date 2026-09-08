# 📝 Clink: A Comprehensive Reminder and Task Management Application
Clink is a feature-rich, powerful task management and reminder app that helps you to keep your life organized and on top of your tasks. With its user-friendly interface and extensive feature set, Clink provides a seamless experience to manage reminders, tasks, and notifications. The application is built with Swift, SwiftUI and other frameworks, which ensures its reliable and efficient operation.

## Features
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

## Project Structure
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

## System Requirements

Before you begin, ensure your development environment meets the following minimum requirements:

- **IDE**: Xcode 15.0 or later
- **iOS Target**: iOS 17.0+ (Required for Interactive Widgets, AppIntents, and Live Activities)

---

## Installation & Build

To compile and run Clink locally on your machine, follow these steps:

**1. Clone the repository**

Open your Terminal and run:

```bash
git clone https://github.com/MrSampaio/clink.git
```

**2. Open the project in Xcode**

Navigate to the cloned folder and double-click the `.xcodeproj` (or `.xcworkspace` if applicable) file to open it in Xcode.

**3. Configure the App Group** *(Optional but Recommended)*

To ensure the Widgets communicate properly with the main app, verify that the App Group identifier (`group.sampaio.clink.dados`) is enabled and matches your Apple Developer account settings under the **Signing & Capabilities** tab.

**4. Select the Build Target**

In the Xcode top toolbar, click on the active scheme name and choose:

- `Clink` → Choose an iPhone Simulator (e.g., iPhone 15 Pro) or a physical connected device.

**5. Compile and Run**

Press `Cmd + R` or click the Play (▶) button. Xcode will compile the code and launch the application.

---

## Usage Guide

Once the app is running, you can test its full feature set:

1. **Create a Custom List**: Navigate to the "Listas" tab, tap the `+` button, and define a name, color gradient, and SF Symbol icon for your new category.

2. **Add Reminders**: Inside your list or from the Home tab, add a new reminder. Toggle the options to include subtasks, set a specific date/time for local notifications, or flag it as important.

3. **Lock a Reminder**: While creating or editing a reminder, toggle "Trancar lembrete". Attempting to view its details later will prompt a Face ID/Touch ID authentication request.

4. **Test the Widget**: Go to your iOS Simulator/Device Home Screen, long-press the background, tap the `+` icon, and search for "Clink". Add the widget and long-press it to configure which reminder it should display.

---

## 🍎 Thank you, Apple Developer Academy
This project was developed in collaboration with [@vitorssza](https://github.com/vitorssza) at Apple Developer Academy.
