import 'package:flutter/material.dart';

import 'smart_device.dart';

void main() => runApp(const SmartHomeApp());

class SmartHomeApp extends StatelessWidget {
  const SmartHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Controller',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF146C60),
        scaffoldBackgroundColor: const Color(0xFFF2F6F5),
        cardTheme: const CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
      home: const DeviceDashboard(),
    );
  }
}

class DeviceDashboard extends StatefulWidget {
  const DeviceDashboard({super.key});

  @override
  State<DeviceDashboard> createState() => _DeviceDashboardState();
}

class _DeviceDashboardState extends State<DeviceDashboard> {
  final _light = SmartLight.livingRoom()..connect();
  final _thermostat = Thermostat('Thermostat', temperature: 22)..connect();
  final _speaker = SmartSpeaker('Smart Speaker', volume: 40)..connect();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Home Controller')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const DashboardHeader(),
              const SizedBox(height: 16),
              DeviceCard(
                device: _light,
                icon: Icons.lightbulb_outline,
                detail: 'Brightness: ${_light.brightness}%',
                controls: [
                  SwitchListTile(
                    title: const Text('Light power'),
                    value: _light.isOn,
                    onChanged: (value) => setState(() => _light.isOn = value),
                  ),
                  SwitchListTile(
                    title: const Text('Morning light preference'),
                    value: _light.morningSchedule,
                    onChanged: (value) =>
                        setState(() => _light.morningSchedule = value),
                  ),
                ],
              ),
              DeviceCard(
                device: _thermostat,
                icon: Icons.thermostat,
                detail: 'Target temperature: ${_thermostat.temperature} °C',
                controls: [
                  Wrap(
                    children: [
                      IconButton(
                        tooltip: 'Decrease temperature',
                        onPressed: _thermostat.temperature > 10
                            ? () => setState(() => _thermostat.temperature--)
                            : null,
                        icon: const Icon(Icons.remove),
                      ),
                      IconButton(
                        tooltip: 'Increase temperature',
                        onPressed: _thermostat.temperature < 35
                            ? () => setState(() => _thermostat.temperature++)
                            : null,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
              DeviceCard(
                device: _speaker,
                icon: Icons.speaker_outlined,
                detail: 'Volume: ${_speaker.volume}%',
                controls: [
                  FilledButton.icon(
                    onPressed: () => setState(
                      () => _speaker.isPlaying = !_speaker.isPlaying,
                    ),
                    icon: Icon(
                      _speaker.isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                    label: Text(_speaker.isPlaying ? 'Pause' : 'Play'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Center(
          child: Text(
            'Total devices: ${SmartDevice.totalCreated}',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}

class DeviceCard extends StatelessWidget {
  const DeviceCard({
    super.key,
    required this.device,
    required this.icon,
    required this.detail,
    required this.controls,
  });

  final SmartDevice device;
  final IconData icon;
  final String detail;
  final List<Widget> controls;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .secondaryContainer,
                foregroundColor: Theme.of(context)
                    .colorScheme
                    .onSecondaryContainer,
                child: Icon(icon),
              ),
              title: Text(
                device.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text('$detail\nStatus: ${device.getStatus()}'),
            ),
            ...controls,
          ],
        ),
      ),
    );
  }
}

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My home',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Lighting, climate and audio',
                  style: TextStyle(color: colors.onPrimary),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(Icons.home_outlined, size: 40, color: colors.onPrimary),
        ],
      ),
    );
  }
}
