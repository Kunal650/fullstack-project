# Android App Documentation

This directory contains the native Android application built with Kotlin and Jetpack Compose.

## Structure

```
android/
├── app/
│   ├── build.gradle              # App-level build configuration
│   └── src/main/
│       ├── AndroidManifest.xml   # App manifest
│       ├── java/com/projectapp/android/
│       │   ├── data/             # Data layer
│       │   │   ├── api/          # API service interfaces
│       │   │   ├── model/        # Data models
│       │   │   └── repository/   # Repository implementations
│       │   ├── navigation/       # Navigation setup
│       │   ├── ui/               # UI layer
│       │   │   ├── screens/      # Compose screens
│       │   │   └── theme/        # Material Design theme
│       │   ├── MainActivity.kt   # Main activity
│       │   └── ProjectAppApplication.kt # Application class
│       └── res/                  # Resources
│           ├── values/
│           │   ├── strings.xml   # String resources
│           │   └── themes.xml    # Theme definitions
│           └── mipmap/           # App icons
├── build.gradle                  # Project-level build configuration
├── settings.gradle               # Project settings
└── gradle.properties            # Gradle properties
```

## Features

- **Modern UI**: Built with Jetpack Compose and Material Design 3
- **MVVM Architecture**: Clean architecture with Repository pattern
- **Dependency Injection**: Hilt for dependency management
- **Navigation**: Jetpack Navigation Compose
- **Networking**: Retrofit with OkHttp for API calls
- **State Management**: Compose state and ViewModel
- **Database**: Room for local data storage
- **Security**: EncryptedSharedPreferences for secure token storage

## Technology Stack

- **Language**: Kotlin
- **UI Framework**: Jetpack Compose
- **Architecture**: MVVM + Repository Pattern
- **Dependency Injection**: Hilt
- **Networking**: Retrofit + OkHttp
- **Database**: Room
- **Navigation**: Navigation Compose
- **Image Loading**: Coil
- **Testing**: JUnit, Mockito, Espresso

## Getting Started

### Prerequisites

- Android Studio Arctic Fox or later
- JDK 8 or later
- Android SDK 24+ (minimum), 33 (target)
- Kotlin 1.8.20+

### Setup

1. Open Android Studio
2. Open the `android` folder as a project
3. Sync Gradle files
4. Run the app on an emulator or device

### Troubleshooting Build Issues

If you encounter build errors, try these solutions:

#### Option 1: Use the Simple Build Configuration

If you're having dependency conflicts, replace the `build.gradle` file:

```bash
# Backup the current build.gradle
mv android/app/build.gradle android/app/build.gradle.backup

# Use the simplified version
mv android/app/build.gradle.simple android/app/build.gradle
```

#### Option 2: Clean and Rebuild

```bash
cd android
./gradlew clean
./gradlew build
```

#### Option 3: Update Gradle Wrapper

```bash
cd android
./gradlew wrapper --gradle-version=8.0
```

#### Option 4: Check Android Studio Version

Make sure you're using Android Studio Arctic Fox (2020.3.1) or later. Older versions may have compatibility issues.

### Configuration

1. Update the API base URL in the network configuration
2. Configure your signing keys for release builds
3. Update app icons and branding in the `res` folder

## API Integration

The app is configured to work with the Django REST API backend:

- **Base URL**: `http://localhost:8000/api/v1/`
- **Authentication**: JWT tokens
- **Endpoints**:
  - `POST /auth/login/` - User login
  - `POST /auth/register/` - User registration
  - `POST /auth/token/refresh/` - Token refresh
  - `GET /auth/profile/` - User profile
  - `PUT /auth/update/` - Update profile
  - `GET /health/` - Health check

## Architecture

### Data Layer
- **Models**: Data classes representing API responses
- **API Service**: Retrofit interface for API calls
- **Repository**: Abstraction layer for data operations

### UI Layer
- **Screens**: Compose UI screens
- **ViewModels**: State management and business logic
- **Navigation**: Screen navigation setup

### Dependency Injection
- **Hilt**: Provides dependencies throughout the app
- **Modules**: Define how dependencies are created

## Development

### Adding New Features

1. Create data models in `data/model/`
2. Add API endpoints in `data/api/`
3. Implement repository methods in `data/repository/`
4. Create UI screens in `ui/screens/`
5. Add navigation routes in `navigation/`
6. Update ViewModels for state management

### Testing

Run tests using:
```bash
./gradlew test          # Unit tests
./gradlew connectedAndroidTest  # Instrumented tests
```

## Build Variants

- **Debug**: Development build with logging
- **Release**: Production build with optimizations

## Performance

- **Proguard**: Code obfuscation and optimization
- **Image Optimization**: Coil for efficient image loading
- **Memory Management**: Proper lifecycle management
- **Background Tasks**: Coroutines for async operations

## Security

- **Network Security**: HTTPS enforcement
- **Token Storage**: EncryptedSharedPreferences
- **Input Validation**: Client-side validation
- **Certificate Pinning**: For production builds

## Deployment

1. Generate signed APK/AAB
2. Test on various devices
3. Upload to Google Play Store
4. Configure app signing
5. Set up crash reporting and analytics

## Common Issues and Solutions

### Build Errors

1. **Gradle Version Conflicts**: Use the simplified build.gradle
2. **SDK Version Issues**: Ensure you have the correct SDK versions
3. **Dependency Conflicts**: Check for version mismatches

### Runtime Issues

1. **Network Errors**: Check API endpoints and network permissions
2. **UI Issues**: Verify Compose version compatibility
3. **Navigation Issues**: Check navigation dependencies

### Development Issues

1. **Emulator Problems**: Use a physical device or different emulator
2. **Sync Issues**: Clean and rebuild the project
3. **Code Issues**: Check Kotlin version compatibility