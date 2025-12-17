# Flutter To-Do App with Supabase

A production-ready Flutter To-Do application leveraging Supabase for backend services, including Authentication, Database, and Realtime capabilities.

---

## 📋 Features Checklist

- ✅ **Authentication**: Email/Password login and registration, plus Google Sign-In.
- ✅ **Tasks CRUD**: Create, Read, Update, and Delete tasks.
- ✅ **Real-time Sync**: Instant synchronization across devices using Supabase Realtime.
- ✅ **RLS Security**: Row Level Security policies for data protection.
- ✅ **Dark Mode**: Seamless dark mode toggle.
- ✅ **Profile Screen**: Manage user profile and settings.
- ✅ **Error Handling**: Robust error handling with retry mechanisms.
- ✅ **Lazy Loading**: Efficient list loading with `ListView.builder`.
- ✅ **Swipe to Delete**: Intuitive task deletion with swipe gestures.
- ✅ **Null-Safe**: Fully null-safe codebase using Dart null-safety.

---

## 📦 Prerequisites

- Flutter SDK (version 3.0.0 or higher).
- A free [Supabase](https://supabase.com/) account.
- Android Studio / Xcode for running the app on an emulator or device.

---

## 🚀 Quick Setup

### Step 1: Flutter Setup

```bash
# Navigate to the project directory
cd flutter_todo_supabase

# Install dependencies
flutter pub get

# Verify setup
flutter doctor
```

### Step 2: Supabase Configuration

#### 2.1 Create a Supabase Project

1. Visit [app.supabase.com](https://app.supabase.com) and create a new project.
2. Save the database password securely.
3. Copy the **Project URL** and **anon public key** from the API settings.

#### 2.2 Configure the App

1. Duplicate `.env.example` to `.env`:
   ```bash
   cp .env.example .env
   ```
2. Update `.env` with your Supabase credentials:
   ```env
   SUPABASE_URL=https://your-project-id.supabase.co
   SUPABASE_ANON_KEY=your-anon-key-here
   ```

#### 2.3 Initialize the Database

1. Open `supabase_migration.sql` and execute its contents in the Supabase SQL Editor.
2. Enable Realtime for the `public.tasks` table in the Replication settings.

---

## ▶️ Running the App

### On Android

```bash
flutter run
```

### On iOS (macOS only)

```bash
flutter run
```

---

## ✅ Manual Verification Steps

1. **Register a New User**: Test the registration and login flows.
2. **Create Tasks**: Add tasks and verify their appearance.
3. **Update Tasks**: Edit task details and confirm updates.
4. **Delete Tasks**: Swipe to delete and ensure tasks are removed.
5. **Real-time Sync**: Test synchronization across multiple devices.
6. **Dark Mode**: Toggle dark mode and verify persistence.

---

## 📁 Project Structure

```
lib/
├── main.dart                 # Entry point
├── models/
│   └── task_model.dart      # Task data model
├── providers/
│   ├── auth_provider.dart   # Authentication state management
│   ├── tasks_provider.dart  # Task state management
│   └── theme_provider.dart  # Theme state management
├── screens/
│   ├── login_screen.dart    # Login screen
│   ├── register_screen.dart # Registration screen
│   ├── home_screen.dart     # Task list screen
│   ├── add_edit_task_screen.dart  # Add/Edit task screen
│   └── profile_screen.dart  # Profile and settings screen
├── services/
│   └── supabase_service.dart # Supabase interaction logic
├── widgets/
│   └── task_item.dart       # Task list item widget
└── utils/
    └── constants.dart       # Constants and utilities
```

---

## 🛠️ State Management

This project uses **Provider** for state management due to its simplicity and official support by the Flutter team. It is well-suited for small to medium-sized projects.

---

## 📚 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Supabase Documentation](https://supabase.com/docs)
- [Provider Package](https://pub.dev/packages/provider)
- [Supabase Flutter Package](https://pub.dev/packages/supabase_flutter)

---

**Built with ❤️ using Flutter and Supabase.**
