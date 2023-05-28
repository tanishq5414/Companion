// ignore_for_file: prefer_const_constructors

import 'package:companion/common/common.dart';
import 'package:companion/core/core.dart';
import 'package:companion/features/auth/controller/auth_controller.dart';
import 'package:companion/features/auth/views/login_view.dart';
import 'package:companion/features/info/aboutcompanionview.dart';
import 'package:companion/features/info/aboutlightheadsview.dart';
import 'package:companion/features/info/contactdevs.dart';
import 'package:companion/features/info/privacypolicyview.dart';
import 'package:companion/features/user/controller/user_controller.dart';
import 'package:companion/features/user/views/user_profile_view.dart';
import 'package:companion/features/user/widgets/display_tile.dart';
import 'package:companion/features/user/widgets/sideheading.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SettingsPage extends ConsumerWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SettingsPage());
  }

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(userDataProvider);
    void signOut() {
      ref.read(authControllerProvider.notifier).signOut(context);
      Navigator.popUntil(context, (route) => false);
      Navigator.push(context, LoginView.route());
    }

    void deleteAccount() {
      // ref.read(authControllerProvider.notifier).deleteAccount(context);
    }
    var size = MediaQuery.of(context).size;
    // final appAccentColor = Theme.of(context).accentColor;
    final margin = EdgeInsets.symmetric(horizontal: size.width * 0.02);
    return Container(
      color: Pallete.backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Pallete.backgroundColor,
          appBar: CustomAppBar(title: 'Settings'),
          body: Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ZoomTapAnimation(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: size.width * 0.025),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, UserProfileView.route());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * 0.15,
                              height: size.width * 0.15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(user!.photoUrl!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.05,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name!,
                                  style: const TextStyle(
                                    color: Pallete.whiteColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                const Text('View Profile',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Pallete.whiteColor,
                                    )),
                              ],
                            ),
                            Spacer(),
                            const Icon(OctIcons.chevron_right_16,
                                color: Pallete.whiteColor),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  SideHeading(
                    title: "Account",
                  ),
                  DisplayTile(
                    title: 'Premium plan',
                    subtitle: 'View your plan',
                    onpressed: () {
                      // Routemaster.of(context).push('/premiumstatus');
                    },
                  ),
                  DisplayTile(
                    title: 'Email',
                    subtitle: user.email,
                    onpressed: () {
                      // Routemaster.of(context).push('/changeemail');
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  SideHeading(title: 'About'),
                  DisplayTile(
                    title: 'Version',
                    subtitle: '1.0.4 +5',
                    onpressed: () {},
                  ),
                  DisplayTile(
                    title: 'Privacy policy',
                    subtitle: 'View our privacy policy',
                    onpressed: () {
                      Navigator.push(context, PrivacyPolicyPage.route());
                    },
                  ),
                  DisplayTile(
                    title: 'Info',
                    subtitle: 'About Companion',
                    onpressed: () {
                      Navigator.push(context, AboutCompanion.route());
                    },
                  ),
                  DisplayTile(
                    title: 'About LightHeads',
                    subtitle: 'Join us',
                    onpressed: () {
                      Navigator.push(context, AboutLightHeads.route());
                    },
                  ),
                  DisplayTile(
                    title: 'Contact the Devs',
                    subtitle: 'Get in touch',
                    onpressed: () {
                      Navigator.push(context, ContactDevs.route());
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  SideHeading(title: 'Others'),
                  DisplayTile(
                    title: 'Log out',
                    subtitle: 'Currently logged in as ${user.name}',
                    onpressed: () {
                      signOut();
                    },
                  ),
                  // DisplayTile(
                  //     title: 'Delete Account',
                  //     subtitle: 'This action is irreversible',
                  //     onpressed: () {
                  //       deleteAccount();
                  //     }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
