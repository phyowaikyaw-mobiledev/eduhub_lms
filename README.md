# 🎓 EduHub - Learning Management System

A comprehensive mobile Learning Management System built with **Flutter** and **BLoC** state management pattern.

## ✨ Features

### 👨‍🎓 For Students
- Browse and search courses by category
- Enroll in courses
- View course details and materials
- Track learning progress
- Submit assignments
- View grades and feedback
- Personalized dashboard

### 👨‍🏫 For Teachers
- Create and manage courses
- Upload course materials
- Create assignments
- Grade student submissions
- Track student progress
- Analytics dashboard

### 🔐 Authentication
- User registration (Student/Teacher)
- Secure login system
- Profile management
- Role-based access control

## 🛠️ Tech Stack

- **Framework**: Flutter 3.0+
- **State Management**: BLoC (Cubit)
- **Local Database**: Hive
- **UI Components**: Custom widgets
- **Icons**: Iconsax, Material Icons
- **Fonts**: Google Fonts (Poppins)

## 📁 Project Structure

```
lib/
├── main.dart
├── core/
│   ├── constants/
│   ├── themes/
│   └── utils/
├── data/
│   ├── models/
│   │   ├── user_model.dart
│   │   ├── course_model.dart
│   │   └── assignment_model.dart
│   └── repositories/
│       ├── user_repository.dart
│       └── course_repository.dart
├── logic/
│   └── cubits/
│       ├── auth_cubit.dart
│       └── course_cubit.dart
└── presentation/
    ├── screens/
    │   ├── auth/
    │   ├── home/
    │   ├── courses/
    │   └── profile/
    └── widgets/
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0 or higher)
- Dart SDK (2.17 or higher)
- Android Studio / VS Code
- Android device or emulator

### Installation Steps

1. **Clone or create the project**
```bash
flutter create eduhub
cd eduhub
```

2. **Copy all the code files** into respective folders as shown in the structure above

3. **Install dependencies**
```bash
flutter pub get
```

4. **Generate Hive adapters**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

5. **Run the app**
```bash
flutter run
```

## 🔑 Demo Accounts

### Student Account
- Email: `student@edu.com`
- Password: `12345678`

### Teacher Account
- Email: `teacher@edu.com`
- Password: `12345678`

## 📱 Screenshots

### Authentication Screens
- Splash Screen
- Login Screen
- Registration Screen

### Student Features
- Student Dashboard
- Course List
- Course Details
- Assignments

### Teacher Features
- Teacher Dashboard
- Create Course
- Manage Courses
- Grade Assignments

## 🎨 Design Features

- **Modern UI/UX**: Clean and intuitive interface
- **Responsive Design**: Works on all screen sizes
- **Custom Widgets**: Reusable components
- **Smooth Animations**: Enhanced user experience
- **Color Scheme**: Professional blue theme
- **Dark Mode Ready**: Can be extended easily

## 📊 Database Schema

### Users Table
- id, name, email, password, role, profileImage, createdAt

### Courses Table
- id, title, description, teacherId, teacherName, category, thumbnail, enrolledStudents, totalLessons, duration, rating, createdAt

### Assignments Table
- id, courseId, title, description, dueDate, totalMarks, submission, createdAt

## 🔧 Key Dependencies

```yaml
dependencies:
  flutter_bloc: ^8.1.3        # State management
  equatable: ^2.0.5           # Value equality
  hive: ^2.2.3                # Local database
  hive_flutter: ^1.1.0        # Hive Flutter integration
  google_fonts: ^6.1.0        # Custom fonts
  iconsax: ^0.0.8             # Icon pack
  uuid: ^4.2.1                # ID generation
  intl: ^0.18.1               # Date formatting
```

## 📝 Future Enhancements

- [ ] Video lesson integration
- [ ] Real-time chat system
- [ ] Push notifications
- [ ] Payment gateway integration
- [ ] Certificate generation
- [ ] Quiz/Test module
- [ ] Discussion forums
- [ ] Mobile/Web responsive
- [ ] Dark mode
- [ ] Multiple language support
- [ ] Cloud backup (Firebase)
- [ ] Analytics dashboard

## 🐛 Known Issues

None at the moment. Please report any bugs you find!

## 📄 License

This project is created for educational purposes.

## 👨‍💻 Developer

Built with ❤️ using Flutter

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

## 📞 Support

For support, email - phyowaikyawdeveloper@gmail.com or create an issue in the repository.

---

**Happy Learning! 🚀**
