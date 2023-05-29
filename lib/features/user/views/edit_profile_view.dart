import 'package:companion/common/common.dart';
import 'package:companion/core/providers/dummy_user_provider.dart';
import 'package:companion/features/user/controller/user_controller.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class EditProfile extends ConsumerStatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const EditProfile());
  }

  const EditProfile({super.key});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  TextEditingController nameController = TextEditingController();
  late Color saveColor;

  @override
  void initState() {
    final user = ref.read(userDataProvider) ?? nullUser;
    super.initState();
    nameController = TextEditingController(text: user!.name);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = ref.read(userDataProvider) ?? nullUser;
    final String email = user.email!;
    final name = user.name;
    Color saveColor = Colors.grey;
    if (user.name != nameController.text) {
      saveColor = Colors.white;
    }
    return Container(
      color: Pallete.backgroundColor,
      child: SafeArea(
          child: Scaffold(
              backgroundColor: Pallete.backgroundColor,
              appBar: CustomAppBar(
                title: 'Edit profile',
                actions: [
                  ZoomTapAnimation(
                    child: TextButton(
                        onPressed: () {
                          if (name != nameController.text) {
                            ref
                                .read(userControllerProvider.notifier)
                                .updateName(
                                    context, nameController.text, user.uid);
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
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.06,
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
                    Container(
                      width: size.width * 0.3,
                      height: size.width * 0.3,
                      decoration: BoxDecoration(
                        color: Pallete.whiteColor,
                        image: DecorationImage(
                          image: NetworkImage(user.photoUrl!),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    ZoomTapAnimation(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textAlign: TextAlign.center,
                        cursorColor: Pallete.whiteColor,
                        onTap: () => nameController.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: nameController.value.text.length),
                        cursorWidth: 1,
                        cursorHeight: 25,
                        controller: nameController,
                        style: const TextStyle(
                            color: Pallete.whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Divider(
                      color: Pallete.whiteColor,
                      thickness: 0.5,
                      indent: size.width * 0.15,
                      endIndent: size.width * 0.15,
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    const Text('This could be your name or username',
                        style: TextStyle(
                            color: Pallete.whiteColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w300)),
                    const Text('This is how your name will appear to others',
                        style: TextStyle(
                            color: Pallete.whiteColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w300)),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      email,
                      style: const TextStyle(
                          color: Pallete.whiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    Divider(
                      color: Pallete.whiteColor,
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
