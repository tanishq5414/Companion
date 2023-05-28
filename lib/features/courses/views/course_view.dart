import 'package:companion/common/flexible_space_appbar.dart';
import 'package:companion/common/sectionchip.dart';
import 'package:companion/constants/constants.dart';
import 'package:companion/features/notes/controller/notes_controller.dart';
import 'package:companion/features/notes/views/notes_details_view.dart';
import 'package:companion/features/notes/widgets/notes_preview.dart';
import 'package:companion/features/user/controller/user_controller.dart';
import 'package:companion/modal/courses.modal.dart';
import 'package:companion/modal/notes.modal.dart';
import 'package:companion/modal/user.modal.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:fpdart/fpdart.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef BoolCallback = void Function(bool val);
final sortNoteProvider = StateProvider<bool?>((ref) => null);

class BasicSliverAppBar extends ConsumerStatefulWidget {
  final CoursesModal course;
  const BasicSliverAppBar({super.key, required this.course});

  static Route route({
    required CoursesModal course,
  }) {
    return MaterialPageRoute<void>(
        builder: (_) => BasicSliverAppBar(
              course: course,
            ));
  }

  @override
  ConsumerState<BasicSliverAppBar> createState() => _BasicSliverAppBarState();

  static _BasicSliverAppBarState? of(BuildContext context) =>
      context.findAncestorStateOfType<_BasicSliverAppBarState>();
}

class _BasicSliverAppBarState extends ConsumerState<BasicSliverAppBar> {
  bool unitView = true;

  set view(bool val) {
    setState(() {
      unitView = val;
    });
  }

  getnotes(List<String> fileIds, List<NotesModal> notes) {
    Map<String, NotesModal> notesMap = {};

    for (var note in notes) {
      notesMap[note.fileId!] = note;
    }

    List<NotesModal> notesList = [];

    for (var fileId in fileIds) {
      var note = notesMap[fileId];
      if (note != null) {
        notesList.add(note);
      }
    }

    return notesList;
  }

  getNotesByUnit(List<String> fileIds, List<NotesModal> notes, int unit) {
    Map<String, NotesModal> notesMap = {};

    for (var note in notes) {
      notesMap[note.fileId!] = note;
    }

    List<NotesModal> notesList = [];

    for (var fileId in fileIds) {
      var note = notesMap[fileId];
      if (note != null && note.unit == unit) {
        notesList.add(note);
      }
    }

    return notesList;
  }

  getTimeago(String createdAt) {
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(createdAt));
    return timeago.format(date, locale: 'en_short');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var notes = ref.watch(notesDataProvider)!;
    final user = ref.watch(userDataProvider)!;
    var sortedAlphabetical = ref.watch(sortNoteProvider) ?? true;

    List<NotesModal> notesList = getnotes(widget.course.fileId!, notes);
    List<NotesModal> unit0notesList =
        getNotesByUnit(widget.course.fileId!, notes, 0);
    List<NotesModal> unit1notesList =
        getNotesByUnit(widget.course.fileId!, notes, 1);
    List<NotesModal> unit2notesList =
        getNotesByUnit(widget.course.fileId!, notes, 2);
    List<NotesModal> unit3notesList =
        getNotesByUnit(widget.course.fileId!, notes, 3);
    List<NotesModal> unit4notesList =
        getNotesByUnit(widget.course.fileId!, notes, 4);
    List<NotesModal> unit5notesList =
        getNotesByUnit(widget.course.fileId!, notes, 5);
    var index = widget.course.cid! % 10;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Pallete.backgroundColor,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              elevation: 0,
              expandedHeight: size.height * 0.35,
              pinned: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      UIConstants.lightColors[index],
                      UIConstants.lightColors[index],
                      UIConstants.lightColors[index].withOpacity(0.5),
                      UIConstants.lightColors[index].withOpacity(0.3),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: MyAppSpace(
                  size: size,
                  title: widget.course.cname!,
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    UIConstants.lightColors[index].withOpacity(0.1),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SortBar(
                      size: size,
                      unitView: unitView,
                      ref: ref,
                      sortAlphabetical: sortedAlphabetical,
                      viewCallback: (val) {
                        setState(() {
                          unitView = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  (unitView)
                      ? Column(
                          children: [
                            UnitExpansionTile(
                                unit0notesList, user, size, 'Miscellaneous'),
                            UnitExpansionTile(
                                unit1notesList, user, size, 'Unit 1'),
                            UnitExpansionTile(
                                unit2notesList, user, size, 'Unit 2'),
                            UnitExpansionTile(
                                unit3notesList, user, size, 'Unit 3'),
                            UnitExpansionTile(
                                unit4notesList, user, size, 'Unit 4'),
                            UnitExpansionTile(
                                unit5notesList, user, size, 'Unit 5'),
                          ],
                        )
                      : Container(),
                  (!unitView)
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: notesList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (sortedAlphabetical) {
                              notesList
                                  .sort((a, b) => a.name!.compareTo(b.name!));
                            } else {
                              notesList.sort((a, b) =>
                                  b.createdAt!.compareTo(a.createdAt!));
                            }
                            return NotesView(notesList, index, user, size);
                          },
                        )
                      : Container(),
                  SizedBox(
                    height: size.height * 0.1,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  ExpansionTile UnitExpansionTile(
      List<NotesModal> unitnotesList, UserModal user, Size size, String title) {
    return ExpansionTile(
      iconColor: Pallete.whiteColor,
      collapsedIconColor: Pallete.whiteColor,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        title,
        style: TextStyle(color: Pallete.whiteColor),
      ),
      children: [
        Padding(
          padding: EdgeInsets.only(left: size.width * 0.1),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: (unitnotesList.length != 0) ? unitnotesList.length : 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (unitnotesList.length != 0) {
                if (ref.read(sortNoteProvider) ?? true) {
                  unitnotesList.sort((a, b) => a.name!.compareTo(b.name!));
                } else {
                  unitnotesList
                      .sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
                }
              }
              return (unitnotesList.length != 0)
                  ? NotesView(unitnotesList, index, user, size)
                  : Container(
                      height: size.height * 0.1,
                      child: Center(
                        child: Text(
                          'No notes found',
                          style: TextStyle(color: Pallete.whiteColor),
                        ),
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }

  ListTile NotesView(
      List<NotesModal> notesList, int index, UserModal user, Size size) {
    return ListTile(
      onLongPress: () => Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false, // set to false
          pageBuilder: (_, __, ___) => NotesMenu(
            notes: notesList[index],
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      ),
      title: Text(
        notesList[index].name!,
        // 'Notes ${index + 1}',
        style: TextStyle(color: Pallete.whiteColor),
      ),
      subtitle: Row(
        children: [
          Text('${notesList[index].unit.toString()} Unit',
              // 'Unit ${index + 1}',
              style: const TextStyle(
                  color: Pallete.lightGreyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w300)),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: 5,
            width: 5,
            decoration: BoxDecoration(
                color: Pallete.lightGreyColor,
                borderRadius: BorderRadius.circular(5)),
          ),
          Text(
            '${getTimeago(notesList[index].createdAt.toString())}',
            // 'Created ${getTimeago(DateTime.now().millisecondsSinceEpoch.toString())}',
            style: const TextStyle(
                color: Pallete.lightGreyColor,
                fontSize: 14,
                fontWeight: FontWeight.w300),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: 5,
            width: 5,
            decoration: BoxDecoration(
                color: Pallete.lightGreyColor,
                borderRadius: BorderRadius.circular(5)),
          ),
          Text(
            '${notesList[index].author!.split(' ')[0]}',
            // 'Author ${user.name!.split(' ')[0]}',
            style: const TextStyle(
                color: Pallete.lightGreyColor,
                fontSize: 14,
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          user.bid!.contains(notesList[index].fileId.toString())
              ? const Icon(
                  OctIcons.bookmark_fill_24,
                  color: Pallete.whiteColor,
                )
              : Container(),
          SizedBox(
            width: size.width * 0.04,
          ),
        ],
      ),
    );
  }
}

class SortBar extends StatelessWidget {
  const SortBar({
    super.key,
    required this.size,
    required this.unitView,
    required this.sortAlphabetical,
    required this.viewCallback,
    required this.ref,
  });

  final Size size;
  final bool unitView;
  final BoolCallback? viewCallback;
  final bool sortAlphabetical;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        (unitView)
            ? const SectionChip(
                label: 'Unit view',
                backgroundColor: Colors.white,
                textColor: Pallete.blackColor,
              )
            : SectionChip(
                onTap: () {
                  BasicSliverAppBar.of(context)!.view = true;
                },
                label: 'Unit view',
                backgroundColor: Colors.transparent,
                textColor: Pallete.whiteColor,
                borderColor: Pallete.whiteColor,
              ),
        const SizedBox(
          width: 10,
        ),
        (!unitView)
            ? const SectionChip(
                label: 'All notes',
                backgroundColor: Colors.white,
                textColor: Pallete.blackColor,
              )
            : SectionChip(
                onTap: () {
                  BasicSliverAppBar.of(context)!.view = false;
                },
                label: 'All notes',
                backgroundColor: Colors.transparent,
                textColor: Pallete.whiteColor,
                borderColor: Pallete.whiteColor,
              ),
        const Spacer(),
        InkWell(
          onTap: () {
            showModalBottomSheet(
                constraints: BoxConstraints(
                  maxHeight: size.height * 0.3,
                  minHeight: size.height * 0.3,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                backgroundColor: Pallete.greyColor,
                context: context,
                builder: (context) {
                  return ListView(
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      ListTile(
                        title: Text(
                          'Sort by',
                          style: TextStyle(
                              color: Pallete.whiteColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          ref
                              .read(sortNoteProvider.notifier)
                              .update((state) => true);
                          Navigator.pop(context);
                        },
                        title: Text(
                          'Alphabetical',
                          style: TextStyle(color: Pallete.whiteColor),
                        ),
                        trailing: Icon(
                          (sortAlphabetical) ? OctIcons.check_24 : null,
                          color: Pallete.whiteColor,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          ref
                              .read(sortNoteProvider.notifier)
                              .update((state) => false);
                          Navigator.pop(context);
                        },
                        title: Text(
                          'Recent',
                          style: TextStyle(color: Pallete.whiteColor),
                        ),
                        trailing: Icon(
                          (!sortAlphabetical) ? OctIcons.check_24 : null,
                          color: Pallete.whiteColor,
                        ),
                      ),
                      // create a cancel button
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Pallete.whiteColor,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                });
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Text(
                  '${(sortAlphabetical) ? 'Alphabetical' : 'Recent'}',
                  style: TextStyle(
                      color: Pallete.whiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                Icon(
                  OctIcons.arrow_down_24,
                  size: 15,
                  color: Pallete.whiteColor,
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
