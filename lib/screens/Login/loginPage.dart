// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ButtonStyle loginButtonStyle = ElevatedButton.styleFrom(
      primary: Colors.black,
      minimumSize: Size(400, size.height * 0.08),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      elevation: 25,
    );
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(
            top: size.height * 0.1,
            left: size.width * 0.08,
            right: size.width * 0.08),
        height: size.height * 0.9,
        width: size.width,
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (!isKeyboard)
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.007),
                    child: SizedBox(
                      // height: size.height * 0.08,
                      child: Row(
                        children: const [
                          Text('Welcome Back!',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                if (!isKeyboard)
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.007, bottom: size.height * 0.007),
                    child: SizedBox(
                      height: size.height * 0.019,
                      child: Row(
                        children: const [
                          Text('Glad to see you again',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 182, 180, 180),
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                SizedBox(
                  height: size.height * 0.08,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Enter your email',
                      labelStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.009,
                ),
                SizedBox(
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    obscuringCharacter: '●',
                    decoration: InputDecoration(
                      labelText: 'Enter your password',
                      labelStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.009,
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text('Forgot Password?',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.09,
                ),
                SizedBox(
                  height: size.height * 0.08,
                  child: ElevatedButton(
                    style: loginButtonStyle,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: signIn,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: size.height * 0.05, bottom: size.height * 0.03),
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        VerticalDivider(
                          color: Colors.black,
                          thickness: 10,
                        ),
                        Text('Or Login with',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            )),
                        VerticalDivider(
                          color: Colors.black,
                          thickness: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.08,
                        width: size.height * 0.08,
                        child: TextButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            side: const BorderSide(
                              color: Color.fromARGB(255, 215, 212, 212),
                              width: 2,
                            ),
                          ),
                          child: const Icon(Icons.apple_rounded,
                              color: Colors.black),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        child: SizedBox(
                          height: size.height * 0.08,
                          width: size.height * 0.08,
                          child: TextButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.grey,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 215, 212, 212),
                                width: 2,
                              ),
                            ),
                            child: const Icon(Icons.facebook_rounded,
                                color: Colors.blue),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.08,
                        width: size.height * 0.08,
                        child: TextButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            side: const BorderSide(
                              color: Color.fromARGB(255, 215, 212, 212),
                              width: 2,
                            ),
                          ),
                          child:
                              Image.asset('lib/assets/pictures/google_ic.png'),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                SizedBox(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ignore: prefer_const_constructors
                    Text('Dont have an account?',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(' Sign Up',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          )),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
  }
}
