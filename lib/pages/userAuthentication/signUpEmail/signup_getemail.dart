import 'package:flutter/material.dart';
import 'package:notesapp/config/colors.dart';
import 'package:flutter/services.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final emailController = TextEditingController();
  var buttonColor = appGreyColor;
  var buttonTextColor = appOtherGreyColor;
  var inputTextColor = appGreyColor;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (emailController.text.isEmpty) {
      buttonColor = appGreyColor;
      buttonTextColor = appOtherGreyColor;
    } else {
      buttonColor = Colors.black;
      buttonTextColor = Colors.white;
    }
    final ButtonStyle loginButtonStyle = ElevatedButton.styleFrom(
      primary: buttonColor,
      minimumSize: Size(size.width / 5.2, size.height / 22),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      elevation: 0,
    );
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.025, right: size.width * 0.025),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Enter your email',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  height: size.height * 0.06,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: inputTextColor),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 8, bottom: 16),
                      child: TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s"))
                        ],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                        cursorColor: Colors.black,
                        cursorHeight: size.height * 0.03,
                        controller: emailController,
                        decoration: InputDecoration(
                          fillColor: inputTextColor,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'You will need to confirm this later',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                ElevatedButton(
                  style: loginButtonStyle,
                  onPressed: () {
                    if (emailController.text.isNotEmpty) {
                      Navigator.pushNamed(context, '/passwordpage',
                          arguments: {'email': emailController.text});
                      print(emailController.text);
                    }
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: buttonTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
