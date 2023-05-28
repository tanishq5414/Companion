import 'package:companion/common/common.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';

class AboutLightHeads extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => AboutLightHeads());
  }

  const AboutLightHeads({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Pallete.backgroundColor,
      child: SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(title: 'About LightHeads'),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image(image: AssetImage('assets/logo/lightheads.png')),
                  Text(
                    'LightHeads',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Pallete.whiteColor,
                    ),
                  ),
                  Text(
                    'lightheads.org',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Pallete.whiteColor,
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Text(
                    'Join us',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Pallete.whiteColor,
                    ),
                  ),
                  Text(
                    'contact@lightheads.org',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Pallete.whiteColor,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
