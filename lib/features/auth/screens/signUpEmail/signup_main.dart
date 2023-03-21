// ignore_for_file: unused_import

import 'package:companion_rebuild/features/auth/components/custom_title.dart';
import 'package:companion_rebuild/features/auth/components/text_field.dart';
import 'package:companion_rebuild/features/auth/controller/auth_controller.dart';
import 'package:companion_rebuild/features/components/custom_appbar.dart';
import 'package:companion_rebuild/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  @override
  void dispose() {
    userNameController.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void signUp(email, password, fullname) {
    ref
        .read(authControllerProvider.notifier)
        .signUpwithEmail(context, email, password, fullname);
  }

  @override
  Widget build(BuildContext context) {
    var params = RouteData.of(context).queryParameters;

    var size = MediaQuery.of(context).size;
    Color buttonColor;
    Color buttonTextColor;
    if (fullNameController.text.isEmpty) {
      buttonColor = appBlackColor;
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
          appBar: CustomAppBar(title: 'Create account'),
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.025, right: size.width * 0.025),
            child: SizedBox(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      const CustomHeading(title: 'Enter your Name'),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      SizedBox(
                        height: size.height * 0.06,
                        child: CustomTextField(
                          inputController: fullNameController,
                          size: size,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('This appears on your profile',
                            style: TextStyle(
                                fontSize: 10,
                                color: appWhiteColor,
                                fontWeight: FontWeight.w500)),
                      ),
                      const Divider(
                        color: appWhiteColor,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'By tapping on “Create account”, you agree to the myCompanion Terms of Use.',
                            style: TextStyle(
                                fontSize: 10,
                                color: appWhiteColor,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      ElevatedButton(
                        style: loginButtonStyle,
                        onPressed: () {
                          signUp(params['email'], params['password'],
                              fullNameController.text);
                        },
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            color: buttonTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
