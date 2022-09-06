import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
            right: size.width * 0.08,
            bottom: size.height * 0.06),
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
                          Text('Sign Up!',
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
                          Text('Fill in your details to get started',
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
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/tandc');
                        },
                        child: const Text('  View Terms and Conditions',
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 146, 144, 144),
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                SizedBox(
                  height: size.height * 0.08,
                  child: ElevatedButton(
                    style: loginButtonStyle,
                    child: const Text(
                      'Agree and Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '');
                    },
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
                          child: Image.asset('assets/pictures/google_ic.png'),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ignore: prefer_const_constructors
                          Text('Already Have an Account?',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              )),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: const Text(' Log In',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                )),
                          ),
                        ],
                      )
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
