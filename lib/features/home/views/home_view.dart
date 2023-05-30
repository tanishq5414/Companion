import 'package:cached_network_image/cached_network_image.dart';
import 'package:companion/common/common.dart';
import 'package:companion/common/sectionchip.dart';
import 'package:companion/core/providers/dummy_user_provider.dart';
import 'package:companion/features/advertisment/widgets/advertisment_builder.dart';
import 'package:companion/features/chat/views/global_chat.dart';
import 'package:companion/features/courses/views/course_filter.dart';
import 'package:companion/features/courses/widgets/course_builder_view.dart';
import 'package:companion/features/notes/controller/notes_controller.dart';
import 'package:companion/features/notes/views/recently_accessed_view.dart';
import 'package:companion/features/notes/widgets/notes_builder_view.dart';
import 'package:companion/features/home/widgets/side_drawer.dart';
import 'package:companion/features/user/controller/user_controller.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  bool internetConnection = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
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
  Widget build(BuildContext context) {
    checkInternetConnection() async {
      internetConnection = await InternetConnectionChecker().hasConnection;
      setState(() {
        internetConnection = internetConnection;
      });
    }

    checkInternetConnection();
    final user = ref.watch(userDataProvider);
    final size = MediaQuery.of(context).size;
    final notesData = ref.watch(notesDataProvider) ?? [];
    final trendingDaily = ref.watch(trendingNotesDailyProvider);
    final trendingWeekly = ref.watch(trendingNotesWeeklyProvider);
    return (user == null)
        ? const Loader()
        : Container(
            color: Pallete.backgroundColor,
            child: SafeArea(
              child: Scaffold(
                key: _key,
                drawer: SideDrawer(
                  size: size,
                  ref: ref,
                ),
                body: Container(
                  margin: EdgeInsets.only(top: size.height * 0.03),
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
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
                                    image: CachedNetworkImageProvider(
                                        user.photoUrl!),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            const SizedBox(width: 18),
                            Text(
                              'Good ${greeting()}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 24),
                            ),
                          ],
                        ),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context, MobileChatScreen.route(user.uid!));
                              },
                              child: Stack(
                                children: [
                                  Image.asset('assets/logo/dm.png',
                                      width: size.width * 0.08),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      width: size.width * 0.03,
                                      height: size.width * 0.03,
                                      decoration: BoxDecoration(
                                        color: Pallete.redColor,
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: _StickyHeaderDelegate(
                          minHeight: 60,
                          maxHeight: 60,
                          child: Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context, CourseFilterView.route());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Pallete.greyColor,
                                        border: Border.all(
                                            color: Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Row(
                                          children: const [
                                            Text(
                                              'Courses',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Pallete.whiteColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(width: 8),
                                            Icon(
                                              OctIcons.pencil_24,
                                              color: Pallete.whiteColor,
                                              size: 12,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  SectionChip(
                                    onTap: () {
                                      Navigator.push(context,
                                          RecentlyAccessedView.route());
                                    },
                                    label: 'Recently accessed',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (internetConnection == true)
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Pallete.whiteColor),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          height: size.height * 0.08,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('You are offline',
                                                    style: TextStyle(
                                                        color:
                                                            Pallete.whiteColor,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontSize: 15)),
                                                const SizedBox(width: 8),
                                                Text(
                                                    'Some features may be limited',
                                                    style: TextStyle(
                                                        color:
                                                            Pallete.whiteColor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15)),
                                              ],
                                            ),
                                          )),
                                    ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: courseBuilder(size, context, ref),
                              ),
                              const SizedBox(height: 28),
                              const Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  'Trending today',
                                  style: TextStyle(
                                      color: Pallete.whiteColor,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 25),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 13),
                                child: notesBuilder(size, trendingDaily!),
                              ),
                              const SizedBox(height: 28),
                              advertismentBuilder(
                                      size, context, ref, "home"),
                              const Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  'Latest notes',
                                  style: TextStyle(
                                      color: Pallete.whiteColor,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 25),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 13),
                                child: notesBuilder(size, notesData),
                              ),
                              const SizedBox(height: 28),
                              const Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  'Trending this week',
                                  style: TextStyle(
                                      color: Pallete.whiteColor,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 25),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 13),
                                child: notesBuilder(size, trendingWeekly!),
                              ),
                              SizedBox(height: size.height * 0.12),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _StickyHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
