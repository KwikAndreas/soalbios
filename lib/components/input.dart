import 'package:flutter/material.dart';

class InputUID extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final FocusNode node;
  const InputUID(
      {super.key,
      required this.controller,
      required this.node,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: TextFormField(
        focusNode: node,
        controller: controller,
      ),
    );
  }
}

class InputPass extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final FocusNode node;
  const InputPass(
      {super.key,
      required this.controller,
      required this.node,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: TextFormField(
        focusNode: node,
        controller: controller,
      ),
    );
  }
}
