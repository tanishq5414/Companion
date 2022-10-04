import 'package:flutter/material.dart';
import 'package:notesapp/config/colors.dart';
import 'package:notesapp/pages/components/custom_appbar.dart';
import 'package:notesapp/pages/userAuthentication/components/custom_title.dart';
import 'package:notesapp/pages/userAuthentication/components/text_field.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  // ignore: prefer_typing_uninitialized_variables
  var email;
  final passwordController = TextEditingController();
  var buttonColor = appGreyColor;
  var buttonTextColor = appOtherGreyColor;
  var inputTextColor = appGreyColor;
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    var email = arguments['email'];
    var size = MediaQuery.of(context).size;

    if (passwordController.text.isEmpty) {
      buttonColor = appGreyColor;
      buttonTextColor = appOtherGreyColor;
    } else {
      buttonColor = Colors.black;
      buttonTextColor = Colors.white;
    }
    final ButtonStyle loginButtonStyle = ElevatedButton.styleFrom(
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
            appBar: CustomAppBar(
              title: 'Signup',
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
                    CustomHeading(
                      title: 'Create a password',
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SizedBox(
                      height: size.height * 0.06,
                      child: CustomTextField(inputController: passwordController,size: size,),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    ElevatedButton(
                      style: loginButtonStyle,
                      onPressed: () {
                        if (passwordController.text.isNotEmpty) {
                          Navigator.pushNamed(context, '/signup',
                              arguments: {'email': email, 'password': passwordController.text});
                        }
                      },
                      child: Text(
                        'Next',
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
