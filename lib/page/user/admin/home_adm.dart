import 'package:flutter/material.dart';
import 'package:soalbios2/components/adm_card.dart';
import 'package:soalbios2/components/jarak.dart';

class HomeAdm extends StatefulWidget {
  const HomeAdm({super.key});

  @override
  State<HomeAdm> createState() => _HomeAdmState();
}

class _HomeAdmState extends State<HomeAdm> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final double cardWidth = screenWidth * 0.8;
    final double subCardWidth = cardWidth * 0.145;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Container(
            width: cardWidth,
            padding: const EdgeInsets.only(left: 32, right: 32, top: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Jarak(jarak: 14, isHoriz: false),
                Container(
                  width: cardWidth * 0.8,
                  height: 156,
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Kotak22(
                        title: 'Total Quiz',
                        angka: 10,
                        lebar: subCardWidth,
                        icon: Icons.question_answer,
                      ),
                      const Spacer(),
                      Kotak22(
                        title: 'Jumlah Murid',
                        angka: 10,
                        lebar: subCardWidth,
                        icon: Icons.people,
                      ),
                      const Spacer(),
                      Kotak22(
                        title: 'Jumlah Mentor',
                        lebar: subCardWidth,
                        angka: 10,
                        icon: Icons.person,
                      ),
                      const Spacer(),
                      Kotak22(
                        title: 'Score tertinggi',
                        angka: 10,
                        lebar: subCardWidth,
                        icon: Icons.star,
                      ),
                      const Spacer(),
                      Kotaktop(
                        title: 'Top #1',
                        namaTop: 'Hansel Alexander',
                        lebar: subCardWidth,
                        icon: Icons.star,
                      )
                    ],
                  ),
                ),
                Container(
                  width: cardWidth * 0.8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
