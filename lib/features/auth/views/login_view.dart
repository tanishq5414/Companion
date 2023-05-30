import 'package:companion/constants/constants.dart';
import 'package:companion/features/auth/controller/auth_controller.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

// File Info:
// This displays the user main login screen gives user the sign in methods (Google, Facebook, Phone, Email)
//Provider is used
//The code logic is written in 'lib/domain/firebase_auth_methods'(subject to change)


class LoginView extends ConsumerWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginView());
  }
  const LoginView({super.key});
  void signInWithGoogle(BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    //Google, Facebook, Phone Login Style
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.transparent,
      alignment: Alignment.centerLeft,
      backgroundColor: Pallete.whiteColor,
      minimumSize: Size(size.width / 1.29, size.height / 16),
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
          SafeArea(
            child: Scaffold(
              backgroundColor: Pallete.blackColor,
              body: Center(
                child: SizedBox(
                  height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: size.width / 4,
                          child: Image.asset(
                              'assets/pictures/myCompanion_icon_round.png')),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      const Text('Get all your notes.',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const Text('Free on Companion.',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      const Text('A LightHeads Product',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      ZoomTapAnimation(
                        
                        onTap: () => signInWithGoogle(context, ref),
                        child: Container(
                          height: size.height / 16,
                          width: size.width *0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.transparent,
                            border: Border.all(
                              color: Pallete.whiteColor,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/pictures/google_ic.png',
                                width: 20,
                                height: 20,
                              ),
                              const Text(
                                'Login with Google',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Pallete.whiteColor,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
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
