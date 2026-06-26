# 🛠️ CONSTRUCTIQ Development Environment Setup Guide

Complete guide to set up your development environment and test the CONSTRUCTIQ mobile app.

---

## 📋 Table of Contents

1. [System Requirements](#system-requirements)
2. [Flutter Installation](#flutter-installation)
3. [Project Setup](#project-setup)
4. [Backend Services Setup](#backend-services-setup)
5. [Running the Mobile App](#running-the-mobile-app)
6. [Testing & Debugging](#testing--debugging)
7. [Troubleshooting](#troubleshooting)

---

## 💻 System Requirements

### **Minimum Requirements:**

#### **For Mobile Development (Any Platform):**
- **OS**: Windows 10/11, macOS 10.15+, or Linux (Ubuntu 18.04+)
- **RAM**: 8 GB (16 GB recommended)
- **Storage**: 10 GB free space
- **Internet**: Required for initial setup

#### **For iOS Development (Additional):**
- **OS**: macOS 10.15 (Catalina) or later
- **Xcode**: 12.0 or later
- **Apple ID**: For device testing & App Store deployment

---

## 🎯 Flutter Installation

### **Step 1: Install Flutter SDK**

#### **Windows:**
```bash
# Download Flutter SDK
# Visit: https://docs.flutter.dev/get-started/install/windows

# Extract to C:\src\flutter
# Add to PATH: C:\src\flutter\bin

# Verify installation
flutter doctor
```

#### **macOS:**
```bash
# Install with Homebrew
brew install flutter

# OR download manually from flutter.dev

# Verify installation
flutter doctor
```

#### **Linux:**
```bash
# Download Flutter SDK
cd ~/development
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.0-stable.tar.xz
tar xf flutter_linux_3.24.0-stable.tar.xz

# Add to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Verify installation
flutter doctor
```

### **Step 2: Install Required Tools**

#### **Android Studio:**
```bash
# Download from: https://developer.android.com/studio

# Install Android SDK
# Install Android SDK Command-line Tools
# Install Android SDK Build-Tools
# Install Android Emulator

# Accept licenses
flutter doctor --android-licenses
```

#### **VS Code (Alternative to Android Studio):**
```bash
# Download from: https://code.visualstudio.com/

# Install Flutter extension
# Install Dart extension
```

#### **Xcode (macOS only - for iOS development):**
```bash
# Install from App Store
# Launch Xcode and accept license
sudo xcodebuild -license accept

# Install command line tools
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
```

### **Step 3: Verify Installation**

```bash
flutter doctor -v
```

**Expected Output:**
```
[✓] Flutter (Channel stable, 3.24.0)
[✓] Android toolchain - develop for Android devices
[✓] Xcode - develop for iOS and macOS (macOS only)
[✓] Chrome - develop for the web
[✓] Android Studio
[✓] VS Code
[✓] Connected device
```

---

## 📦 Project Setup

### **Step 1: Clone Repository**

```bash
# Clone from GitHub
git clone https://github.com/otienowilli/CONSTRUCTIQ.git

# Navigate to mobile app
cd CONSTRUCTIQ/mobile-app
```

### **Step 2: Install Dependencies**

```bash
# Install Flutter packages
flutter pub get

# This installs 50+ packages including:
# - dio (HTTP client)
# - provider (State management)
# - sqflite (Local database)
# - google_maps_flutter (Maps)
# - mqtt_client (IoT)
# - And many more...
```

### **Step 3: Configure API Endpoint**

Edit `lib/core/config/api_config.dart`:

```dart
class ApiConfig {
  // Development - Use your local IP or deployed backend
  static const String baseUrl = 'http://192.168.1.100:8000/api';
  
  // Production
  // static const String baseUrl = 'https://api.constructiq.com/api';
  
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
}
```

**Finding your local IP:**
```bash
# macOS/Linux
ifconfig | grep "inet "

# Windows
ipconfig
```

### **Step 4: Google Maps API Key (Optional for Maps)**

1. Get API key from: https://console.cloud.google.com/

2. **Android** - Edit `android/app/src/main/AndroidManifest.xml`:
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_API_KEY_HERE"/>
```

3. **iOS** - Edit `ios/Runner/AppDelegate.swift`:
```swift
GMSServices.provideAPIKey("YOUR_API_KEY_HERE")
```

---

## 🔧 Backend Services Setup

### **Option 1: Docker (Recommended)**

```bash
# Navigate to project root
cd CONSTRUCTIQ

# Start all services
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f backend-api
```

**Services Running:**
- Backend API: http://localhost:8000
- AI Engine: http://localhost:8001
- Web Dashboard: http://localhost:3000
- PostgreSQL: localhost:5432
- Redis: localhost:6379
- MQTT Broker: localhost:1883

### **Option 2: Manual Setup (Advanced)**

**Backend API:**
```bash
cd backend-api
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate --seed
php artisan serve
```

**AI Engine:**
```bash
cd ai-engine
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8001
```

---

## 📱 Running the Mobile App

### **Step 1: Check Connected Devices**

```bash
flutter devices
```

**Expected Output:**
```
Android SDK built for x86 (mobile) • emulator-5554 • android-x86 • Android 11 (API 30)
iPhone 14 Pro (mobile)              • simulator    • ios         • iOS 16.0
Chrome (web)                        • chrome       • web-javascript • Google Chrome
```

### **Step 2: Run on Android Emulator**

```bash
# Start Android emulator first (or use Android Studio)
flutter emulators
flutter emulators --launch <emulator-id>

# Run the app
flutter run

# Or specify device
flutter run -d emulator-5554
```

### **Step 3: Run on iOS Simulator (macOS only)**

```bash
# Start iOS simulator
open -a Simulator

# Run the app
flutter run -d "iPhone 14 Pro"
```

### **Step 4: Run on Physical Device**

**Android:**
```bash
# Enable USB debugging on device
# Connect via USB
# Run
flutter run
```

**iOS (macOS only):**
```bash
# Connect iPhone via USB
# Trust computer on device
# Run
flutter run -d <device-id>
```

### **Step 5: Hot Reload During Development**

While app is running:
- Press `r` - Hot reload
- Press `R` - Hot restart
- Press `p` - Toggle performance overlay
- Press `q` - Quit

---

## 🧪 Testing & Debugging

### **Testing the App Features**

1. **Launch & Authentication:**
   - See animated splash screen (3 seconds)
   - Complete onboarding (3 slides) or skip
   - Register: `test@constructiq.com` / `Test123!`
   - Login with credentials

2. **Test Calculators:**
   - Navigate to Calculators
   - Try **Bitumen Calculator**:
     - Length: 100m
     - Width: 10m
     - Thickness: 50mm
     - Grade: 80/100
     - Tap Calculate
     - View results: ~1,260L needed

3. **Test AI Chat:**
   - Tap chat icon on home screen
   - Ask: "What materials do I need for a concrete slab?"
   - Get AI response

4. **Test Dark Mode:**
   - Go to Profile
   - Toggle theme switch
   - See theme change instantly

5. **Test Projects & Machines:**
   - View Projects list
   - View Machines list
   - Check status indicators

### **Debug Mode**

```bash
# Run in debug mode (default)
flutter run

# Run in profile mode (performance testing)
flutter run --profile

# Run in release mode (production-like)
flutter run --release
```

### **View Logs**

```bash
# Flutter logs
flutter logs

# Android logs
adb logcat

# iOS logs
idevicesyslog
```

---

## 🔍 Troubleshooting

### **Common Issues & Solutions**

#### **1. "Flutter command not found"**
```bash
# Add Flutter to PATH
export PATH="$PATH:/path/to/flutter/bin"

# Make permanent (add to ~/.bashrc or ~/.zshrc)
echo 'export PATH="$PATH:/path/to/flutter/bin"' >> ~/.bashrc
source ~/.bashrc
```

#### **2. "Android licenses not accepted"**
```bash
flutter doctor --android-licenses
# Accept all licenses (y)
```

#### **3. "Gradle build failed"**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

#### **4. "iOS build failed" (macOS)**
```bash
cd ios
pod install
cd ..
flutter clean
flutter run -d ios
```

#### **5. "Package conflicts"**
```bash
flutter clean
rm pubspec.lock
flutter pub get
```

#### **6. "Cannot connect to backend"**
- Check backend is running: `curl http://localhost:8000/api/health`
- Verify IP address in `api_config.dart`
- Use local IP (not localhost) for emulator: `192.168.x.x`
- Check firewall settings

#### **7. "Emulator is slow"**
- Enable hardware acceleration (Intel HAXM / AMD-V)
- Increase emulator RAM (AVD Manager)
- Use x86_64 system image (faster than ARM)

#### **8. "Hot reload not working"**
```bash
# Restart app
flutter run --no-hot
```

---

## 📊 Build for Testing

### **Android APK**

```bash
# Debug APK
flutter build apk --debug

# Release APK (requires signing)
flutter build apk --release

# APK location: build/app/outputs/flutter-apk/app-release.apk
```

### **iOS IPA (macOS only)**

```bash
# Build for device
flutter build ios --release

# Archive in Xcode for TestFlight/App Store
```

---

## ✅ Verification Checklist

Before you start development, verify:

- [ ] Flutter SDK installed (`flutter --version`)
- [ ] Android Studio / Xcode installed
- [ ] Emulator/Simulator working
- [ ] Repository cloned
- [ ] Dependencies installed (`flutter pub get`)
- [ ] Backend services running
- [ ] API endpoint configured
- [ ] App runs successfully
- [ ] All calculators working
- [ ] Can login/register
- [ ] Dark mode toggles
- [ ] No errors in console

---

## 🚀 Next Steps

Once environment is set up:

1. **Read Documentation:**
   - [Flutter App Complete Guide](./FLUTTER_APP_COMPLETE_GUIDE.md)
   - [Universal System Guide](./UNIVERSAL_SYSTEM_GUIDE.md)

2. **Start Development:**
   - Create new features
   - Fix bugs
   - Run tests
   - Submit pull requests

3. **Join Community:**
   - GitHub Discussions
   - Report issues
   - Share improvements

---

## 📞 Need Help?

- 📧 Email: support@constructiq.com
- 💬 GitHub Issues: [Report a bug](https://github.com/otienowilli/CONSTRUCTIQ/issues)
- 📖 Documentation: [Read the docs](./README.md)

---

**Happy Coding! 🎉**

*CONSTRUCTIQ Development Team*

