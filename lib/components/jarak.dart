import 'package:flutter/material.dart';

class Jarak extends StatelessWidget {
  final double jarak;
  final bool isHoriz;
  const Jarak({super.key, required this.jarak, required this.isHoriz});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isHoriz ? jarak : 0,
      height: isHoriz ? 0 : jarak,
    );
  }
}
