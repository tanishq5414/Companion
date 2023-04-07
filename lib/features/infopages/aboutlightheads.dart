import 'package:flutter/material.dart';

import '../components/custom_appbar.dart';

class AboutLightHeads extends StatelessWidget {
  const AboutLightHeads({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: CustomAppBar(title: 'About LightHeads'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image(image: AssetImage('assets/logo/lightheads.png')),
              Text('LightHeads'),
              Text('lightheads.org'),
              SizedBox(height: size.height * 0.05),
              Text('Join us'),
              Text('contact@lightheads.org'),
            ],
          ),
        ));
  }
}
