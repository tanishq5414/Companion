// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:notesapp/config/colors.dart';
import 'package:provider/provider.dart';

import '../../../domain/firebase_auth_methods.dart';

// FILE INFO:
// This file displays the login page for email and signup
// provider used
//The code logic is written in 'lib/domain/firebase_auth_methods'(subject to change)
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Controllers for storing email and Password
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //login Button Color
    var buttonColor = appGreyColor;
    //login Button Text Color
    var buttonTextColor = appOtherGreyColor;
    // email password input Text Color
    var inputTextColor = appGreyColor;
    //logic to change login button color if email and password pages are filled
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      buttonColor = appGreyColor;
      buttonTextColor = appOtherGreyColor;
    } else {
      buttonColor = Colors.black;
      buttonTextColor = Colors.white;
    }
    // login button style
    final ButtonStyle loginButtonStyle = ElevatedButton.styleFrom(
      primary: buttonColor,
      minimumSize: Size(size.width / 5.2, size.height / 22),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      elevation: 0,
    );
    // login Function
    void loginUser() {
      context.read<FirebaseAuthMethods>().loginWithEmail(
            email: emailController.text,
            password: passwordController.text,
            context: context,
          );
    }

    //UI Starts
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: LineIcon.arrowLeft(
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: appWhiteColor,
          ),
          resizeToAvoidBottomInset: false,
          backgroundColor: appWhiteColor,
          body: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.025, right: size.width * 0.025),
            child: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        )),
                    SizedBox(
                      height: size.height * 0.06,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: inputTextColor),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 8, bottom: 16),
                          child: TextField(
                            style: const TextStyle(fontSize: 20),
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
                      height: size.height * 0.04,
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        )),
                    SizedBox(
                      height: size.height * 0.07,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: appGreyColor),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 8, bottom: 16),
                          child: TextField(
                            obscureText: true,
                            controller: passwordController,
                            cursorColor: Colors.black,
                            cursorHeight: size.height * 0.03,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                            decoration: const InputDecoration(
                              fillColor: appGreyColor,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.009,
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    ElevatedButton(
                      style: loginButtonStyle,
                      onPressed: loginUser,
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: buttonTextColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/forgotpassword');
                        },
                        child: Container(
                          child: const Text('Forgot Password?',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
