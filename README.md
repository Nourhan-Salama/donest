# Todo App

A simple and intuitive Flutter-based todo application that helps users manage their daily tasks and stay productive.

## Features

✅ **Task Management**
- Create and organize daily tasks
- Set task priorities
- Track task completion status

📊 **Daily Progress Tracking**
- Monitor your daily task completion
- Visual progress indicators

💾 **Local Storage**
- All tasks are stored locally on your device
- No internet connection required
- Data persists between app sessions

🔔 **Smart Notifications**
- **Celebration notifications** when you complete all daily tasks
- **Encouragement notifications** to motivate you throughout the day
- **Reminder notifications** for incomplete tasks before the day ends

## Getting Started

### Prerequisites
- Flutter SDK
- Dart

### Installation
1. Clone this repository
2. Run 'flutter pub get'
3. Run 'flutter run'

## Project Structure
This project follows Clean Architecture principles with features organized by domain:
- **Data Layer**: Local data storage using Hive
- **Domain Layer**: Business logic and use cases
- **Presentation Layer**: UI components and state management with Cubit

## Technologies Used
- Flutter & Dart
- Hive (Local Storage)
- BLoC/Cubit (State Management)
- Local Notifications

## Author
Nourhan Salama
