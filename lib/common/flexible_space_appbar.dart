import 'dart:math';

import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';

class MyAppSpace extends StatelessWidget {
  final Size size;
  final String title;

  const MyAppSpace({super.key, required this.size, required this.title, });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        final deltaExtent = settings!.maxExtent - settings.minExtent;
        final t =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0) as double;
        final fadeStart = max(0.0, 1.0 - kToolbarHeight / deltaExtent);
        const fadeEnd = 1.0;
        final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);

        return Stack(
          children: [
            Center(
              child: Opacity(
                  opacity: 1 - opacity,
                  child: Text(title,
                      style:
                          TextStyle(fontSize: 14, color: Pallete.whiteColor, fontWeight: FontWeight.w900))),
            ),
            Opacity(
              opacity: opacity,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // getImage(),
                  Positioned(
                    left: size.width * 0.05,
                    bottom: 0,
                    child: Container(
                      width: size.width * 0.7,
                      margin: EdgeInsets.only(bottom: size.height * 0.02),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 40,
                            color: Pallete.whiteColor,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
