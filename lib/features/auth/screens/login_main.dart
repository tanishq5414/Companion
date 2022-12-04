import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/features/auth/controller/auth_controller.dart';
import 'package:notesapp/theme/colors.dart';
import 'package:notesapp/features/auth/repository/firebase_auth_methods.dart';
// import 'package:provider/provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:routemaster/routemaster.dart';

// File Info:
// This displays the user main login screen gives user the sign in methods (Google, Facebook, Phone, Email)
//Provider is used
//The code logic is written in 'lib/domain/firebase_auth_methods'(subject to change)
class LoginMain extends ConsumerWidget {
  const LoginMain({super.key});
  void signInWithGoogle(BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

  void signInWithFacebook(WidgetRef ref) {
    ref.read(authControllerProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            "assets/pictures/background2.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          SafeArea(
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
                              'assets/pictures/myCompanion_icon_round.png')),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      const Text('Get all your notes',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const Text('Free on Companion',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      SizedBox(
                        width: size.width / 1.29,
                        child: TextButton(
                            style: otherButtonStyle,
                            // icon: LineIcon.googlePlus(
                            //   color: appWhiteColor,
                            // ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Continue with ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: appWhiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Google',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            onPressed: () => signInWithGoogle(context,ref)),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SizedBox(
                        width: size.width / 1.29,
                        child: TextButton(
                            style: otherButtonStyle,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Continue with ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: appWhiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Facebook',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            onPressed: () => signInWithFacebook(ref)),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SizedBox(
                        width: size.width / 1.29,
                        child: TextButton(
                          style: otherButtonStyle,
                          // icon: const Icon(
                          //   Icons.phone_iphone_rounded,
                          //   color: appWhiteColor,
                          //   size: 20,
                          // ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Continue with ',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: appWhiteColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Phone',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Routemaster.of(context).push('/phonelogin');
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
        ],
      ),
    );
  }
}