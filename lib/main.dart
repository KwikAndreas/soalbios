import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soalbios2/components/logo_bios.dart';
import 'package:soalbios2/page/auth/login.dart';
import 'package:soalbios2/page/user/admin/index_adm.dart';
import 'package:soalbios2/page/user/student/homeStudent.dart';
import 'package:soalbios2/widget/datawarna.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyCXwGFpkJ5LrVbROqyda93_VuFacjMq2mM",
          appId: "1:316111481137:web:3dae3dafe7d8faae9b6810",
          messagingSenderId: "316111481137",
          projectId: "soalbios",
        ),
      );
    }
    runApp(const SoalBIOS());
  } catch (e) {
    print("Firebase Initialization Error: $e");
  }
}

class SoalBIOS extends StatelessWidget {
  const SoalBIOS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      title: 'Soal BIOS',
      home: const SplashScreen(),
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

  List<String> specialNIMs = ["32230111", "32230099", "32230110"];

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

    Future.delayed(const Duration(milliseconds: 1500), checkUser);
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  Future<void> checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String? nim = prefs.getString('nim');

    if (isLoggedIn && nim != null) {
      if (specialNIMs.contains(nim)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const IndexAdm()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeStudent()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

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
