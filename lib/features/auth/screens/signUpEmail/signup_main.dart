import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/features/auth/controller/auth_controller.dart';
import 'package:notesapp/theme/colors.dart';
import 'package:notesapp/features/components/custom_appbar.dart';
import 'package:notesapp/features/auth/components/custom_title.dart';
import 'package:notesapp/features/auth/components/text_field.dart';
import 'package:notesapp/features/auth/repository/firebase_auth_methods.dart';

class SignupPage extends ConsumerStatefulWidget {
  final String email;
  final String password;
  const SignupPage({super.key, required this.email, required this.password});

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

  void signUp() {
    ref
        .read(authControllerProvider.notifier)
        .signUpwithEmail(context, widget.email, widget.password, fullNameController);
  }

  @override
  Widget build(BuildContext context) {
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
                      CustomHeading(title: 'Enter your Name'),
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
                        onPressed: signUp,
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
