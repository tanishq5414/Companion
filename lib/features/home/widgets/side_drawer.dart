import 'package:cached_network_image/cached_network_image.dart';
import 'package:companion/core/providers/dummy_user_provider.dart';
import 'package:companion/features/info/aboutlightheadsview.dart';
import 'package:companion/features/notes/views/add_notes_view.dart';
import 'package:companion/features/notes/views/recently_accessed_view.dart';
import 'package:companion/features/user/controller/user_controller.dart';
import 'package:companion/features/user/views/settings_view.dart';
import 'package:companion/features/user/views/user_profile_view.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SideDrawer extends StatelessWidget {
  final Size size;
  final WidgetRef ref;
  const SideDrawer({
    super.key,
    required this.size,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDataProvider)??nullUser;
    //generate color from common colors from image

    return Drawer(
      backgroundColor: Pallete.greyColor,
      width: size.width * 0.85,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding:
            EdgeInsets.fromLTRB(size.width * 0.02, size.width * 0.03, 0, 0),
        children: [
          SizedBox(height: size.width * 0.03),
          Row(
            children: [
              Container(
                width: size.width * 0.2,
                height: size.width * 0.2,
                decoration: BoxDecoration(
                  color: Pallete.whiteColor,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                                        user.photoUrl!),
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
          SizedBox(height: size.height * 0.025),
          const Divider(color: Pallete.whiteColor),
          ListTile(
            onTap: () {
              Navigator.push(context, UserProfileView.route());
            },
            leading:
                Icon(OctIcons.person_24, color: Pallete.whiteColor, size: 30),
            title: Text('Profile',
                style: TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.normal)),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, RecentlyAccessedView.route());
            },
            leading:
                Icon(OctIcons.clock_24, color: Pallete.whiteColor, size: 30),
            title: Text('Recently accessed',
                style: TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.normal)),
          ),
          (user.isAdmin!)
              ? ListTile(
                  onTap: () {
                    Navigator.push(context, AddNotesView.route());
                  },
                  leading: Icon(OctIcons.plus_circle_24,
                      color: Pallete.whiteColor, size: 30),
                  title: Text('Add notes',
                      style: TextStyle(
                          color: Pallete.whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                )
              : Container(),
          ListTile(
            onTap: () {
              Navigator.push(context, SettingsPage.route());
            },
            leading:
                Icon(OctIcons.gear_24, color: Pallete.whiteColor, size: 30),
            title: Text('Settings',
                style: TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.normal)),
          ),
          Divider(
            color: Pallete.whiteColor,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, AboutLightHeads.route());
            },
            leading: Image.asset(
              'assets/logo/shortlogo.png',
              width: 30,
              height: 30,
            ),
            title: Text('LightHeads',
                style: TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.normal)),
          ),
        ],
      ),
    );
  }
}
