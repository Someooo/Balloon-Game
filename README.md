# Balloon Game

[![Flutter](https://img.shields.io/badge/Flutter-Material%203-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Unity 6](https://img.shields.io/badge/Unity%206-Unity%20as%20a%20Library-000000?logo=unity&logoColor=white)](https://unity.com)
[![Android](https://img.shields.io/badge/Android-API%2026--36-3DDC84?logo=android&logoColor=white)](https://developer.android.com)
[![Repository](https://img.shields.io/badge/GitHub-Someooo%2FBalloon--Game-181717?logo=github)](https://github.com/Someooo/Balloon-Game)

An enterprise-grade Flutter application integrating an embedded **Unity 6** game runtime (**Unity as a Library**) via `flutter_embed_unity`. Engineered with Clean Architecture and on-demand native engine initialization to achieve zero cold-start latency.

---

## 1. Overview

**Balloon Game** combines a Material 3 Flutter shell with an interactive 3D/2D Unity 6 experience embedded directly into the widget tree:

- **Unity as a Library (UaaL):** The Unity 6 runtime is compiled and packaged as a native Android library module (`unityLibrary`) hosted inside the Flutter project (`flutter_embed_unity`).
- **On-Demand Engine Initialization (Zero Cold-Start Latency):** Instead of bootstrapping the heavy Unity engine on application launch, the app starts immediately into a lightweight Flutter entry screen (`WelcomePage`). The Unity runtime is initialized strictly on demand when the user navigates to `UnityPreviewScreen` and mounts the `EmbedUnity` widget.

---

## 2. Architecture

### Clean Architecture (`lib/features/welcome/`)

The Flutter presentation layer follows Clean Architecture principles, isolating immutable domain models from modular UI components:

```text
lib/
├── main.dart                                           # App entry point & Material 3 theme config
├── unity_preview_screen.dart                           # Embedded Unity viewport & messaging bridge
└── features/
    └── welcome/
        ├── domain/
        │   └── entities/
        │       └── welcome_content.dart                # Immutable domain entity for welcome screen state
        └── presentation/
            ├── pages/
            │   └── welcome_page.dart                   # Entry screen orchestrating navigation to Unity
            └── widgets/
                ├── start_play_button.dart              # CTA control triggering on-demand Unity launch
                ├── welcome_header_section.dart         # Typography & title layout component
                └── welcome_logo_badge.dart             # Branded hero badge component
```

### Android 12+ Native Splash Setup

- Configured via `flutter_native_splash` with full **Android 12+ SplashScreen API** support (`values-v31/styles.xml`) and legacy fallback drawables.
- Hands off seamlessly from the OS launch window to the Flutter `WelcomePage` without white-flash frames or blocking native library loads.

### Bidirectional Flutter <-> Unity Communication Bridge

Implemented in `lib/unity_preview_screen.dart`, enabling real-time full-duplex messaging between Dart and the Unity C# runtime:

| Direction | Mechanism | Implementation Detail |
| :--- | :--- | :--- |
| **Flutter -> Unity** | `sendToUnity('GameManager', 'RestartGame', '')` | Invokes `RestartGame` on the `GameManager` GameObject inside the active Unity scene. |
| **Unity -> Flutter** | `EmbedUnity(onMessageFromUnity: _handleUnityMessage)` | Listens to incoming Unity JSON/event payloads and updates the UI reactively via `ValueNotifier<String>` without rebuilding the `EmbedUnity` viewport. |

---

## 3. Technical Specs & Setup

### Technical Specifications

| Parameter | Configuration |
| :--- | :--- |
| **Engine Integration** | Unity 6 (`unityLibrary`) via `flutter_embed_unity: ^1.2.1` |
| **Android SDK Versions** | `compileSdk 36` · `targetSdk 36` · `minSdk 26` |
| **Supported ABIs** | `arm64-v8a`, `armeabi-v7a` |
| **Binary Storage** | Git LFS (`*.so` native engine & IL2CPP binaries tracked via `.gitattributes`) |

### Quick Start

> **Note:** No local Unity Editor installation is required. The pre-exported Unity 6 Android library and native `.so` binaries are versioned directly in this repository via Git LFS.

```bash
# 1. Clone the repository and pull Git LFS native binaries (.so)
git clone https://github.com/Someooo/Balloon-Game.git
cd Balloon-Game
git lfs pull

# 2. Fetch Flutter dependencies
flutter pub get

# 3. Build and run on a connected Android device (arm64-v8a / armeabi-v7a)
flutter run
```
