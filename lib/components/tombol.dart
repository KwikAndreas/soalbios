import 'package:flutter/material.dart';
import 'package:soalbios2/widget/datawarna.dart';

class TombolLogin extends StatelessWidget {
  final double width;
  final VoidCallback onPressed;
  final FocusNode node;
  const TombolLogin({
    super.key,
    required this.onPressed,
    required this.width,
    required this.node,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 52,
      decoration: BoxDecoration(
        color: Datawarna.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: onPressed,
        focusNode: node,
        child: const Text(
          'Login',
          style: TextStyle(
            color: Datawarna.putih,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}

class TombolAktivasi extends StatelessWidget {
  final double width;
  final VoidCallback onPressed;
  final FocusNode node;
  const TombolAktivasi({
    super.key,
    required this.width,
    required this.onPressed,
    required this.node,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 52,
      decoration: BoxDecoration(
        color: Datawarna.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: const Text(
          'Aktivasi',
          style: TextStyle(
            color: Datawarna.putih,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
