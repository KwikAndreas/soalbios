import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:soalbios2/test/display.dart';
import 'package:soalbios2/widget/datawarna.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const SoalBIOS(),
    ),
  );
}

class SoalBIOS extends StatelessWidget {
  const SoalBIOS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: DisplayForm(),
    );
  }
}
