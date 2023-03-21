// ignore_for_file: file_names, unused_local_variable
import 'package:companion_rebuild/features/auth/components/custom_title.dart';
import 'package:companion_rebuild/features/auth/components/text_field.dart';
import 'package:companion_rebuild/features/auth/controller/auth_controller.dart';
import 'package:companion_rebuild/features/components/custom_appbar.dart';
import 'package:companion_rebuild/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:routemaster/routemaster.dart';

// FILE INFO:
// This file displays the login page for email and signup
// provider used
//The code logic is written in 'lib/domain/firebase_auth_methods'(subject to change)
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  //Controllers for storing email and Password
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
      buttonColor = appBackgroundColor;
      buttonTextColor = appWhiteColor;
    } else {
      buttonColor = appGreyColor;
      buttonTextColor = appBlackColor;
    }
    // login button style
    final ButtonStyle loginButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: buttonColor,
      minimumSize: Size(size.width / 5.2, size.height / 22),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      elevation: 0,
    );
    // login Function
    void loginUser(String email, String password) {
      ref
          .read(authControllerProvider.notifier)
          .logInWithEmail(context, email, password, ref);
    }

    void forgotpassword() {
      Routemaster.of(context).push('/forgotpassword');
    }

    //UI Starts
    return Container(
      color: appBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: appBackgroundColor,
          appBar: CustomAppBar(
            title: 'Login',
          ),
          // resizeToAvoidBottomInset: false,
          body: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.025, right: size.width * 0.025),
            child: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CustomHeading(title: 'Email'),
                    SizedBox(
                        height: size.height * 0.06,
                        child: CustomTextField(
                          inputController: emailController,
                          size: size,
                        )),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    const CustomHeading(title: 'Password'),
                    SizedBox(
                        height: size.height * 0.07,
                        child: CustomTextField(
                          inputController: passwordController,
                          size: size,
                          obscureText: true,
                        )),
                    SizedBox(
                      height: size.height * 0.009,
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    ElevatedButton(
                      style: loginButtonStyle,
                      onPressed: () {
                        print(2);
                        loginUser(
                            emailController.text, passwordController.text);
                      },
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
                        onTap: forgotpassword,
                        child: const Text('Forgot Password?',
                            style: TextStyle(
                              fontSize: 10,
                              color: appWhiteColor,
                              fontWeight: FontWeight.bold,
                            )),
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
