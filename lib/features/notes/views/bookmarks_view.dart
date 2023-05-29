import 'package:companion/common/common.dart';
import 'package:companion/common/sectionchip.dart';
import 'package:companion/core/providers/dummy_user_provider.dart';
import 'package:companion/features/notes/views/bookmarks_search.dart';
import 'package:companion/features/notes/widgets/notes_preview.dart';
import 'package:companion/features/home/widgets/side_drawer.dart';
import 'package:companion/features/notes/controller/notes_controller.dart';
import 'package:companion/features/user/controller/user_controller.dart';
import 'package:companion/modal/notes.modal.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<String> BookmarkSearchList = [];

class BookmarksView extends ConsumerStatefulWidget {
  const BookmarksView({super.key});

  @override
  ConsumerState<BookmarksView> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends ConsumerState<BookmarksView> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final user = ref.watch(userDataProvider) ?? nullUser;
    final allnoteslist = ref.read(notesDataProvider)!;
    var userbookmarklist = user.bid!;
    List<NotesModal> bookmarks = [];
    List<NotesModal> getBookmarks() {
      Set<String> bookmarkFileIds = Set<String>.from(userbookmarklist);
      for (var note in allnoteslist) {
        if (bookmarkFileIds.contains(note.fileId.toString())) {
          bookmarks.add(note);
        }
      }
      bookmarks = bookmarks.reversed.toList();
      return bookmarks;
    }

    getBookmarks();

    for (var i = 0; i < bookmarks.length; i++) {
      BookmarkSearchList.add(bookmarks[i].name!);
      BookmarkSearchList.add(bookmarks[i].course!);
      BookmarkSearchList.add(bookmarks[i].unit.toString());
    }
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
                    // physics: const NeverScrollableScrollPhysics(),
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
                                    image: NetworkImage(user.photoUrl!),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            const SizedBox(width: 18),
                            Text(
                              'Your bookmarks',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 24),
                            ),
                          ],
                        ),
                        actions: [
                          IconButton(
                            icon: const Icon(OctIcons.search_16),
                            onPressed: () {
                              Navigator.push(
                                  context, BookmarksSearchPage.route());
                            },
                          )
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
                                children: const [
                                  SectionChip(
                                    label: 'Notes',
                                    textColor: Pallete.blackColor,
                                    backgroundColor: Pallete.whiteColor,
                                  ),
                                  SizedBox(width: 8),
                                  // SectionChip(
                                  //   label: 'Recently accessed',
                                  // ),
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
                              Padding(
                                padding: EdgeInsets.only(
                                    top: size.width * 0.05,
                                    left: size.width * 0.05,
                                    right: size.width * 0.05),
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: (size.width / 190 / 2.4),
                                    mainAxisSpacing: 5,
                                  ),
                                  itemCount: bookmarks.length,
                                  itemBuilder: (context, index) => NotesPreview(
                                    size: size,
                                    notes: bookmarks[index],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.15,
                              )
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
