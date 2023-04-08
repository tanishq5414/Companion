// ignore_for_file: must_be_immutable, unnecessary_import

import 'package:companion_rebuild/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var obscureText;
  var hint;
  var inputformatters;
  CustomTextField({
    Key? key,
    required this.size,
    required this.inputController,
    this.inputformatters,
    this.hint,
    this.obscureText = false,
  }) : super(key: key);

  final Size size;
  final Color inputTextColor = appGreyColor;
  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.06,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3), color: inputTextColor),
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.03),
          child: Center(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
              cursorColor: Colors.black,
              cursorHeight: size.height * 0.03,
              controller: inputController,
              inputFormatters: inputformatters,
              obscureText: obscureText,
              decoration: InputDecoration(
                hintText: hint,
                fillColor: inputTextColor,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
