# CONSTRUCTIQ Mobile App (Android)

Native Android application for CONSTRUCTIQ construction management platform.

## Features

- ✅ **Offline-First Architecture** - Works without internet connection
- ✅ **GPS Integration** - Automatic location tracking
- ✅ **Camera Integration** - Capture site photos
- ✅ **Material Calculator** - All 7 calculation types
- ✅ **Project Management** - Create and manage projects
- ✅ **Site Analysis** - Upload and analyze site images
- ✅ **AI Chatbot** - Get construction guidance
- ✅ **Background Sync** - Automatic data synchronization
- ✅ **Real-time Updates** - Live project updates

## Tech Stack

- **Language**: Kotlin
- **UI**: Jetpack Compose
- **Architecture**: MVVM + Clean Architecture
- **Database**: Room (SQLite)
- **Networking**: Retrofit + OkHttp
- **DI**: Hilt/Dagger
- **Location**: Google Play Services
- **Camera**: CameraX
- **Background Work**: WorkManager
- **Maps**: Google Maps SDK

## Prerequisites

- Android Studio Hedgehog (2023.1.1) or later
- JDK 17
- Android SDK 34
- Minimum Android version: 7.0 (API 24)
- Target Android version: 14 (API 34)

## Setup

### 1. Clone Repository

```bash
git clone https://github.com/your-org/constructiq.git
cd constructiq/mobile-app
```

### 2. Configure API URLs

Edit `app/build.gradle`:

```gradle
buildConfigField "String", "API_URL", "\"http://your-server:8000/api\""
buildConfigField "String", "AI_ENGINE_URL", "\"http://your-server:8001\""
```

For local development (emulator):
- Use `http://10.0.2.2:8000/api` for localhost

### 3. Add Google Maps API Key

1. Get API key from [Google Cloud Console](https://console.cloud.google.com/)
2. Edit `app/src/main/AndroidManifest.xml`:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_GOOGLE_MAPS_API_KEY" />
```

### 4. Build and Run

```bash
# Open in Android Studio
# OR use command line:

# Debug build
./gradlew assembleDebug

# Release build
./gradlew assembleRelease

# Install on device
./gradlew installDebug
```

## Project Structure

```
mobile-app/
├── app/
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/constructiq/
│   │   │   │   ├── data/          # Data layer
│   │   │   │   │   ├── local/     # Room database
│   │   │   │   │   ├── remote/    # API services
│   │   │   │   │   └── repository/
│   │   │   │   ├── domain/        # Business logic
│   │   │   │   │   ├── model/
│   │   │   │   │   └── usecase/
│   │   │   │   ├── presentation/  # UI layer
│   │   │   │   │   ├── screens/
│   │   │   │   │   ├── components/
│   │   │   │   │   └── viewmodel/
│   │   │   │   └── util/          # Utilities
│   │   │   ├── res/               # Resources
│   │   │   └── AndroidManifest.xml
│   │   └── test/                  # Unit tests
│   └── build.gradle
├── build.gradle
└── settings.gradle
```

## Key Features Implementation

### Offline-First

- Room database stores all data locally
- WorkManager syncs data when online
- Conflict resolution for concurrent edits

### GPS Integration

```kotlin
// Location tracking
val locationManager = LocationManager(context)
locationManager.getCurrentLocation { location ->
    // Use location
}
```

### Camera Integration

```kotlin
// Capture photo
CameraScreen(
    onPhotoCaptured = { uri ->
        // Process photo
    }
)
```

### Material Calculator

All 7 calculation types available offline:
- Concrete
- Brickwork
- Plastering
- Painting
- Excavation
- Road Construction
- Roofing

## Building for Release

### 1. Generate Keystore

```bash
keytool -genkey -v -keystore constructiq.keystore \
  -alias constructiq -keyalg RSA -keysize 2048 -validity 10000
```

### 2. Configure Signing

Create `keystore.properties`:

```properties
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=constructiq
storeFile=../constructiq.keystore
```

### 3. Build Release APK

```bash
./gradlew assembleRelease
```

APK location: `app/build/outputs/apk/release/app-release.apk`

### 4. Build App Bundle (for Play Store)

```bash
./gradlew bundleRelease
```

Bundle location: `app/build/outputs/bundle/release/app-release.aab`

## Testing

### Unit Tests

```bash
./gradlew test
```

### Instrumented Tests

```bash
./gradlew connectedAndroidTest
```

### UI Tests

```bash
./gradlew connectedDebugAndroidTest
```

## Deployment

### Google Play Store

1. Create developer account
2. Create app listing
3. Upload app bundle
4. Complete store listing
5. Submit for review

### Direct Distribution

1. Build release APK
2. Enable "Unknown Sources" on device
3. Transfer and install APK

## Troubleshooting

### Build Errors

- Clean and rebuild: `./gradlew clean build`
- Invalidate caches in Android Studio
- Update Gradle and dependencies

### Network Issues

- Check API URLs in build.gradle
- Verify server is running
- Check device internet connection
- For emulator, use `10.0.2.2` for localhost

### Location Not Working

- Enable location permissions
- Check GPS is enabled
- Test on physical device (emulator GPS is limited)

## Performance Optimization

- Use ProGuard/R8 for code shrinking
- Optimize images and resources
- Implement pagination for large lists
- Use lazy loading for images
- Cache API responses

## Security

- API keys stored in BuildConfig (not in VCS)
- HTTPS for all API calls
- Encrypted local storage for sensitive data
- Certificate pinning for production

## Contributing

1. Fork repository
2. Create feature branch
3. Make changes
4. Write tests
5. Submit pull request

## License

MIT License

## Support

- Email: support@constructiq.com
- Documentation: https://docs.constructiq.com
- Issues: https://github.com/your-org/constructiq/issues

