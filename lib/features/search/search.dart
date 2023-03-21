//flutter screen with a search bar
// ignore_for_file: unused_import

import 'package:companion_rebuild/features/components/advertisment.dart';
import 'package:companion_rebuild/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';


class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.03),
      color: appBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Search',
                style: TextStyle(
                  color: appWhiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: size.width * 0.02, right: size.width * 0.02),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.05),
                  const SearchBar(),
                  SizedBox(height: size.height * 0.05),
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.05),
                    child: advertismentBuilder(size, context, ref),
                  ),
                    
                  // SearchResults(),
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
        borderRadius: BorderRadius.circular(2),
      ),
      child: InkWell(
        onTap: () {
          Routemaster.of(context).push('/mainsearch');
        },
        child: ZoomTapAnimation(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(OctIcons.search_16, color: appGreyColor),
              Spacer(),
              Center(child: Text('Search notes, courses, etc.', style: TextStyle(color: appGreyColor, fontSize: 15, fontWeight: FontWeight.bold))),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
