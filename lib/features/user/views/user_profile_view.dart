import 'package:companion/common/common.dart';
import 'package:companion/common/sectionchip.dart';
import 'package:companion/core/providers/dummy_user_provider.dart';
import 'package:companion/features/user/controller/user_controller.dart';
import 'package:companion/features/user/views/edit_profile_view.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileView extends ConsumerStatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const UserProfileView());
  }

  const UserProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => UserProfileViewState();
}

class UserProfileViewState extends ConsumerState<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDataProvider) ?? nullUser;
    var size = MediaQuery.of(context).size;
    return Container(
      color: Pallete.backgroundColor,
      child: SafeArea(
        child: (user == null)
            ? const Loader()
            : Scaffold(
                appBar: AppBar(),
                body: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
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
                            SizedBox(width: size.width * 0.08),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.name!,
                                    style: const TextStyle(
                                        color: Pallete.whiteColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(user.followers!.length.toString(),
                                        style: const TextStyle(
                                            color: Pallete.whiteColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900)),
                                    const SizedBox(width: 5),
                                    Text('followers',
                                        style: const TextStyle(
                                            color: Pallete.lightGreyColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal)),
                                    const SizedBox(width: 7),
                                    Text(user.followers!.length.toString(),
                                        style: const TextStyle(
                                            color: Pallete.whiteColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900)),
                                    const SizedBox(width: 5),
                                    Text('following',
                                        style: const TextStyle(
                                            color: Pallete.lightGreyColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: size.width * 0.05),
                        SectionChip(
                          onTap: () {
                            Navigator.push(context, EditProfile.route());
                          },
                          label: 'Edit',
                          backgroundColor: Colors.transparent,
                          borderColor: Pallete.whiteColor,
                        ),
                        SizedBox(height: size.width * 0.05),
                        const Text('Contributions',
                            style: TextStyle(
                                color: Pallete.whiteColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w900)),
                        SizedBox(height: size.width * 0.05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Notes',
                                style: TextStyle(
                                    color: Pallete.whiteColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300)),
                            Text(user.notesContributed!.toString(),
                                style: const TextStyle(
                                    color: Pallete.whiteColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900)),
                          ],
                        ),
                        SizedBox(height: size.width * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Courses',
                                style: TextStyle(
                                    color: Pallete.whiteColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300)),
                            Text(user.coursesContributed!.toString(),
                                style: const TextStyle(
                                    color: Pallete.whiteColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900)),
                          ],
                        ),
                        SizedBox(height: size.width * 0.08),
                        (!user.isAdmin!)
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Not a contributor?',
                                      style: TextStyle(
                                          color: Pallete.whiteColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900)),
                                  SectionChip(
                                    onTap: () {},
                                    label: 'Become a contributor',
                                    backgroundColor: Pallete.whiteColor,
                                    textColor: Pallete.blackColor,
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                )),
      ),
    );
  }
}
