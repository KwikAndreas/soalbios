import 'package:flutter/material.dart';
import 'package:soalbios2/components/input.dart';
import 'package:soalbios2/page/user/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login() {
    try {} catch (e) {
      print(e);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeSoalBIOS()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final inputWidth = screenWidth / 2;
    final inputHeight = screenWidth / 4;

    final FocusNode uidFocus = FocusNode();
    final FocusNode passFocus = FocusNode();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: screenWidth / 2,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  InputUID(
                    controller: _usernameController,
                    node: uidFocus,
                    width: inputWidth,
                    height: inputHeight,
                  ),
                  InputPass(
                    controller: _passwordController,
                    node: passFocus,
                    width: inputWidth,
                    height: inputHeight,
                  ),
                  Container(
                    width: inputWidth,
                    height: inputHeight / 2,
                    child: TextButton(
                      onPressed: login,
                      child: Text(
                        'Login',
                        style: TextStyle(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
