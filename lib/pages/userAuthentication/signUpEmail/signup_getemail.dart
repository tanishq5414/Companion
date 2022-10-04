import 'package:flutter/material.dart';
import 'package:notesapp/config/colors.dart';
import 'package:flutter/services.dart';
import 'package:notesapp/pages/components/custom_appbar.dart';
import 'package:notesapp/pages/userAuthentication/components/custom_subtitle.dart';
import 'package:notesapp/pages/userAuthentication/components/custom_title.dart';
import 'package:notesapp/pages/userAuthentication/components/text_field.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final emailController = TextEditingController();
  var buttonColor = appGreyColor;
  var buttonTextColor = appOtherGreyColor;
  var inputTextColor = appGreyColor;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (emailController.text.isEmpty || emailController.text.contains('@') == false) {
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
                    CustomHeading(title: 'Enter your Email'),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SizedBox(
                      height: size.height * 0.06,
                      child: CustomTextField(
                        inputController: emailController,
                        size: size,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    CustomSubtitle(text: 'You will need to verify your email'),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    ElevatedButton(
                      style: loginButtonStyle,
                      onPressed: () {
                        if (emailController.text.isNotEmpty &&
                            emailController.text.contains('@')) {
                          Navigator.pushNamed(context, '/passwordpage',
                              arguments: {'email': emailController.text});
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
