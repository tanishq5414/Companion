import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/config/colors.dart';
import 'package:notesapp/pages/components/custom_appbar.dart';
import 'package:notesapp/pages/settings/components/profiledisplay.dart';
import 'package:notesapp/provider/firebase_auth_methods.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  late Color saveColor;

  @override
  void initState() {
    final user = context.read<FirebaseAuthMethods>().user;
    Color saveColor = Colors.grey;
    super.initState();
    nameController = TextEditingController(text: user.displayName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = context.read<FirebaseAuthMethods>().user;
    final String email = user.email ?? "update your email";
    final name = user.displayName ?? "Companioner";
    final firstlettername = name[0];
    final image = user.photoURL ?? "null";
    Color saveColor = Colors.grey;
    if(user.displayName != nameController.text){
      saveColor = appAccentColor;
    }
    return Container(
      color: appBackgroundColor,
      child: SafeArea(
          child: Scaffold(
              backgroundColor: appBackgroundColor,
              appBar: CustomAppBar(
                title: 'Edit profile',
                actions: [
                  TextButton(
                      onPressed: () {
                        if (name != nameController.text) {
                          user.updateDisplayName(nameController.text);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: saveColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                    ProfileAvatar(
                      image: image,
                      firstlettername: firstlettername,
                      rad: 75,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Change photo",
                        style: TextStyle(
                            color: appWhiteColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textAlign: TextAlign.center,
                      cursorColor: appAccentColor,
                      onTap: () => nameController.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: nameController.value.text.length),
                      cursorWidth: 1,
                      cursorHeight: 25,
                      controller: nameController,
                      style: const TextStyle(
                          color: appWhiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                    Divider(
                      color: appWhiteColor,
                      thickness: 0.5,
                      indent: size.width * 0.15,
                      endIndent: size.width * 0.15,
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    const Text('This could be your name or username',
                        style: TextStyle(
                            color: appWhiteColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w300)),
                    const Text('This is how your name will appear to others',
                        style: TextStyle(
                            color: appWhiteColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w300)),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      email,
                      style: const TextStyle(
                          color: appWhiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    Divider(
                      color: appWhiteColor,
                      thickness: 0.5,
                      indent: size.width * 0.15,
                      endIndent: size.width * 0.15,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Change email',
                          style: TextStyle(
                              color: appWhiteColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
              ))),
    );
  }
}
