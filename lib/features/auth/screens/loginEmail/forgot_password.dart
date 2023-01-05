// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/features/auth/controller/auth_controller.dart';
import 'package:notesapp/theme/colors.dart';
// import 'package:flutter/services.dart';
import 'package:notesapp/features/components/custom_appbar.dart';
import 'package:routemaster/routemaster.dart';

import '../../components/custom_subtitle.dart';
import '../../components/custom_title.dart';
import '../../components/text_field.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final emailController = TextEditingController();
  var buttonColor = appGreyColor;
  var buttonTextColor = appOtherGreyColor;
  var inputTextColor = appGreyColor;
  @override
  Widget build(BuildContext context) {
    void forgotPassword({
      required String email,
    }) {
      ref.read(authControllerProvider.notifier).resetPassword(context, email);
    }

    var size = MediaQuery.of(context).size;
    if (emailController.text.isEmpty) {
      buttonColor = appBackgroundColor;
      buttonTextColor = appWhiteColor;
    } else {
      buttonColor = appWhiteColor;
      buttonTextColor = appBlackColor;
    }
    final ButtonStyle resetButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: buttonColor,
      minimumSize: Size(size.width / 5.2, size.height / 22),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      elevation: 0,
    );
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Forgot password',
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
                CustomHeading(title: 'Enter your email'),
                SizedBox(
                  height: size.height * 0.01,
                ),
                CustomTextField(
                  size: size,
                  // inputTextColor: inputTextColor,
                  inputController: emailController,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                CustomSubtitle(
                  text: 'We will send you a link to reset your password',
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                ElevatedButton(
                  style: resetButtonStyle,
                  onPressed: () {
                    forgotPassword(email: emailController.text);
                    Routemaster.of(context).push('/');
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
