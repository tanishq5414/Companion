import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notesapp/config/colors.dart';

class CustomTextField extends StatelessWidget {
  var obscureText;

  CustomTextField({
    Key? key,
    required this.size,
    required this.inputController,
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
            child: TextField(
              textAlignVertical: TextAlignVertical.bottom,
              // inputFormatters: [
              //   FilteringTextInputFormatter.deny(RegExp(r"\s"))
              // ],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              cursorColor: Colors.black,
              cursorHeight: size.height * 0.03,
              controller: inputController,
              obscureText: obscureText,
              decoration: InputDecoration(
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
