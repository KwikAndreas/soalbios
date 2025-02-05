import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soalbios2/page/auth/login.dart';
import 'package:soalbios2/page/user/admin/create_quiz.dart';
import 'package:soalbios2/page/user/admin/generate.dart';
import 'package:soalbios2/page/user/admin/home_adm.dart';
import 'package:soalbios2/widget/datawarna.dart';

class IndexAdm extends StatefulWidget {
  const IndexAdm({super.key});

  @override
  State<IndexAdm> createState() => _IndexAdmState();
}

class _IndexAdmState extends State<IndexAdm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Map<String, Widget> _pages = {
    // Home statistics
    'Home': const HomeAdm(),
    //Buat akun-unique code
    'Generate': const Generate(),
    'Quiz': const CreateQuiz(),
  };
  String _selectedPage = 'Generate';

  double iconSize = 27;

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Datawarna.secondaryColor,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Datawarna.putih,
              size: 28,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _selectedPage,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 27,
                ),
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedPage]!,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Datawarna.secondaryColor),
              child: Image.asset(
                'assets/bios/bios.png',
                fit: BoxFit.contain,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home_filled,
                size: iconSize,
              ),
              title: const Text('Home'),
              onTap: () {
                setState(() {
                  _selectedPage = 'Home';
                });
                Navigator.pop(context);
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Manajemen Soal BIOS",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.manage_accounts,
                size: iconSize,
              ),
              title: const Text("Generate"),
              onTap: () {
                setState(() {
                  _selectedPage = 'Generate';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.question_answer,
                size: iconSize,
              ),
              title: const Text("Quiz"),
              onTap: () {
                setState(() {
                  _selectedPage = 'Quiz';
                });
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.logout,
                size: iconSize,
              ),
              title: const Text('Logout'),
              onTap: () {
                logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
