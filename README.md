# Smart Home Controller

BIM493 Mobile Programming I · Assignment 2

A Flutter dashboard that simulates three smart devices. It works with local
state and does not require physical devices.

## Run

Open this folder (the one containing pubspec.yaml) in VS Code. Select an
Android emulator, a phone, or Chrome, then run:

```sh
flutter pub get
flutter run
```

## Devices

- **Smart Light** shows brightness and supports an on/off switch.
- **Thermostat** changes its target temperature in 1 °C steps.
- **Smart Speaker** shows volume and supports simulated play/pause.

The morning schedule switch stores a preference for the current session.
It does not trigger an automatic action.

## Dart concepts

In lib/smart_device.dart, SmartDevice is abstract and defines getStatus().
SmartLight, Thermostat, and SmartSpeaker extend it and implement the
Connectable interface through the base class. SmartLight uses Schedulable.
The dashboard uses the named SmartLight.livingRoom constructor and unnamed
constructors for the thermostat and speaker. The model uses this and super
for initialization and a static counter for the total shown on screen.
