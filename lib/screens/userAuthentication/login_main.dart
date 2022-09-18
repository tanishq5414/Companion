import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:notesapp/assets/colors/colors.dart';
import 'package:notesapp/domain/firebase_auth_methods.dart';
import 'package:provider/provider.dart';


// File Info:
// This displays the user main login screen gives user the sign in methods (Google, Facebook, Phone, Email)
//Provider is used
//The code logic is written in 'lib/domain/firebase_auth_methods'(subject to change)
class LoginMain extends StatelessWidget {
  const LoginMain({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //SignUp Button Style
    final ButtonStyle signUpButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: appWhiteColor,
      foregroundColor: Colors.transparent,
      minimumSize: Size(size.width / 1.29, size.height / 18.89),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      elevation: 0,
    );
    //Google, Facebook, Phone Login Style
    final ButtonStyle otherButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.transparent,
      alignment: Alignment.centerLeft,
      backgroundColor: Colors.transparent,
      minimumSize: Size(size.width / 1.29, size.height / 18.89),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      side: const BorderSide(
        color: Colors.white,
        width: 2,
      ),
    );
    //Start of UI
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          Image.asset(
            "lib/assets/pictures/background.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Container(
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: SizedBox(
                    height: size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: size.width / 5,
                            child: Image.asset(
                                'lib/assets/pictures/myCompanion_icon_round.png')),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        const Text('Get all your notes',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        const Text('Free on myCompanion',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        SizedBox(
                          width: size.width / 1.29,
                          child: TextButton.icon(
                            style: otherButtonStyle,
                            icon: LineIcon.googlePlus(
                              color: appWhiteColor,
                            ),
                            label: const Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Continue with Google',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: appWhiteColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onPressed: () {
                              context
                                  .read<FirebaseAuthMethods>()
                                  .signInWithGoogle(context);
                            },
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        SizedBox(
                          width: size.width / 1.29,
                          child: TextButton.icon(
                            style: otherButtonStyle,
                            icon: const Icon(
                              Icons.facebook_rounded,
                              color: appWhiteColor,
                              size: 20,
                            ),
                            label: const Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Continue with Facebook',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: appWhiteColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onPressed: () {
                              context
                                  .read<FirebaseAuthMethods>()
                                  .signInWithFacebook(context);
                            },
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        SizedBox(
                          width: size.width / 1.29,
                          child: TextButton.icon(
                            style: otherButtonStyle,
                            icon: const Icon(
                              Icons.phone_iphone_rounded,
                              color: appWhiteColor,
                              size: 20,
                            ),
                            label: const Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Continue with Phone',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: appWhiteColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/phonelogin');
                            },
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        ElevatedButton(
                          style: signUpButtonStyle,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: size.width / 30,
                              ),
                              const Text(
                                'Sign up for free',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/emailpage');
                          },
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.transparent,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: const Text(
                              'Log in',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: size.height * 0.05,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
