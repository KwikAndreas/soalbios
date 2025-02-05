import 'package:flutter/material.dart';

class FormSoal extends StatelessWidget {
  final double width;
  final double height;
  final FocusNode node;

  final int nomorSoal;

  const FormSoal({
    super.key,
    required this.width,
    required this.height,
    required this.node,
    required this.nomorSoal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 4,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '$nomorSoal',
                  style: const TextStyle(),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Text(
                  'tekssoal',
                  style: TextStyle(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class FormSoalPilihan extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final FocusNode node;
  const FormSoalPilihan(
      {super.key,
      required this.width,
      required this.height,
      required this.controller,
      required this.node});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
