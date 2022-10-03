// ignore_for_file: prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../config/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final title ;
  final List<Widget>? actions;
  CustomAppBar({Key? key,required this.title, this.actions}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBackgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          LineIcons.arrowLeft,
          color: appWhiteColor,
          size: 15,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: appWhiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
      actions: actions,
      centerTitle: true,
    );
  }
}
