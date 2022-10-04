import 'package:flutter/material.dart';
import 'package:notesapp/pages/components/custom_appbar.dart';
import 'package:notesapp/pages/userAuthentication/components/custom_subtitle.dart';
import 'package:notesapp/pages/userAuthentication/components/custom_title.dart';
import 'package:notesapp/pages/userAuthentication/components/text_field.dart';

import 'package:notesapp/provider/firebase_auth_methods.dart';
import 'package:provider/provider.dart';

import '../../../config/colors.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var buttonColor = appGreyColor;
    var buttonTextColor = appOtherGreyColor;
    void phoneSignIn() {
      context
          .read<FirebaseAuthMethods>()
          .phoneSignIn(context, phoneController.text);
    }

    if (phoneController.text.isEmpty) {
      buttonColor = appBackgroundColor;
      buttonTextColor = appOtherGreyColor;
    } else {
      buttonColor = appWhiteColor;
      buttonTextColor = appBlackColor;
    }
    final ButtonStyle customButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: buttonColor,
      minimumSize: Size(size.width / 5.2, size.height / 22),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      elevation: 0,
    );
    return Container(
      color: appBackgroundColor,
      child: SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(title: '',),
            body: Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.025,
                right: size.width * 0.025,
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.07,
                    ),
                    CustomHeading(title: 'Enter your phone number'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomSubtitle(
                        text: 'Enter with your country code (Eg. +917XXXXXXX39)'),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SizedBox(
                      height: size.height * 0.06,
                      child: CustomTextField(
                        inputController: phoneController,
                        size: size,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    ElevatedButton(
                      style: customButtonStyle,
                      onPressed: phoneSignIn,
                      child: Text(
                        'Send OTP',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: buttonTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
