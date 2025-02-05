import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:soalbios2/components/logo_bios.dart';
import 'package:soalbios2/page/auth/aktivasi.dart';
import 'package:soalbios2/page/auth/login.dart';
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
      title: 'Soal BIOS',
      home: const LoginScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );

    _animationController!.forward();

    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          // ignore: prefer_const_constructors
          builder: (BuildContext context) => LoginScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  Future<void> checkUser() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Datawarna.bg,
      body: Center(
        child: FadeTransition(
          opacity: _animation!,
          child: const LogoBios(
            size: 320,
          ),
        ),
      ),
    );
  }
}
