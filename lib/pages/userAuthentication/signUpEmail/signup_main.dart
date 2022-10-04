import 'package:flutter/material.dart';
import 'package:notesapp/config/colors.dart';
import 'package:notesapp/pages/components/custom_appbar.dart';
import 'package:notesapp/pages/userAuthentication/components/custom_title.dart';
import 'package:notesapp/pages/userAuthentication/components/text_field.dart';
import 'package:notesapp/provider/firebase_auth_methods.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  var email;
  // ignore: prefer_typing_uninitialized_variables
  var password;

  @override
  void dispose() {
    userNameController.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void signUP() {
    context.read<FirebaseAuthMethods>().signUpWithEmail(
        email: email,
        password: password,
        fullName: fullNameController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color buttonColor;
    if (fullNameController.text.isEmpty) {
      buttonColor = appBlackColor;
    } else {
      buttonColor = appGreyColor;
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
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    email = arguments['email'];
    password = arguments['password'];
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
                        child: CustomTextField(inputController: fullNameController,size: size,),
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
                        onPressed: signUP,
                        child: const Text(
                          'Create Account',
                          style: TextStyle(
                            color: Colors.white,
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
