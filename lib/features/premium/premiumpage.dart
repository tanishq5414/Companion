import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:companion_rebuild/features/components/custom_appbar.dart';
import 'package:companion_rebuild/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class PremiumPage extends ConsumerStatefulWidget {
  const PremiumPage({super.key});

  @override
  ConsumerState<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends ConsumerState<PremiumPage> {


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Premium'),
          leading: Container(
              padding: EdgeInsets.all(size.width * 0.03),
              child: Image.asset('assets/logo/logo.png')),
        ),
        body: Column(
          children: [
            SizedBox(height: size.width * 0.1),
            const Text('Plan Details',
                style: TextStyle(
                    color: appWhiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: size.width * 0.1),
            Container(
              width: size.width / 1.2,
              height: size.height / 6,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                gradient: LinearGradient(
                  colors: [
                    appAccentColor,
                    Color(0xFF00B4DB),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    Row(children: [
                      SizedBox(width: size.width * 0.05),
                      const Text(
                        'Monthly',
                        style: TextStyle(
                          color: appWhiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        '\u{20B9} 30',
                        style: TextStyle(
                          color: appWhiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(width: size.width * 0.05),
                    ]),
                    SizedBox(
                      height: size.width * 0.08,
                    ),
                    Center(
                      child: Container(
                        width: size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'no ads • recently accessed • faster updates',
                              style: TextStyle(
                                color: appWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.width * 0.1),
            Center(
              child: ZoomTapAnimation(
                child: SizedBox(
                  width: size.width * 0.9,
                  height: size.width * 0.13,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: appWhiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000),
                      ),
                    ),
                    onPressed: () {
                    },
                    child: const AutoSizeText(
                      'Get Premium',
                      style: TextStyle(
                        color: appBlackColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
