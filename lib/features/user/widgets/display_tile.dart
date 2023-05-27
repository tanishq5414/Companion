// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';


// ignore: must_be_immutable
class DisplayTile extends StatelessWidget {
  var subtitle;
  var title;
  var onpressed;
  
  var trailing;

  DisplayTile({Key? key, required this.title, required this.subtitle, this.onpressed,this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      child: Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        color: Colors.transparent,
        child: ListTile(
          trailing: trailing,
          minVerticalPadding: 0,
          contentPadding: EdgeInsets.zero,
          onTap: onpressed ??
              () {},
          title: Text(title,
              style: const TextStyle(
                color: Pallete.whiteColor,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              )),
          subtitle: Container(
            child: Text(subtitle,
                style: const TextStyle(color: Pallete.whiteColor, fontSize: 12)),
          ),
        ),
      ),
    );
  }
}
