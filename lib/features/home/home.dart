// ignore_for_file: unused_element, unused_import, unused_local_variable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:companion_rebuild/core/provider/courses_provider.dart';
import 'package:companion_rebuild/features/components/advertisment.dart';
import 'package:companion_rebuild/features/components/loader.dart';
import 'package:companion_rebuild/features/home/components/trending_notes_builder.dart';
import 'package:companion_rebuild/modal/notes_modal.dart';
import 'package:companion_rebuild/modal/trendingnotes_modal.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:routemaster/routemaster.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../core/provider/notes_provider.dart';
import '../../theme/colors.dart';
import '../auth/controller/auth_controller.dart';
import '../components/course_builder.dart';
import '../components/heading.dart';
import '../components/notes_builder.dart';
import '../components/subheading.dart';
import 'components/recents_builder.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'morning';
    }
    if (hour < 17) {
      return 'afternoon';
    }
    return 'evening';
  }
  List<Notes> mostPopular(AsyncValue<List<Notes>> notesData, trendingData) {
      List<Notes> mostpopular = [];
      notesData.when(data: (data) {
        for(int i = 0;i<data.length;i++){
          trendingData.forEach((element) {
            if(data[i].id == element.id){
              mostpopular.add(data[i]);
            }
          });
        }
      }, loading: () {}, error: (e, s) {});
      return mostpopular;
    }

  List<Notes> trendingtoday(AsyncValue<List<Notes>> notesData, trendingData) {
    List<Notes> mostrecent = [];
    notesData.when(data: (data) {
      for (int i = 0; i < data.length; i++) {
        trendingData.forEach((TrendingNotesModal element) {
          
          if (data[i].id == element.id) {
            mostrecent.add(data[i]);
          }
        });
      }
    }, loading: () {}, error: (e, s) {});
    return mostrecent;
  } 
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final notesData = ref.watch(notesDataProvider);
    final courseData = ref.watch(coursesDataProvider);
    final user = ref.watch(userProvider);
    final trendingData = ref.watch(trendingDataProvider)??[];
    final trendingTodayData = ref.watch(trendingTodayDataProvider)??[];
    final ButtonStyle leadingStyle = ElevatedButton.styleFrom(
      minimumSize: Size(size.height * 0.05, size.height * 0.05),
      backgroundColor: appBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const CircleBorder(),
    );
    
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.02),
      color: appBackgroundColor,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: appBackgroundColor,
            body: (user != null)
                ? NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: appBackgroundColor,
                        elevation: 0,
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const AutoSizeText('Hey, ',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            AutoSizeText(user.name.split(' ')[0],
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ],
                        ),
                        actions: [
                          (user.isAdmin)
                              ? ZoomTapAnimation(
                                  child: IconButton(
                                    visualDensity: VisualDensity(
                                      horizontal: -4.0,
                                    ),
                                    style: leadingStyle,
                                    icon: const Icon(
                                      OctIcons.plus_circle_16,
                                      color: Colors.white,
                                      size: 21,
                                    ),
                                    onPressed: () {
                                      Routemaster.of(context).push('/addnotes');
                                    },
                                  ),
                                )
                              : Container(),
                          (user.isPremiumUser)
                              ? ZoomTapAnimation(
                                  child: IconButton(
                                    visualDensity: VisualDensity(
                                      horizontal: -4.0,
                                    ),
                                    style: leadingStyle,
                                    icon: const Icon(
                                      OctIcons.history_16,
                                      color: Colors.white,
                                      size: 21,
                                    ),
                                    onPressed: () {
                                      Routemaster.of(context)
                                          .push('/recentlyaccessed');
                                    },
                                  ),
                                )
                              : Container(),
                          ZoomTapAnimation(
                            child: IconButton(
                              visualDensity: VisualDensity(
                                horizontal: -4.0,
                              ),
                              style: leadingStyle,
                              icon: const Icon(
                                OctIcons.gear_16,
                                color: Colors.white,
                                size: 21,
                                // shadows: <Shadow>[Shadow(color: Colors.white, blurRadius: 15.0)],
                              ),
                              onPressed: () =>
                                  Routemaster.of(context).push('/settings'),
                            ),
                          )
                        ],
                      ),
                    ],
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.01,
                                right: size.width * 0.01),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.04,
                                        right: size.width * 0.04),
                                    child: const SubHeading(
                                      subheading: 'Your courses',
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text('Filter',
                                          style: TextStyle(
                                              color: appWhiteColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.02,
                                            right: size.width * 0.04),
                                        child: ZoomTapAnimation(
                                          child: InkWell(
                                            child: const Icon(
                                              OctIcons.filter_16,
                                              color: appWhiteColor,
                                              size: 20,
                                            ),
                                            onTap: () {
                                              Routemaster.of(context)
                                                  .push('/courselistfilter');
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: size.width * 0.05,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.02,
                                right: size.width * 0.02),
                            child: courseBuilder(size, context, ref),
                          ),
                          Padding(
                            padding: EdgeInsets.all(size.width * 0.05),
                            child: advertismentBuilder(size, context, ref),
                          ),
                          // SizedBox(
                          //   height: size.height * 0.05,
                          // ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.02,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.02),
                                  child: const TextHeading(
                                    heading: 'Trending today',
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Consumer(
                                          builder: (context, ref, child) =>
                                              trendingbuilder(size, trendingtoday(notesData, trendingTodayData))),
                                      SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: size.width * 0.02),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.02),
                                  child: const TextHeading(
                                      heading: 'Latest notes'),
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Consumer(
                                          builder: (context, ref, child) =>
                                              recentsBuilder(size, notesData)),
                                      SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.02),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.02),
                                  child: const TextHeading(
                                      heading: 'Most popular'),
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      trendingbuilder(size, mostPopular(notesData, trendingData)),
                                      SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )),
      ),
    );
  }
}
