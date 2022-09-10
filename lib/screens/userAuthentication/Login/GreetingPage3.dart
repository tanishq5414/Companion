import 'package:flutter/material.dart';

class GreetingPage3 extends StatelessWidget {
  const GreetingPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ButtonStyle skipButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black,
      primary: Colors.white,
      minimumSize: const Size(120, 50),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      side: const BorderSide(
        color: Colors.black,
        width: 2,
      ),
    );
    final ButtonStyle nextButtonStyle = ElevatedButton.styleFrom(
      primary: Colors.black,
      minimumSize: const Size(170, 60),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      elevation: 25,
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: FittedBox(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      height: size.height * 0.75,
                      width: size.width,
                      padding:
                         EdgeInsets.only(top: 0, left: 12, right: 0),
                      child: FittedBox(
                        child: Image.asset(
                          'lib/assets/pictures/gpphoto3.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.50,
                      height: size.height * 0.68,
                      padding:
                          const EdgeInsets.only(top: 400, left: 40, right: 0),
                      child: FittedBox(
                        child: Image.asset(
                          'lib/assets/pictures/onboard3text.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
            alignment: Alignment.bottomCenter,
            width: size.width,
            height: size.height * 0.06,
            margin: EdgeInsets.only(bottom: size.width * 0.05),
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: skipButtonStyle,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  ElevatedButton(
                    style: nextButtonStyle,
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                  ),
                ],
              ),
            ),
          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
