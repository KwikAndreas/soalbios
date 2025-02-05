import 'package:flutter/material.dart';

class LogoBios extends StatelessWidget {
  final double size;
  const LogoBios({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Image.asset(
        'assets/bios/bios.png',
      ),
    );
  }
}
