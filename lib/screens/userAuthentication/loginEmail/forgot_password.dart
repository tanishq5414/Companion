import 'package:flutter/material.dart';
import 'package:notesapp/assets/colors/colors.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../domain/firebase_auth_methods.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  var buttonColor = appGreyColor;
  var buttonTextColor = appOtherGreyColor;
  var inputTextColor = appGreyColor;
  @override
  Widget build(BuildContext context) {
    void forgotPassword({
    required String email,
  }){
    context.read<FirebaseAuthMethods>().resetPassword(email: email);
  }
    var size = MediaQuery.of(context).size;
    if (emailController.text.isEmpty) {
      buttonColor = appGreyColor;
      buttonTextColor = appOtherGreyColor;
    } else {
      buttonColor = Colors.black;
      buttonTextColor = Colors.white;
    }
    final ButtonStyle loginButtonStyle = ElevatedButton.styleFrom(
      primary: buttonColor,
      minimumSize: Size(size.width / 5.2, size.height / 22),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      elevation: 0,
    );
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Forgot Password',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              )),
          elevation: 0,
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.025, right: size.width * 0.025),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Enter your email',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  height: size.height * 0.06,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: inputTextColor),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 8, bottom: 16),
                      child: TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s"))
                        ],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                        cursorColor: Colors.black,
                        cursorHeight: size.height * 0.03,
                        controller: emailController,
                        decoration: InputDecoration(
                          fillColor: inputTextColor,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'The Password Reset Link will be sent to your email',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                ElevatedButton(
                  style: loginButtonStyle,
                  onPressed: () {
                    forgotPassword(email: emailController.text);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: buttonTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
