# Step Tracker App

A beautifully designed, cross-platform Flutter application for tracking your daily steps and health statistics. Built to support modern mobile platforms with a focus on clean UI and smooth interactions.

## Features

*   **Daily Step Dashboard:** View your daily step count with a beautiful circular progress indicator.
*   **Activity Rings:** Quick overview of your Move, Exercise, and Stand goals.
*   **Statistics View:** Detailed charts showing your activity over time (Weekly and Monthly views).
*   **HealthKit Ready Structure:** Built with an architecture ready to plug into `health` or `pedometer` packages for real native sensor data (Apple HealthKit & Google Fit).
*   **Mock Data Service:** Fully functional offline mode using realistic mock data for easy UI development and testing.
*   **Responsive Design:** Adapts smoothly across mobile devices.

## Tech Stack

*   **Framework:** Flutter (Dart)
*   **UI Components:** Material Design 3
*   **Charts:** Built-in custom charting using standard Flutter widgets for maximum compatibility and performance.

## Setup and Running

1.  **Prerequisites:** Ensure you have the Flutter SDK installed.
2.  **Dependencies:** Run `flutter pub get` to fetch required packages.
3.  **Run:** Execute `flutter run` to launch the app on your connected device or emulator.

### HealthKit Integration Notes

This application currently uses a `MockHealthService` to provide reliable data for embedded previews and cross-platform testing without requiring native entitlements. 

To connect to real Apple HealthKit or Google Fit data in a production environment:
1. Add a package like [`health`](https://pub.dev/packages/health) or [`pedometer`](https://pub.dev/packages/pedometer) to your `pubspec.yaml`.
2. Configure the required platform-specific entitlements:
   *   **iOS:** Add `NSHealthShareUsageDescription` and `NSHealthUpdateUsageDescription` to your `Info.plist` and enable HealthKit capabilities in Xcode.
   *   **Android:** Add `ACTIVITY_RECOGNITION` and body sensor permissions to your `AndroidManifest.xml`.
3. Swap out the `MockHealthService` with an implementation that calls the native platform APIs.

---

### CouldAI

This application was generated with [CouldAI](https://could.ai), an AI app builder for cross-platform apps that turns prompts into real native iOS, Android, Web, and Desktop apps with autonomous AI agents that architect, build, test, deploy, and iterate production-ready applications.
