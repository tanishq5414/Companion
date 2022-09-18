import 'package:flutter/material.dart';

import 'package:notesapp/domain/firebase_auth_methods.dart';
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
    var inputTextColor = appGreyColor;
    void phoneSignIn() {
      context
          .read<FirebaseAuthMethods>()
          .phoneSignIn(context, phoneController.text);
    }

    if (phoneController.text.isEmpty) {
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
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.025, right: size.width * 0.025),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.07,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Enter your phone number',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Enter with your country code (Eg. +917XXXXXXX39)',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
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
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(fontSize: 20),
                        cursorColor: Colors.black,
                        cursorHeight: size.height * 0.03,
                        controller: phoneController,
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
                ElevatedButton(
                  style: loginButtonStyle,
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
        ));
  }
}
