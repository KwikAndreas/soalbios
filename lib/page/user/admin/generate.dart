import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soalbios2/components/jarak.dart';
import 'package:soalbios2/widget/datawarna.dart';
import 'package:flutter/services.dart';

class Generate extends StatefulWidget {
  const Generate({super.key});

  @override
  State<Generate> createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  final TextEditingController _tambahakunController = TextEditingController();
  final FocusNode tambah = FocusNode();
  List<Map<String, TextEditingController>> _accounts = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoFetch();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startAutoFetch() {
    _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      setState(() {});
    });
  }

  String _generateUniqueCode() {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        10, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  void _generateAkun() {
    int jumlah = int.tryParse(_tambahakunController.text) ?? 0;
    if (jumlah <= 0) return;

    if (jumlah > 0) {
      setState(() {
        _accounts = List.generate(
          jumlah,
          (index) => {
            'nim': TextEditingController(),
            'nama': TextEditingController(),
            'password': TextEditingController(),
            'uniqueCode': TextEditingController(text: _generateUniqueCode()),
          },
        );
        _tambahakunController.clear();
      });
    }
  }

  void _saveToFirebase() async {
    for (var account in _accounts) {
      String nim = account['nim']!.text;
      String email = "$nim@student.ubm.ac.id";
      String nama = account['nama']!.text;
      String password = account['password']!.text;
      String uniqueCode = account['uniqueCode']!.text;
      int score = 0;
      int device = 2;
      bool isActive = false;

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await FirebaseFirestore.instance.collection('student').doc(nim).set({
          'isActive': isActive,
          'nim': nim,
          'nama': nama,
          'email': email,
          'password': password,
          'uniqueCode': uniqueCode,
          'score': score,
          'device': device,
        });
      } catch (e) {
        print("Error: $e");
      }
    }
    setState(() {
      _accounts.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final double cardWidth = screenWidth * 0.8;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            width: cardWidth,
            child: Row(
              children: [
                Container(
                  width: cardWidth * 0.275,
                  height: double.maxFinite,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.4,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 48,
                        child: Text(
                          'List Student',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Divider(
                        thickness: 2,
                        height: 10,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('student')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            var students = snapshot.data!.docs;
                            return ListView.builder(
                              itemCount: students.length,
                              itemBuilder: (context, index) {
                                var student = students[index].data()
                                    as Map<String, dynamic>;
                                return Container(
                                  width: 270,
                                  height: 96,
                                  padding: const EdgeInsets.all(28),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${index + 1}.',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Jarak(jarak: 20, isHoriz: true),
                                      Text(
                                        student['nim'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      const Jarak(jarak: 14, isHoriz: true),
                                      SizedBox(
                                        height: 36,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              student['uniqueCode'],
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Clipboard.setData(
                                                  ClipboardData(
                                                    text: student['uniqueCode'],
                                                  ),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'Copied: ${student['uniqueCode']}'),
                                                    duration: const Duration(
                                                        seconds: 2),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.copy,
                                                size: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  width: cardWidth * 0.700,
                  height: double.maxFinite,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.4,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 48,
                        child: Row(
                          children: [
                            const Text(
                              'Tambah Akun',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 44,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: TextField(
                                      controller: _tambahakunController,
                                      cursorColor: Datawarna.secondaryColor,
                                      decoration: InputDecoration(
                                        hintText: 'Tambah',
                                        hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          borderSide: BorderSide(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            width: 1.5,
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                            color: Datawarna.tertiaryColor,
                                            width: 1.75,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: _generateAkun,
                                          focusNode: tambah,
                                          icon: const Icon(Icons.add),
                                        ),
                                      ),
                                      onSubmitted: (value) {
                                        FocusScope.of(context)
                                            .requestFocus(tambah);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Jarak(jarak: 12, isHoriz: false),
                      const Divider(
                        thickness: 2,
                        height: 10,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _accounts.length,
                          itemBuilder: (context, index) {
                            final account = _accounts[index];
                            return Card(
                              elevation: 0,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _accounts[index]['nim'],
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                        maxLength: 8,
                                        decoration: const InputDecoration(
                                          labelText: 'NIM',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: _accounts[index]['nama'],
                                        decoration: const InputDecoration(
                                          labelText: 'Nama',
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Expanded(
                                      child: TextField(
                                        controller: _accounts[index]
                                            ['password'],
                                        decoration: const InputDecoration(
                                          labelText: 'Password',
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Expanded(
                                      child: TextField(
                                        controller: _accounts[index]
                                            ['uniqueCode'],
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          labelText: 'Unique Code',
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              Clipboard.setData(
                                                ClipboardData(
                                                    text: _accounts[index]
                                                            ['uniqueCode']!
                                                        .text),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Copied: ${_accounts[index]['uniqueCode']!.text}'),
                                                  duration: const Duration(
                                                    seconds: 2,
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.copy),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      InkWell(
                        onTap: _saveToFirebase,
                        child: Container(
                          width: double.infinity,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Datawarna.secondaryColor,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Generate',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
