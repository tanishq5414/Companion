import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class SideHeading extends StatelessWidget {
  var title;

  SideHeading({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: size.width * 0.03,top: size.width * 0.03),
        child: Text(title,
            style: const TextStyle(
              color: appWhiteColor,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            )),
      ),
    );
  }
}
