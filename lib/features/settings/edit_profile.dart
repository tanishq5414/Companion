// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/features/auth/controller/auth_controller.dart';
import 'package:notesapp/theme/colors.dart';
import 'package:notesapp/features/components/custom_appbar.dart';
import 'package:notesapp/features/settings/components/profiledisplay.dart';
import 'package:notesapp/features/auth/repository/firebase_auth_methods.dart';
import 'package:routemaster/routemaster.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  TextEditingController nameController = TextEditingController();
  late Color saveColor;

  @override
  void initState() {
    final user = ref.read(userProvider);
    super.initState();
    nameController = TextEditingController(text: user!.name);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = ref.read(userProvider)!;
    final String email = user.email;
    final name = user.name;
    final firstlettername = name[0];
    final image = user.photoUrl;
    Color saveColor = Colors.grey;
    if (user.name != nameController.text) {
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
                          ref
                              .read(authControllerProvider.notifier)
                              .updateName(context, nameController.text,user.id);
                          Routemaster.of(context).pop();
                          Routemaster.of(context).pop();
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
                      width: size.width * 0.6,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: const Text(
                    //     "Change photo",
                    //     style: TextStyle(
                    //         color: appWhiteColor,
                    //         fontSize: 10,
                    //         fontWeight: FontWeight.w500),
                    //   ),
                    // ),
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
                    
                  ],
                ),
              ))),
    );
  }
}
