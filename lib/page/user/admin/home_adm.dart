import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soalbios2/components/adm_card.dart';
import 'package:soalbios2/components/jarak.dart';

class HomeAdm extends StatefulWidget {
  const HomeAdm({super.key});

  @override
  State<HomeAdm> createState() => _HomeAdmState();
}

class _HomeAdmState extends State<HomeAdm> {
  int totalQuiz = 0;
  int jumlahMurid = 0;
  int scoreTertinggi = 0;
  String namaTop1 = 'Tidak diketahui';

  void loadData() async {
    final firestore = FirebaseFirestore.instance;

    try {
      // final quizSnapshot = await firestore.collection('quiz').get();
      // if (mounted) {
      //   setState(() {
      //     totalQuiz = quizSnapshot.docs.length;
      //   });
      // }

      final studentSnapshot = await firestore.collection('student').get();
      print("Jumlah Murid: ${studentSnapshot.docs.length}");

      if (mounted) {
        setState(() {
          jumlahMurid = studentSnapshot.docs.length;
        });
      }

      if (studentSnapshot.docs.isNotEmpty) {
        final List<Map<String, dynamic>> studentsData = studentSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        Map<String, dynamic>? highestScoreStudent;
        int maxScore = 0;

        for (var student in studentsData) {
          final int currentScore = student['score'] is int
              ? student['score']
              : int.tryParse(student['score'].toString()) ?? 0;

          if (currentScore > maxScore) {
            maxScore = currentScore;
            highestScoreStudent = student;
          }
        }

        if (highestScoreStudent != null) {
          if (mounted) {
            setState(() {
              scoreTertinggi = maxScore;
              namaTop1 =
                  highestScoreStudent?['nama'] as String? ?? 'Tidak diketahui';
            });
          }
        }
      }
    } catch (e) {
      print("Error loading data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

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
                        angka: totalQuiz,
                        lebar: subCardWidth,
                        icon: Icons.question_answer,
                      ),
                      const Spacer(),
                      Kotak22(
                        title: 'Jumlah Murid',
                        angka: jumlahMurid,
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
                        angka: scoreTertinggi,
                        lebar: subCardWidth,
                        icon: Icons.star,
                      ),
                      const Spacer(),
                      Kotaktop(
                        title: 'Top #1',
                        namaTop: namaTop1,
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
