import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/core/provider/notes_provider.dart';
import 'package:notesapp/features/auth/controller/auth_controller.dart';
import 'package:notesapp/theme/colors.dart';
import 'package:notesapp/features/components/heading.dart';
import 'package:notesapp/features/components/notes_builder.dart';
import 'package:routemaster/routemaster.dart';
import '../components/course_builder.dart';
import '../components/subheading.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

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
  
  @override
  Widget build(BuildContext context, ref) {
    var size = MediaQuery.of(context).size;
    final notesData = ref.watch(notesDataProvider);
    final user = ref.watch(userProvider);
    final ButtonStyle leadingStyle = ElevatedButton.styleFrom(
      minimumSize: Size(size.height * 0.05, size.height * 0.05),
      backgroundColor: appBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const CircleBorder(),
    );

    return Container(
      color: appBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: appBackgroundColor,
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: appBackgroundColor,
                elevation: 0,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Good ',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Text(greeting(),
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ],
                ),
                actions: [
                  TextButton(
                    style: leadingStyle,
                    child: const Icon(Icons.notification_important_outlined,
                        color: Colors.white),
                    onPressed: () {
                      ref
                          .read(authControllerProvider.notifier)
                          .signOut(context);
                    },
                  ),
                  TextButton(
                      style: leadingStyle,
                      child: const Icon(Icons.settings, color: Colors.white),
                      onPressed: () => Routemaster.of(context).push('/settings'),
                      )
                ],
              ),
            ],
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.04,
                              right: size.width * 0.04),
                          child: const SubHeading(
                            subheading: 'Your courses',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.04,
                              right: size.width * 0.04),
                          child: InkWell(
                            child: const Icon(
                              Icons.filter_list,
                              color: Colors.white,
                            ),
                            onTap: () {
                              Routemaster.of(context).push('/courselistfilter');
                            },
                          ),
                        ),
                      ]),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  courseBuilder(size, context, ref),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.02),
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
                                    notesBuilder(size, notesData)),
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
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.02),
                        child: const TextHeading(heading: 'Recently added'),
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
                                    notesBuilder(size, notesData)),
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
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.02),
                        child: const TextHeading(heading: 'Your bookmarks'),
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
                                    notesBuilder(size, notesData)),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}