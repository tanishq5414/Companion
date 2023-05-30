//flutter screen with a search bar
// ignore_for_file: unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:companion/common/common.dart';
import 'package:companion/core/providers/dummy_user_provider.dart';
import 'package:companion/features/advertisment/widgets/advertisment_builder.dart';
import 'package:companion/features/home/widgets/side_drawer.dart';
import 'package:companion/features/notes/controller/notes_controller.dart';
import 'package:companion/features/search/views/search_redirectpage.dart';
import 'package:companion/features/user/controller/user_controller.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({Key? key}) : super(key: key);
  @override
  ConsumerState<SearchView> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchView> {
  bool internetConnection = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    checkInternetConnection() async {
      internetConnection = await InternetConnectionChecker().hasConnection;
      setState(() {
        internetConnection = internetConnection;
      });
    }

    checkInternetConnection();
    final user = ref.watch(userDataProvider) ?? nullUser;
    final size = MediaQuery.of(context).size;
    final notes = ref.watch(notesDataProvider);
    return (user == null)
        ? const Loader()
        : Container(
            margin: EdgeInsets.only(top: size.height * 0.03),
            color: Pallete.backgroundColor,
            child: SafeArea(
              child: Scaffold(
                key: _key,
                backgroundColor: Colors.transparent,
                drawer: SideDrawer(
                  size: size,
                  ref: ref,
                ),
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          _key.currentState!.openDrawer();
                        },
                        child: Container(
                          width: size.width * 0.09,
                          height: size.width * 0.09,
                          decoration: BoxDecoration(
                            color: Pallete.whiteColor,
                            image: DecorationImage(
                              image:CachedNetworkImageProvider(
                                        user.photoUrl!),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      const SizedBox(width: 18),
                      const Text('Search',
                          style: TextStyle(
                            color: Pallete.whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.02, right: size.width * 0.02),
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.05),
                        const SearchBar(),
                        SizedBox(height: size.height * 0.05),
                                Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.03),
                                child: advertismentBuilder(
                                    size, context, ref, "search")),
                        SizedBox(height: size.height * 0.15),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.07,
      width: size.width * 0.9,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.035),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MainSearchPage.route());
        },
        child: ZoomTapAnimation(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(OctIcons.search_16, color: Pallete.blackColor),
              Spacer(),
              Center(
                  child: Text('Search notes, courses, etc.',
                      style: TextStyle(
                          color: Pallete.blackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold))),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
