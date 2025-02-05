import 'package:flutter/material.dart';
import 'package:soalbios2/components/formSoal.dart';
import 'package:soalbios2/components/jarak.dart';

class DisplayHome extends StatefulWidget {
  const DisplayHome({super.key});

  @override
  State<DisplayHome> createState() => _DisplayHomeState();
}

class _DisplayHomeState extends State<DisplayHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

class DisplayForm extends StatefulWidget {
  const DisplayForm({super.key});

  @override
  State<DisplayForm> createState() => _DisplayFormState();
}

class _DisplayFormState extends State<DisplayForm> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double width = screenWidth * 0.7;
    final double height = screenHeight * 0.5;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(18),
          width: screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FormSoal(
                width: width,
                height: height,
                node: FocusNode(),
                nomorSoal: 1,
              ),
              Jarak(),
              FormSoal(
                width: width,
                height: height,
                node: FocusNode(),
                nomorSoal: 1,
              ),
              Jarak(),
              FormSoal(
                width: width,
                height: height,
                node: FocusNode(),
                nomorSoal: 1,
              ),
              Jarak(),
              FormSoal(
                width: width,
                height: height,
                node: FocusNode(),
                nomorSoal: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
