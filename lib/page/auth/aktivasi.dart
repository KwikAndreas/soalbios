import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soalbios2/components/jarak.dart';
import 'package:soalbios2/components/tombol.dart';
import 'package:soalbios2/page/auth/login.dart';
import 'package:soalbios2/page/user/home.dart';
import 'package:soalbios2/widget/datawarna.dart';

class Aktivasi extends StatefulWidget {
  const Aktivasi({super.key});

  @override
  State<Aktivasi> createState() => _AktivasiState();
}

class _AktivasiState extends State<Aktivasi> {
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _uniqueCodeController = TextEditingController();

  final FocusNode nimFocus = FocusNode();
  final FocusNode uniqueCodeFocus = FocusNode();
  final FocusNode aktifFocus = FocusNode();

  final double inputWidth = 400;
  final double inputHeight = 64;

  void aktivasiAkun() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeSoalBIOS()));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cardWidth = screenWidth * 0.7;
    final cardHeight = screenHeight * 0.5;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aktivasi akun',
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
                              color: Colors.black87,
                              blurRadius: 2,
                              offset: Offset(1, -1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Jarak(jarak: 36, isHoriz: false),
              SizedBox(
                width: inputWidth,
                height: inputHeight,
                child: TextFormField(
                  controller: _nimController,
                  focusNode: nimFocus,
                  cursorColor: Datawarna.secondaryColor,
                  decoration: InputDecoration(
                    hintText: 'Masukkan NIM',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: Datawarna.tertiaryColor,
                        width: 1.75,
                      ),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(uniqueCodeFocus);
                  },
                ),
              ),
              SizedBox(
                width: inputWidth,
                height: inputHeight,
                child: TextFormField(
                  controller: _uniqueCodeController,
                  focusNode: uniqueCodeFocus,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Kode Aktivasi',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: Datawarna.tertiaryColor,
                        width: 1.75,
                      ),
                    ),
                    prefixIcon: const Icon(Icons.key),
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(aktifFocus);
                  },
                ),
              ),
              SizedBox(
                width: inputWidth,
                height: 20,
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const LoginScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(-1.0, 0);
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
                        'Sudah Aktivasi akun?, ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Login disini',
                        style: TextStyle(
                          fontSize: 16,
                          color: Datawarna.secondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Jarak(jarak: 16, isHoriz: false),
              TombolAktivasi(
                width: inputWidth,
                onPressed: aktivasiAkun,
                node: aktifFocus,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
