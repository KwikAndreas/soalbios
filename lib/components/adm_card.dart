import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soalbios2/components/jarak.dart';

class Kotak22 extends StatelessWidget {
  final String title;
  final int angka;
  final double lebar;
  final IconData icon;
  const Kotak22({
    super.key,
    required this.title,
    required this.angka,
    required this.lebar,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: lebar,
      height: 144,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(2, 5),
            spreadRadius: 1.5,
          )
        ],
        border: Border.all(
          width: 0.4,
          color: Colors.black.withOpacity(0.3),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              softWrap: true,
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              angka.toString(),
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Kotaktop extends StatelessWidget {
  final String title;
  final String namaTop;
  final double lebar;
  final IconData icon;
  const Kotaktop(
      {super.key,
      required this.title,
      required this.namaTop,
      required this.lebar,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: lebar,
      height: 144,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(2, 5),
            spreadRadius: 1.5,
          )
        ],
        border: Border.all(
          width: 0.4,
          color: Colors.black.withOpacity(0.3),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              softWrap: true,
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Jarak(jarak: 10, isHoriz: false),
            AutoSizeText(
              namaTop,
              maxLines: 1,
              minFontSize: 14,
              maxFontSize: 32,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
