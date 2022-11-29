// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class ProfileAvatar extends StatelessWidget {
  late String image;
  late String firstlettername;
  late int rad;

  ProfileAvatar(
      {super.key,
      required this.image,
      required this.firstlettername,
      required this.rad});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: rad.toDouble(),
      backgroundColor: appAccentColor,
      child: CircleAvatar(
        backgroundColor: appBackgroundColor,
        radius: rad.toDouble() - 2,
        foregroundImage: (image != "null") ? NetworkImage(image) : null,
        backgroundImage: NetworkImage(image),
        child: Text(firstlettername,
            style: const TextStyle(
              color: appAccentColor,
              fontSize: 30,
            )),
      ),
    );
  }
}
