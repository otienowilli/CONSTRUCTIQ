# 📱 CONSTRUCTIQ Mobile App

AI-powered construction field intelligence and smart material optimization platform for iOS and Android.

## ✨ Features

### 🔐 **Authentication & User Management**
- Secure login/register with JWT tokens
- Role-based access (Admin, Engineer, Contractor, Worker)
- Biometric authentication (Face ID, Touch ID, Fingerprint)
- Password reset and account management

### 📊 **Material Calculators (10 Types)**
1. **Concrete Calculator** - Volume, bags of cement, aggregates
2. **Bitumen Calculator** - Application rates, wastage
3. **Asphalt Calculator** - Weight/volume conversion
4. **Geotextile Calculator** - Area with overlap
5. **Brickwork Calculator** - Bricks, mortar required
6. **Plastering Calculator** - Cement, sand quantities
7. **Painting Calculator** - Paint, primer required
8. **Excavation Calculator** - Volume, trucking
9. **Road Calculator** - Sub-base, base course
10. **Roofing Calculator** - Sheets, tiles, accessories

### 📍 **GPS & Mapping**
- Real-time location tracking
- Google Maps integration
- Site marking and boundaries
- Offline maps support
- Distance and area measurement

### 📷 **Camera & Image Analysis**
- Capture site photos with GPS tagging
- AI soil type detection
- Image-based material identification
- Before/after photo comparison
- Photo gallery and organization

### 🎚️ **Sensors & Measurements**
- Slope measurement (accelerometer/gyroscope)
- Level detection
- Distance calculation
- Automatic measurements

### 🔧 **IoT & Machine Control**
- Real-time sensor monitoring (14 types)
- Remote machine control (Start/Stop/Pause)
- Live data visualization
- Machine status dashboard
- Alert notifications

### 💬 **AI Chatbot Assistant**
- Construction guidance
- Material recommendations
- Problem solving
- Voice commands (optional)

### 📴 **Offline Mode**
- Work without internet
- Local SQLite database
- Automatic background sync
- Queue offline actions

### 📄 **Reports & Export**
- Generate PDF reports
- Material cost estimates
- Project summaries
- Export to email/cloud

## 🛠 Tech Stack

- **Framework**: Flutter 3.x
- **Language**: Dart
- **State Management**: Provider + BLoC
- **Local Database**: SQLite + Hive
- **API**: REST (Laravel backend)
- **Maps**: Google Maps API
- **Notifications**: Firebase Cloud Messaging
- **Analytics**: Firebase Analytics

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── app/
│   ├── app.dart             # Main app widget
│   ├── routes.dart          # Navigation routes
│   ├── providers/           # State management
│   ├── screens/             # UI screens
│   └── widgets/             # Reusable widgets
├── core/
│   ├── config/              # App configuration
│   ├── constants/           # Constants & enums
│   ├── services/            # API, Storage, Location
│   ├── models/              # Data models
│   └── utils/               # Helper functions
└── features/
    ├── auth/                # Authentication
    ├── calculators/         # Material calculators
    ├── projects/            # Project management
    ├── machines/            # Machine control
    ├── maps/                # Maps & GPS
    └── reports/             # Reports & export
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0+)
- Android Studio / Xcode
- Google Maps API key
- Backend API URL

### Installation

```bash
# Install dependencies
flutter pub get

# Run on Android
flutter run

# Run on iOS
flutter run

# Build APK (Android)
flutter build apk --release

# Build IPA (iOS)
flutter build ios --release
```

### Configuration

1. **API Configuration**
   - Edit `lib/core/config/api_config.dart`
   - Set your backend API URL

2. **Google Maps**
   - Add API key to `android/app/src/main/AndroidManifest.xml`
   - Add API key to `ios/Runner/AppDelegate.swift`

3. **Firebase** (Optional)
   - Add `google-services.json` (Android)
   - Add `GoogleService-Info.plist` (iOS)

## 📱 App Stores

### Google Play Store
- Package: `com.constructiq.app`
- Min SDK: 21 (Android 5.0)
- Target SDK: 34 (Android 14)

### Apple App Store
- Bundle ID: `com.constructiq.app`
- Min iOS: 12.0
- Target iOS: 17.0

## 🔑 Environment Variables

Create `.env` file:
```
API_BASE_URL=https://api.constructiq.com
GOOGLE_MAPS_API_KEY=your_api_key_here
FIREBASE_PROJECT_ID=your_project_id
```

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test

# Code coverage
flutter test --coverage
```

## 📦 Build & Deploy

### Android
```bash
# Generate signed APK
flutter build apk --release

# Generate App Bundle (for Play Store)
flutter build appbundle --release
```

### iOS
```bash
# Generate IPA
flutter build ios --release

# Open in Xcode for archiving
open ios/Runner.xcworkspace
```

## 🎨 Design System

- **Primary Color**: #1E88E5 (Blue)
- **Secondary Color**: #FFA726 (Orange)
- **Font**: Poppins
- **Design**: Material Design 3

## 📄 License

Proprietary - All rights reserved

## 👥 Team

CONSTRUCTIQ Development Team

## 📞 Support

- Email: support@constructiq.com
- Website: https://constructiq.com
