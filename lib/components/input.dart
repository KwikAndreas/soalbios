import 'package:flutter/material.dart';
import 'package:soalbios2/widget/datawarna.dart';

class InputUID extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final FocusNode node;
  final FocusNode targetNode;
  const InputUID(
      {super.key,
      required this.controller,
      required this.node,
      required this.width,
      required this.height,
      required this.targetNode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: TextFormField(
        focusNode: node,
        controller: controller,
        keyboardType: TextInputType.number,
        cursorColor: Datawarna.secondaryColor,
        maxLength: 8,
        decoration: InputDecoration(
          hintText: "Masukkan NIM",
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
          FocusScope.of(context).requestFocus(targetNode);
        },
      ),
    );
  }
}

class InputPass extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final FocusNode node;
  final FocusNode targetNode;
  VoidCallback onTap;
  final bool isTextHidden;
  InputPass({
    super.key,
    required this.controller,
    required this.node,
    required this.width,
    required this.height,
    required this.onTap,
    required this.targetNode,
    required this.isTextHidden,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: TextFormField(
        focusNode: node,
        controller: controller,
        obscureText: isTextHidden,
        cursorColor: Datawarna.secondaryColor,
        decoration: InputDecoration(
          hintText: "Masukkan Password",
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
          prefixIcon: IconButton(
            onPressed: onTap,
            icon: const Icon(
              Icons.lock,
              size: 28,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: onTap,
            icon: Icon(
              isTextHidden ? Icons.visibility : Icons.visibility_off,
              color: Datawarna.abu,
              size: 28,
            ),
          ),
        ),
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(targetNode);
        },
      ),
    );
  }
}
