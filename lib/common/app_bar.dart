// ignore_for_file: prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final title;
  final List<Widget>? actions;
  final automaticallyImplyLeading;
  final Icon? leading;
  CustomAppBar(
      {Key? key,
      required this.title,
      this.actions,
      this.automaticallyImplyLeading,
      this.leading,
      })
      : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Pallete.greyColor,
      elevation: 0,
      leading: ZoomTapAnimation(
        child: IconButton(
            icon: const Icon(
              OctIcons.arrow_left_16,
              color: Pallete.whiteColor,
              size: 21,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Pallete.whiteColor,
          fontWeight: FontWeight.w900,
          fontSize: 18,
        ),
      ),
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      actions: actions,
      centerTitle: true,
    );
  }
}
