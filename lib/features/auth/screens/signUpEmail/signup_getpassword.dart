import 'package:flutter/material.dart';
import 'package:notesapp/features/auth/screens/signUpEmail/signup_getemail.dart';
import 'package:notesapp/theme/colors.dart';
import 'package:notesapp/features/components/custom_appbar.dart';
import 'package:notesapp/features/auth/components/custom_title.dart';
import 'package:notesapp/features/auth/components/text_field.dart';
import 'package:routemaster/routemaster.dart';

class PasswordPage extends StatelessWidget {
  late String email;
  PasswordPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final passwordController = TextEditingController();

  var buttonColor = appGreyColor;

  var buttonTextColor = appOtherGreyColor;

  var inputTextColor = appGreyColor;

  // var email = '';
  @override
  Widget build(BuildContext context) {
    // final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    var size = MediaQuery.of(context).size;
    if (passwordController.text.isEmpty) {
      buttonColor = appBackgroundColor;
      buttonTextColor = appWhiteColor;
    } else {
      buttonColor = appWhiteColor;
      buttonTextColor = appBlackColor;
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
                    const CustomHeading(
                      title: 'Create a password',
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SizedBox(
                      height: size.height * 0.06,
                      child: CustomTextField(
                        inputController: passwordController,
                        size: size,
                        obscureText: true,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    ElevatedButton(
                      style: loginButtonStyle,
                      onPressed: () {
                        if (passwordController.text.isNotEmpty) {
                          print(email);
                          Routemaster.of(context)
                              .push('/signup', queryParameters: {
                            'email': email,
                            'password': passwordController.text,
                          });

                          // Navigator.pushNamed(context, '/signup', arguments: {
                          //   'email': email,
                          //   'password': passwordController.text
                          // });
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
