# Smart Home Controller

**BIM493 – Mobile Programming I | Assignment #2 (2026–2027)**

A Flutter app for viewing and controlling three simulated smart home devices. The dashboard shows each device's current state and updates it as you interact with the controls.

---

## Team

| Full name | Student ID | Contribution |
|-----------|------------|--------------|
| Emre Çelik | 11923640488 | Event data model, Explore screen, search and category filter, README |
| Işıl Edis | 39376419406 | Details and image viewer screens, join/cancel logic, Favorites/My Events, tests |

---

## Flutter version

The project was created with Flutter **3.47.6** and Dart **3.13.5**. Check your local SDK with `flutter --version`.

## Setup and run

Open the folder containing `pubspec.yaml` in VS Code. Use Chrome for the web version, or start an Android emulator or connect a phone.

```powershell
flutter --version
flutter pub get
flutter devices
flutter run -d chrome
```

For a phone or emulator, select its ID from `flutter devices` and pass it to `flutter run -d`.

If Windows cannot find `flutter` and your SDK is installed under `C:\flutter_sdk\flutter`, add it to the current PowerShell session and retry:

```powershell
$env:Path = "C:\flutter_sdk\flutter\bin;$env:Path"
```

## Features

| Device | Information | Controls |
| --- | --- | --- |
| **Smart Light** | Brightness starts at 75%. Status shows On or Off. | Toggle the light and set a morning light preference. |
| **Thermostat** | Target temperature starts at 22 °C. Status shows the connection state. | Decrease or increase the target in 1 °C steps, from 10 to 35 °C. |
| **Smart Speaker** | Volume starts at 40%. Status shows Playing or Paused. | Play or pause. |

The **My home** dashboard displays one card per device. The bottom bar reads the total directly from the static device counter.

## Assignment requirements

| Concept | Implementation |
| --- | --- |
| Class, objects and inheritance | The dashboard creates one `SmartLight`, one `Thermostat` and one `SmartSpeaker`. All three extend `SmartDevice`. |
| Constructors | The light uses the named `SmartLight.livingRoom()` constructor. The thermostat and speaker use unnamed constructors. |
| Abstraction | `SmartDevice` is abstract and declares `getStatus()`. Each subclass supplies its own status. |
| Interface | `Connectable` defines `isConnected` and `connect()`. The subclasses share the implementation in `SmartDevice`. |
| Mixin | `SmartLight` uses `Schedulable` to hold the morning preference. |
| Dart keywords | `static` holds `totalCreated`, `super.name` forwards the name to the base constructor, and `this` initializes fields and redirects the named constructor. |

## Project structure

| Path | Purpose |
| --- | --- |
| [lib/main.dart](lib/main.dart) | App entry point, dashboard, device cards and controls |
| [lib/smart_device.dart](lib/smart_device.dart) | Device models, connection interface, mixin and static counter |
| [test/dashboard_test.dart](test/dashboard_test.dart) | Widget checks for the cards, device controls and counter |

## Test checklist

| Check | Command or coverage | Result |
| --- | --- | --- |
| Static analysis | `dart analyze` | Passed |
| Web compilation | `flutter build web` | Passed |
| Three cards, device interactions, hidden debug banner and stable counter | `flutter test` | Test startup was blocked by a local connection error in the verification environment. |
| Android runtime | Run on an emulator or phone | Pending |

## Asset credits

Device and navigation icons come from the Material Icons bundled with Flutter.

## Known limitations

Device states reset when the app restarts. The morning light preference is stored for the current session. The app simulates device actions locally, including speaker playback.

