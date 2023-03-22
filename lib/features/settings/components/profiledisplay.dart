// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class ProfileAvatar extends StatelessWidget {
  late String image;
  late String firstlettername;
  late int rad;
  late double? width;
  ProfileAvatar(
      {super.key,
      required this.image,
      required this.firstlettername,
      required this.rad,
      required this.width});

  @override
  Widget build(BuildContext context) {
    // print('image: $image');
    return SizedBox(
      width: width,
      child: CircleAvatar(
        radius: rad.toDouble(),
        backgroundColor: appAccentColor,
        child: CircleAvatar(
          backgroundColor: appBackgroundColor,
          radius: rad.toDouble() - 2,
          foregroundImage: (image != "null" || image!='') ? NetworkImage(image) : null,
          backgroundImage: (image!="null" || image!='')? NetworkImage(image): null,
          child: AutoSizeText(firstlettername[0],
              maxLines: 1,
              style: const TextStyle(
                color: appAccentColor,
                fontSize: 20,
              )),
        ),
      ),
    );
  }
}
