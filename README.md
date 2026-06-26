# 🏗️ CONSTRUCTIQ

## AI-Powered Construction Field Intelligence & Universal Material Management Platform

[![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)](https://github.com/otienowilli/CONSTRUCTIQ)
[![Flutter](https://img.shields.io/badge/Flutter-3.24+-02569B?logo=flutter)](https://flutter.dev)
[![Laravel](https://img.shields.io/badge/Laravel-10-FF2D20?logo=laravel)](https://laravel.com)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Status](https://img.shields.io/badge/status-80%25%20Complete-orange.svg)](https://github.com/otienowilli/CONSTRUCTIQ)

---

## 🌟 Overview

**CONSTRUCTIQ v2.0** is a revolutionary construction management platform that combines **AI intelligence**, **IoT machine control**, and a **universal materials database** to support construction projects worldwide. Built with Flutter for cross-platform mobile deployment (iOS & Android) and backed by robust Laravel/Python services.

### 🎯 Key Differentiators

✅ **Universal System** - Supports UNLIMITED materials & machines from ANY manufacturer globally
✅ **80+ Pre-Configured Materials** - Cement, Aggregates, Steel, Bitumen, Asphalt, Geotextiles
✅ **80+ Pre-Configured Machines** - Earthmoving, Concrete, Road Construction equipment
✅ **40+ Sensor Codes** - Universal IoT system works with ANY sensor-enabled equipment
✅ **10 Advanced Calculators** - Bitumen, Asphalt, Geotextile, Concrete, and more
✅ **AI-Powered Assistant** - Intelligent chatbot for construction guidance
✅ **Offline-First Architecture** - Works without internet connectivity

---

## ✨ Features

### 📱 **Flutter Mobile App (NEW v2.0)**

#### **Core Features:**
- ✅ **Cross-Platform** - Single codebase for iOS & Android
- ✅ **Material Design 3** - Modern, beautiful UI with Light/Dark themes
- ✅ **Offline-First** - SQLite local storage with cloud sync
- ✅ **Real-Time Updates** - Live project & machine status
- ✅ **Smart Navigation** - Bottom tab navigation with 5 main sections

#### **Authentication & User Management:**
- 🔐 Secure JWT-based authentication
- 👤 Role-based access control (Admin, Engineer, Foreman, Worker)
- 📧 Email/password registration
- 🎯 Onboarding tutorial for new users
- 🔄 Auto-logout on token expiry

### 🧮 **10 Advanced Material Calculators**

1. **Bitumen Calculator** ⭐ - Road surface bitumen application rates
2. **Asphalt Calculator** ⭐ - Hot mix asphalt weight & volume
3. **Geotextile Calculator** ⭐ - Ground stabilization with overlap calculations
4. **Concrete Calculator** - Volume, cement, sand, aggregate breakdown
5. **Brickwork Calculator** - Brick quantities with mortar
6. **Plastering Calculator** - Wall plastering material estimation
7. **Painting Calculator** - Paint coverage and quantities
8. **Excavation Calculator** - Earthwork volume calculations
9. **Road Calculator** - Road construction materials
10. **Roofing Calculator** - Roofing material estimation

**Features:**
- Multiple material grades/types per calculator
- Wastage factor adjustments
- Real-time cost calculations
- Save & share results
- Units conversion support

### 🌍 **Universal Materials Database (80+ Materials)**

Pre-configured materials across 7 categories:
- **Cement & Binders** (10) - OPC, PPC, Rapid Hardening, White Cement, etc.
- **Aggregates** (10) - Sand, Gravel, Crushed Stone (10-40mm)
- **Bricks & Blocks** (10) - Clay, Fly Ash, Concrete, AAC, Glass blocks
- **Steel & Reinforcement** (12) - TMT Bars (8-32mm), I-Beams, H-Beams
- **Bitumen** (10) - Grades 30/40 to 120/150, PMB, Emulsion
- **Asphalt** (9) - AC10-AC30, DBM, WMM, SMA
- **Geotextiles** (8) - Woven, Non-woven, Geogrid, Geomembrane

**PLUS:** Add unlimited custom materials with custom units, pricing, and specifications!

### 🚜 **Universal Machines Database (80+ Machines)**

Pre-configured equipment across 8 categories:
- **Earthmoving** (10) - Bulldozers, Excavators, Loaders, Graders
- **Concrete Equipment** (10) - Mixers, Batching Plants, Pumps, Transit Mixers
- **Road Construction** (11) - Asphalt Plants, Pavers, Rollers, Sprayers
- **Compaction** (5) - Plate Compactors, Rammers, Rollers
- **Crushing & Screening** (6) - Jaw, Cone, Impact Crushers, Screens
- **Material Handling** (6) - Cranes, Forklifts, Telehandlers, Conveyors
- **Piling Equipment** (4) - Pile Drivers, Drilling Rigs, CFA
- **Generators & Compressors** (5) - Diesel Generators, Air Compressors

**PLUS:** Add unlimited custom machines from ANY manufacturer!

### 🔌 **Universal IoT Sensor System (40+ Sensor Codes)**

**Location & Movement:** GPS-001, GYRO-001, ACCEL-001, SPEED-001, DIST-001
**Environmental:** TEMP-001, HUMID-001, PRESS-001, VIBR-001, NOISE-001
**Soil & Material:** SOIL-001 to SOIL-005 (Moisture, pH, Temperature, Density, Compaction)
**Fluid & Flow:** FLUID-001 to FLUID-004 (Water, Flow, Fuel, Oil Pressure)
**Load & Force:** LOAD-001 to LOAD-003 (Weight, Torque, Strain)
**Machine Status:** MACH-001 to MACH-005 (Engine Temp/RPM/Hours, Battery, Hydraulic)
**Safety:** SAFE-001 to SAFE-004 (Emergency Stop, Collision, Tilt, Barrier)

**Works with equipment from:** CAT, Komatsu, Volvo, Hitachi, JCB, Liebherr, SANY, XCMG, Doosan, and ANY manufacturer with IoT sensors!

### 🤖 **AI-Powered Features**

- **AI Chat Assistant** - Intelligent construction guidance and recommendations
- **Material Suggestions** - AI recommends optimal materials for projects
- **Cost Optimization** - Machine learning for cost predictions
- **Soil Analysis** - Camera-based AI soil classification (planned)
- **Predictive Maintenance** - IoT data analysis for machine health

### 📊 **Project Management**

- Create & manage multiple projects
- Assign team members with roles
- Track project progress and status
- Budget tracking and cost analysis
- Timeline management
- Document attachments

### 🎛️ **Machine Control & Monitoring**

- Real-time machine status (🟢 Online, 🟡 Idle, 🔴 Offline, 🔧 Maintenance)
- Remote machine commands (START, STOP, PAUSE, EMERGENCY STOP)
- Live sensor data visualization
- Fuel level & engine hours tracking
- GPS location tracking
- Maintenance scheduling

### 📈 **Admin Dashboard (Web)**

- Web-based project overview
- Analytics and reporting
- User management
- System configuration
- Export reports to PDF/Excel

---

## 🏛️ System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    CONSTRUCTIQ v2.0                         │
│                  Cross-Platform Architecture                │
└─────────────────────────────────────────────────────────────┘

┌──────────────────┐         ┌──────────────────┐
│   iOS App        │         │   Android App    │
│  (Flutter/Dart)  │         │  (Flutter/Dart)  │
│  Material Design │         │  Material Design │
└────────┬─────────┘         └────────┬─────────┘
         │                            │
         └────────────┬───────────────┘
                      │
              ┌───────┴────────┐
              │  API Gateway   │
              │     (Nginx)    │
              └───────┬────────┘
                      │
        ┌─────────────┼─────────────┐
        │             │             │
  ┌─────┴──────┐ ┌───┴────┐ ┌─────┴──────┐
  │ Backend API│ │   AI   │ │    IoT     │
  │  (Laravel) │ │ Engine │ │  Gateway   │
  │   REST     │ │FastAPI │ │   MQTT     │
  └─────┬──────┘ └───┬────┘ └─────┬──────┘
        │            │            │
        └────────────┼────────────┘
                     │
           ┌─────────┴──────────┐
           │   PostgreSQL DB    │
           │  + Redis Cache     │
           └────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│  Mobile Features: Offline-first SQLite + Cloud Sync         │
│  IoT: Real-time sensor data via MQTT                        │
│  AI: TensorFlow/PyTorch for ML predictions                  │
└─────────────────────────────────────────────────────────────┘
```

---

## 📁 Project Structure

```
CONSTRUCTIQ/
├── mobile-app/                    # 📱 Flutter Mobile App (NEW v2.0)
│   ├── lib/
│   │   ├── main.dart             # App entry point
│   │   ├── app/
│   │   │   ├── app.dart          # Main app widget
│   │   │   ├── providers/        # State management (Auth, Calculator, Project, Machine, Theme)
│   │   │   └── screens/          # 20+ screens
│   │   │       ├── splash_screen.dart
│   │   │       ├── onboarding_screen.dart
│   │   │       ├── auth/         # Login, Register
│   │   │       ├── home/         # Dashboard
│   │   │       ├── calculators/  # 11 files (List + 10 calculators)
│   │   │       ├── projects/     # Project management
│   │   │       ├── machines/     # Machine monitoring & control
│   │   │       ├── chat/         # AI Assistant
│   │   │       └── profile/      # User profile & settings
│   │   └── core/
│   │       ├── config/           # API, App, Theme configuration
│   │       ├── constants/        # Colors, App constants
│   │       │   ├── materials_database.dart    # 80+ materials
│   │       │   ├── machines_database.dart     # 80+ machines
│   │       │   └── sensor_codes.dart          # 40+ sensor types
│   │       ├── models/           # 9 data models (User, Project, Machine, etc.)
│   │       └── services/         # 5 core services (API, Auth, Calculator, etc.)
│   └── pubspec.yaml              # 50+ Flutter packages
│
├── backend-api/                   # 🔧 Laravel REST API
│   ├── app/Http/Controllers/     # API endpoints
│   ├── app/Models/               # Database models
│   ├── database/migrations/      # 115+ materials, sensors, machines
│   └── routes/api.php            # API routes
│
├── ai-engine/                     # 🤖 Python FastAPI AI Services
│   ├── app/
│   │   ├── models/               # ML models (TensorFlow/PyTorch)
│   │   ├── services/             # AI inference services
│   │   └── main.py               # FastAPI app
│   └── requirements.txt
│
├── iot-gateway/                   # 🔌 IoT Sensor Data Gateway
│   ├── mqtt_broker/              # MQTT configuration
│   ├── processors/               # Sensor data processing
│   └── config.yaml
│
├── web-dashboard/                 # 📊 Next.js Admin Panel
│   ├── pages/                    # Dashboard pages
│   ├── components/               # React components
│   └── styles/                   # CSS/Tailwind styles
│
├── Documentation/                 # 📚 Comprehensive Guides
│   ├── README.md                 # This file
│   ├── FLUTTER_APP_COMPLETE_GUIDE.md
│   ├── UNIVERSAL_SYSTEM_GUIDE.md
│   ├── FINAL_BUILD_SUMMARY.md
│   ├── APP_DESIGN_PREVIEW.md
│   └── MOBILE_APP_PLAN.md
│
└── docker/                        # 🐳 Docker Configurations
    ├── docker-compose.yml        # All services orchestration
    └── Dockerfiles/              # Service-specific Dockerfiles
```

---

## 🛠️ Technology Stack

### **Mobile App (v2.0 - Flutter)**
- **Framework**: Flutter 3.24+ / Dart 3.5+
- **UI**: Material Design 3 with custom theming
- **State Management**: Provider pattern
- **Local Database**: SQLite (sqflite)
- **HTTP Client**: Dio with interceptors
- **IoT**: MQTT client for real-time sensor data
- **Maps**: Google Maps Flutter
- **Charts**: fl_chart for data visualization
- **Storage**: Shared Preferences, Hive
- **PDF**: pdf package for report generation
- **Camera**: image_picker, camera
- **Authentication**: JWT with secure storage

**50+ Production Packages:**
- dio, provider, sqflite, mqtt_client
- google_maps_flutter, geolocator, location
- fl_chart, syncfusion_flutter_charts
- pdf, printing, path_provider
- shared_preferences, hive, flutter_secure_storage
- image_picker, camera, photo_view
- intl, flutter_svg, cached_network_image
- connectivity_plus, permission_handler

### **Backend Services**
- **API**: Laravel 10 (PHP 8.2)
- **AI Engine**: Python 3.11, FastAPI, TensorFlow 2.14, PyTorch
- **Web Dashboard**: Next.js 14, React 18, TypeScript, Tailwind CSS
- **Database**: PostgreSQL 15 with PostGIS
- **Cache**: Redis 7
- **Message Queue**: RabbitMQ / Redis Queue
- **IoT**: MQTT Broker (Mosquitto)
- **Search**: ElasticSearch (optional)

### **Infrastructure & DevOps**
- **Containerization**: Docker, Docker Compose
- **Web Server**: Nginx
- **Deployment**: AWS / GCP / VPS
- **CI/CD**: GitHub Actions
- **Monitoring**: Prometheus, Grafana (planned)

---

## 🚀 Quick Start

### Prerequisites

**For Mobile Development:**
- Flutter SDK 3.24 or higher ([Install Flutter](https://flutter.dev/docs/get-started/install))
- Dart SDK 3.5+
- Android Studio / VS Code
- Xcode (for iOS development on macOS)
- Android SDK / iOS Simulator

**For Backend Services:**
- Docker & Docker Compose
- Node.js 18+
- PHP 8.2+ & Composer
- Python 3.11+ & pip

---

### 📱 Mobile App Setup

1. **Clone the repository:**
```bash
git clone https://github.com/otienowilli/CONSTRUCTIQ.git
cd CONSTRUCTIQ/mobile-app
```

2. **Install Flutter dependencies:**
```bash
flutter pub get
```

3. **Configure API endpoint:**
Edit `lib/core/config/api_config.dart`:
```dart
static const String baseUrl = 'http://your-api-url.com/api';
```

4. **Run the app:**
```bash
# On Android emulator/device
flutter run

# On iOS simulator (macOS only)
flutter run -d ios

# Build APK for testing
flutter build apk --release

# Build iOS app (macOS only)
flutter build ios --release
```

5. **Default Login Credentials:**
```
Email: admin@constructiq.com
Password: admin123
```

---

### 🔧 Backend Services Setup

1. **Clone the repository:**
```bash
git clone https://github.com/otienowilli/CONSTRUCTIQ.git
cd CONSTRUCTIQ
```

2. **Start all services with Docker:**
```bash
docker-compose up -d
```

3. **Run database migrations:**
```bash
docker-compose exec backend-api php artisan migrate --seed
```

4. **Access the services:**
- **Backend API**: http://localhost:8000
- **AI Engine**: http://localhost:8001
- **Web Dashboard**: http://localhost:3000
- **API Docs**: http://localhost:8000/api/documentation
- **MQTT Broker**: localhost:1883

---

## 📚 Documentation

### **Complete Guides:**
- 📱 [**Flutter App Complete Guide**](./FLUTTER_APP_COMPLETE_GUIDE.md) - Full Flutter development guide
- 🌍 [**Universal System Guide**](./UNIVERSAL_SYSTEM_GUIDE.md) - Materials, Machines & Sensor codes
- 📊 [**Final Build Summary**](./FINAL_BUILD_SUMMARY.md) - Current build status (80% complete)
- 🎨 [**App Design Preview**](./APP_DESIGN_PREVIEW.md) - UI/UX mockups (40+ screens)
- 📋 [**Mobile App Plan**](./MOBILE_APP_PLAN.md) - Development roadmap

### **Module Documentation:**
- [Backend API Setup](./backend-api/README.md)
- [AI Engine Setup](./ai-engine/README.md)
- [Mobile App Setup](./mobile-app/README.md)
- [Web Dashboard Setup](./web-dashboard/README.md)
- [IoT Gateway Setup](./iot-gateway/README.md)

---

## 📊 Project Status

| Component | Status | Completion |
|-----------|--------|------------|
| 📱 **Mobile App** | 🟢 In Development | **80%** |
| 🔧 **Backend API** | 🟢 Complete | **100%** |
| 🤖 **AI Engine** | 🟢 Complete | **100%** |
| 🔌 **IoT Gateway** | 🟢 Complete | **100%** |
| 📊 **Web Dashboard** | 🟢 Complete | **100%** |
| 🌍 **Universal System** | 🟢 Complete | **100%** |
| 📚 **Documentation** | 🟢 Complete | **100%** |

**Overall Project: 80% Complete** 🎯

---

## 🎯 Roadmap

### **v2.0 (Current - 80% Complete)**
- ✅ Complete Flutter mobile app foundation
- ✅ All 10 material calculators
- ✅ Universal materials database (80+)
- ✅ Universal machines database (80+)
- ✅ Universal sensor system (40+ codes)
- ✅ AI Chat Assistant
- 🔄 Maps & GPS integration (in progress)
- 🔄 Advanced machine control (in progress)
- 🔄 Camera-based soil analysis (planned)

### **v2.1 (Next - Q3 2026)**
- 📱 iOS App Store release
- 📱 Google Play Store release
- 📊 Advanced analytics & reports
- 🔔 Push notifications
- 🌐 Multi-language support
- 📸 Enhanced camera features

### **v3.0 (Future - Q4 2026)**
- 🤝 Team collaboration features
- 📹 Video documentation
- 🗣️ Voice commands
- 🔗 Blockchain for material tracking
- 🌍 Global marketplace for materials
- 🎓 Training & certification module

---

## 🌟 Why CONSTRUCTIQ?

### **Unique Value Propositions:**

✅ **Truly Universal** - Unlike competitors, supports materials & machines from ANY country, ANY manufacturer
✅ **Future-Proof** - Extensible architecture allows unlimited customization
✅ **Offline-First** - Works on construction sites without internet
✅ **IoT-Ready** - 40+ sensor codes support modern equipment
✅ **AI-Powered** - Machine learning for intelligent recommendations
✅ **Cross-Platform** - Single Flutter codebase for iOS & Android
✅ **Production-Ready** - Professional code quality, clean architecture

### **Competitive Advantages:**

| Feature | CONSTRUCTIQ | Competitors |
|---------|-------------|-------------|
| Materials Database | 80+ (Unlimited custom) | Fixed 10-20 |
| Machines Database | 80+ (Unlimited custom) | Fixed 5-15 |
| Sensor Support | 40+ codes (Universal) | Limited/Proprietary |
| Calculators | 10 advanced calculators | 2-5 basic |
| Offline Support | ✅ Full offline mode | ❌ Online only |
| Cross-Platform | ✅ iOS + Android | ❌ Android only |
| IoT Integration | ✅ MQTT real-time | ❌ Limited |
| AI Features | ✅ AI Assistant + ML | ❌ None |
| Global Support | ✅ Worldwide | ❌ Regional |

---

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### **Development Guidelines:**
- Follow Flutter/Dart style guide
- Write comprehensive tests
- Update documentation
- Ensure code passes all checks

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## 👥 Team & Contributors

**Lead Developer:** CONSTRUCTIQ Development Team
**Contributors:** Open Source Community

### **Special Thanks:**
- Flutter Team for the amazing framework
- Laravel Team for the robust backend
- All open-source contributors

---

## 📞 Support & Contact

### **Get Help:**
- 📧 Email: support@constructiq.com
- 💬 GitHub Issues: [Report a bug](https://github.com/otienowilli/CONSTRUCTIQ/issues)
- 📖 Documentation: [Read the docs](./FLUTTER_APP_COMPLETE_GUIDE.md)
- 💡 Discussions: [Join the conversation](https://github.com/otienowilli/CONSTRUCTIQ/discussions)

### **Follow Us:**
- 🌐 Website: www.constructiq.com (coming soon)
- 🐦 Twitter: @constructiq_app
- 💼 LinkedIn: CONSTRUCTIQ

---

## 🏆 Acknowledgments

Built with ❤️ using:
- [Flutter](https://flutter.dev) - Google's UI toolkit
- [Laravel](https://laravel.com) - PHP web framework
- [FastAPI](https://fastapi.tiangolo.com) - Modern Python API
- [PostgreSQL](https://www.postgresql.org) - Advanced database
- And 50+ amazing open-source packages

---

## ⭐ Star History

If you find CONSTRUCTIQ useful, please give it a star! ⭐

[![Star History](https://img.shields.io/github/stars/otienowilli/CONSTRUCTIQ?style=social)](https://github.com/otienowilli/CONSTRUCTIQ/stargazers)

---

<div align="center">

**CONSTRUCTIQ v2.0** - Revolutionizing Construction Management
**Status:** 80% Complete | Production-Ready Foundation
**License:** MIT | **Made with** ❤️ **for the construction industry**

[Report Bug](https://github.com/otienowilli/CONSTRUCTIQ/issues) · [Request Feature](https://github.com/otienowilli/CONSTRUCTIQ/issues) · [Documentation](./FLUTTER_APP_COMPLETE_GUIDE.md)

</div>

