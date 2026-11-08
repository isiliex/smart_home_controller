abstract interface class Connectable {
  bool get isConnected;
  void connect();
}

mixin Schedulable {
  bool morningSchedule = false;
}

abstract class SmartDevice implements Connectable {
  SmartDevice(this.name) {
    totalCreated++;
  }

  static int totalCreated = 0;
  final String name;

  @override
  bool isConnected = false;

  @override
  void connect() => isConnected = true;

  String getStatus();
}

class SmartLight extends SmartDevice with Schedulable {
  SmartLight(super.name, {required this.brightness});

  SmartLight.livingRoom() : this('Smart Light', brightness: 75);

  final int brightness;
  bool isOn = false;

  @override
  String getStatus() => isOn ? 'On' : 'Off';
}

class Thermostat extends SmartDevice {
  Thermostat(super.name, {required this.temperature});

  int temperature;

  @override
  String getStatus() => isConnected ? 'Connected' : 'Offline';
}

class SmartSpeaker extends SmartDevice {
  SmartSpeaker(super.name, {required this.volume});

  final int volume;
  bool isPlaying = false;

  @override
  String getStatus() => isPlaying ? 'Playing' : 'Paused';
}
