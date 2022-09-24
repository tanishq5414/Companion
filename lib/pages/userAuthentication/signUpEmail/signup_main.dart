import 'package:flutter/material.dart';
import 'package:notesapp/config/colors.dart';
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
      buttonColor = appGreyColor;
    } else {
      buttonColor = Colors.black;
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
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: const Text('Create Account',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                )),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
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
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Enter your Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      SizedBox(
                        height: size.height * 0.06,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: appGreyColor),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 8, bottom: 16),
                            child: TextField(
                              style: const TextStyle(fontSize: 20),
                              cursorColor: Colors.black,
                              cursorHeight: size.height * 0.03,
                              controller: fullNameController,
                              decoration: const InputDecoration(
                                fillColor: appGreyColor,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
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
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ),
                      const Divider(
                        color: appGreyColor,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'By tapping on “Create account”, you agree to the myCompanion Terms of Use.',
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
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
