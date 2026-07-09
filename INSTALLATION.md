# Installation Guide

This guide will help you set up your development environment, clone the repository, and run NuruTouch on an Android device or emulator.

## 🛠️ Prerequisites

Before you begin, ensure you have the following installed on your system:

1.  **Flutter SDK** (Version 3.11.0 or higher)
    *   Follow the official installation guide: [Flutter Install Guide](https://docs.flutter.dev/get-started/install)
    *   Ensure the `flutter` command is available in your system's PATH.
2.  **Android Studio** (with Android SDK)
    *   Required for building the Android APK and running emulators.
    *   Download from [Android Studio](https://developer.android.com/studio).
3.  **Git**
    *   For cloning the repository.

### Hardware Requirements for Deployment
NuruTouch is optimized for low-end devices. The target minimum spec is:
*   **OS:** Android 9.0 (API Level 28) or higher
*   **RAM:** 2 GB Minimum (Helio A22 processor equivalent)
*   **Hardware:** A functioning speaker and vibration motor (ERM or LRA).

*Note: iOS is currently outside the scope of the core research MVP, though the Flutter codebase is platform-agnostic.*

---

## 🚀 Setup Instructions

### 1. Clone the Repository

Open your terminal or command prompt and run:

```bash
git clone <your-repository-url>
cd nurutouch
```

### 2. Install Dependencies

Fetch all the required Flutter packages defined in `pubspec.yaml`:

```bash
flutter pub get
```

### 3. Verify Your Environment

Run the Flutter doctor to ensure your local setup (Android Studio, SDKs, Java version) is correctly configured and ready to build:

```bash
flutter doctor
```
Resolve any errors flagged by the doctor before proceeding.

### 4. Run Static Analysis & Tests (Optional but Recommended)

Ensure the codebase is healthy:

```bash
flutter analyze
flutter test
```

---

## 📱 Running the Application

### Option A: Running on a Physical Device (Recommended)
Because NuruTouch heavily relies on **haptic feedback** (vibration) and **touch exploration**, it is highly recommended to run the app on a physical Android device.

1. Enable **Developer Options** and **USB Debugging** on your Android phone.
2. Connect your phone to your computer via USB.
3. Verify your device is recognized by Flutter:
   ```bash
   flutter devices
   ```
4. Run the app:
   ```bash
   flutter run
   ```

### Option B: Running on an Emulator
You can run the app on an Android Emulator, but note that **haptic feedback will not function**, making it difficult to test the tactile Braille learning phases.

1. Open Android Studio -> Virtual Device Manager -> Start an Emulator.
2. Run the app:
   ```bash
   flutter run
   ```

---

## 📦 Building an APK for Distribution

To generate a standalone APK file that you can share or install manually on devices (e.g., for the 6-week pilot deployment):

```bash
flutter build apk --release
```

The compiled APK will be located at:
`build/app/outputs/flutter-apk/app-release.apk`

---

## 🔒 Accessing the Hidden Portals
NuruTouch uses strict security to keep learners out of administrative areas. When testing the app, use these hidden gestures on the **Splash Screen** to access the portals:

*   **Teacher Portal:** `Long Press` anywhere on the splash screen.
    *   *Default Dev PIN:* `1234`
*   **Parent Portal:** `Double Tap` anywhere on the splash screen.
    *   *Default Dev PIN:* `5678`
