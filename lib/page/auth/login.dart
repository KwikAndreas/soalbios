import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soalbios2/components/input.dart';
import 'package:soalbios2/components/jarak.dart';
import 'package:soalbios2/components/tombol.dart';
import 'package:soalbios2/page/auth/aktivasi.dart';
import 'package:soalbios2/page/user/admin/index_adm.dart';
import 'package:soalbios2/page/user/student/homeStudent.dart';
import 'package:soalbios2/widget/datawarna.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isTextHidden = true;

  final double inputWidth = 400;
  final double inputHeight = 64;

  final FocusNode nimFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  final FocusNode loginFocus = FocusNode();

  void login() async {
    String nim = _nimController.text;
    String email =
        nim == "32230111" ? "$nim@admin.ubm.ac.id" : "$nim@student.ubm.ac.id";
    String password = _passwordController.text;

    try {
      if (nim == "32230111") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('nim', nim);
        await prefs.setBool('isLoggedIn', true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const IndexAdm()),
        );
        return;
      }

      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('student').doc(nim).get();

      if (!userDoc.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Akun tidak ditemukan!")),
        );
        return;
      }

      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      bool isActive = userData['isActive'] ?? false;
      int device = userData['device'] ?? 0;

      if (!isActive) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Akun Belum Aktif"),
            content: const Text(
                "Akun Anda belum aktif. Silakan aktifkan akun terlebih dahulu."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Aktivasi()),
                  );
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
        return;
      }

      if (device <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Device limit sudah habis!")),
        );
        return;
      }

      await FirebaseFirestore.instance
          .collection('student')
          .doc(nim)
          .update({'device': device - 1});

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('nim', nim);
      await prefs.setBool('isLoggedIn', true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeStudent()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login gagal: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cardWidth = screenWidth * 0.7;
    final cardHeight = screenHeight * 0.5;

    return Scaffold(
      backgroundColor: Datawarna.bg,
      body: Center(
        child: SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: Column(
            children: [
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                          color: Colors.black.withOpacity(0.6)),
                    ),
                    const Jarak(
                      jarak: 18,
                      isHoriz: true,
                    ),
                    Text(
                      'SOALBIOS',
                      softWrap: true,
                      style: GoogleFonts.atma(
                        textStyle: const TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                          color: Datawarna.secondaryColor,
                          shadows: [
                            Shadow(
                              color: Datawarna.hitam,
                              blurRadius: 3,
                              offset: Offset(1.25, -1.25),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Jarak(
                jarak: 36,
                isHoriz: false,
              ),
              InputUID(
                controller: _nimController,
                node: nimFocus,
                targetNode: passFocus,
                width: inputWidth,
                height: inputHeight,
              ),
              InputPass(
                controller: _passwordController,
                node: passFocus,
                targetNode: loginFocus,
                width: inputWidth,
                height: inputHeight,
                isTextHidden: _isTextHidden,
                onTap: () {
                  setState(() {
                    _isTextHidden = !_isTextHidden;
                  });

                  if (!_isTextHidden) {
                    Future.delayed(const Duration(milliseconds: 700), () {
                      setState(() {
                        _isTextHidden = true;
                      });
                    });
                  }
                },
              ),
              SizedBox(
                width: inputWidth,
                height: 20,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const Aktivasi(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Belum Aktifkan Akun?,',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Jarak(jarak: 8, isHoriz: true),
                      Text(
                        'Aktifkan disini',
                        style: TextStyle(
                          fontSize: 16,
                          color: Datawarna.secondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Jarak(jarak: 16, isHoriz: false),
              TombolLogin(
                onPressed: login,
                width: inputWidth,
                node: loginFocus,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
