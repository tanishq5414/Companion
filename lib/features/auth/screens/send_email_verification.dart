import 'package:companion_rebuild/features/auth/controller/auth_controller.dart';
import 'package:companion_rebuild/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:routemaster/routemaster.dart';

//create an error 404 not found page
class SendEmailVerification extends ConsumerWidget {
  const SendEmailVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: appBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: appBackgroundColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Email Verification Sent',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: appWhiteColor)),
                const Text('Please verify your email address',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: appWhiteColor)),
                SizedBox(
                  height: size.height * 0.3,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: appWhiteColor,
                    shape: BoxShape.rectangle,
                  ),
                  child: SizedBox(
                    width: size.width * 0.8,
                    child: TextButton(
                        onPressed: () {
                          Routemaster.of(context).popUntil((routeData) => false);
                          Routemaster.of(context).push('/');
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: appBackgroundColor),
                        )),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                TextButton(
                    onPressed: () {
                      ref
                          .read(authControllerProvider.notifier)
                          .sendEmailVerification(context);
                    },
                    child: const Text(
                      'Didnot recieve mail? Click to Resend',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: appWhiteColor),
                    )),
                SizedBox(
                  height: size.height * 0.1,
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
