import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_home_controller/main.dart';

void main() {
  testWidgets(
    'Dashboard controls update device status and preserve the count',
    (tester) async {
      tester.view.physicalSize = const Size(430, 1200);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const SmartHomeApp());
      expect(
        tester
            .widget<MaterialApp>(find.byType(MaterialApp))
            .debugShowCheckedModeBanner,
        isFalse,
      );
      expect(find.byType(DeviceCard), findsNWidgets(3));
      expect(find.text('Total devices: 3'), findsOneWidget);
      expect(find.text('Brightness: 75%\nStatus: Off'), findsOneWidget);
      expect(
        find.text('Target temperature: 22 °C\nStatus: Connected'),
        findsOneWidget,
      );
      expect(find.text('Volume: 40%\nStatus: Paused'), findsOneWidget);

      await tester.tap(find.text('Light power'));
      await tester.tap(find.text('Morning light preference'));
      await tester.tap(find.byTooltip('Increase temperature'));
      await tester.tap(find.text('Play'));
      await tester.pumpAndSettle();

      expect(find.text('Brightness: 75%\nStatus: On'), findsOneWidget);
      expect(
        find.text('Target temperature: 23 °C\nStatus: Connected'),
        findsOneWidget,
      );
      expect(find.text('Volume: 40%\nStatus: Playing'), findsOneWidget);
      expect(find.text('Total devices: 3'), findsOneWidget);
    },
  );
}
