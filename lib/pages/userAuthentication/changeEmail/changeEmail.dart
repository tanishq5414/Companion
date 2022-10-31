// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:notesapp/config/colors.dart';
import 'package:notesapp/pages/components/custom_appbar.dart';
import 'package:notesapp/pages/userAuthentication/components/custom_title.dart';
import 'package:notesapp/pages/userAuthentication/components/text_field.dart';
import 'package:provider/provider.dart';

import '../../../provider/firebase_auth_methods.dart';

// FILE INFO:
// This file displays the login page for email and signup
// provider used
//The code logic is written in 'lib/domain/firebase_auth_methods'(subject to change)
class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({Key? key}) : super(key: key);

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
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
    // chnage email function
    void changeEmailUser() {
      context
          .read<FirebaseAuthMethods>()
          .updateEmail(context, emailController.toString(), passwordController.toString());
    }

    //UI Starts
    return Container(
      color: appBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: appBackgroundColor,
          appBar: CustomAppBar(
            title: 'Change email',
          ),
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.025, right: size.width * 0.025),
            child: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    const CustomHeading(title: 'Enter new email'),
                    SizedBox(
                        height: size.height * 0.06,
                        child: CustomTextField(
                          inputController: emailController,
                          size: size,
                        )),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    CustomHeading(title: 'Password'),
                    SizedBox(
                        height: size.height * 0.07,
                        child: CustomTextField(
                          inputController: passwordController,
                          size: size,
                        )),
                    SizedBox(
                      height: size.height * 0.009,
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    ElevatedButton(
                      style: loginButtonStyle,
                      onPressed: changeEmailUser,
                      child: Text(
                        'Change Email',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: buttonTextColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
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
