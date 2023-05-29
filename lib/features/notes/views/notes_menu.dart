import 'package:companion/core/providers/dummy_user_provider.dart';
import 'package:companion/features/dynamiclinks/dynamic_links.dart';
import 'package:companion/features/notes/views/notes_info_view.dart';
import 'package:companion/features/notes/widgets/notes_preview.dart';
import 'package:companion/features/user/controller/user_controller.dart';
import 'package:companion/modal/notes.modal.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class NotesMenu extends ConsumerStatefulWidget {
  static Route route({required NotesModal notes}) {
    return MaterialPageRoute<void>(builder: (_) => NotesMenu(notes: notes));
  }

  final NotesModal notes;
  const NotesMenu({super.key, required this.notes});

  @override
  ConsumerState<NotesMenu> createState() => _NotesMenuState();
}

class _NotesMenuState extends ConsumerState<NotesMenu> {
  @override
  @override
  Widget build(BuildContext context) {
    bool bookmark() {
      late bool flag;
      final user = ref.watch(userDataProvider)??nullUser;
      if (user.bid!.contains(widget.notes.fileId)) {
        flag = true;
      } else {
        flag = false;
      }
      return flag;
    }

    bool flag = bookmark();
    final user = ref.watch(userDataProvider)??nullUser;
    final size = MediaQuery.of(context).size;
    void addbookmark() {
      setState(() {
        ref
            .read(userControllerProvider.notifier)
            .bookmarkNotes(context, widget.notes.fileId!);
        flag = true;
      });
    }

    flag = bookmark();
    void removebookmark() {
      setState(() {
        ref
            .read(userControllerProvider.notifier)
            .bookmarkNotes(context, widget.notes.fileId!);
        flag = false;
      });
    }

    void createShareLink() async {
      // TODO: implement dynamic linking
      await FirebaseDynamicLinkService.createDynamicLink(true, widget.notes.fileId!, context);
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black,
            Colors.black,
          ],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.only(top: size.height * 0.36),
              height: size.height * 0.62,
              width: size.width,
              child: Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.12, right: size.width * 0.12),
                child: Column(
                  verticalDirection: VerticalDirection.up,
                  children: [
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                    ListTile(
                      leading: const Icon(OctIcons.info_16,
                          color: Pallete.whiteColor),
                      title: const ZoomTapAnimation(
                        child: Text('Info',
                            style: TextStyle(color: Pallete.whiteColor)),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false, // set to false
                            pageBuilder: (_, __, ___) => NotesInfoView(
                              notes: widget.notes,
                            ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(0.0, 1.0);
                              const end = Offset.zero;
                              const curve = Curves.ease;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(OctIcons.share_16,
                          color: Pallete.whiteColor),
                      title: const ZoomTapAnimation(
                        child: Text('Share',
                            style: TextStyle(color: Pallete.whiteColor)),
                      ),
                      onTap: (() => createShareLink()),
                    ),
                    (flag == false)
                        ? ListTile(
                            leading: const Icon(OctIcons.bookmark_16,
                                color: Pallete.whiteColor),
                            title: const ZoomTapAnimation(
                              child: Text('Bookmark',
                                  style: TextStyle(color: Pallete.whiteColor)),
                            ),
                            onTap: () {
                              addbookmark();
                            },
                          )
                        : ListTile(
                            leading: const ZoomTapAnimation(
                              child: Icon(OctIcons.bookmark_fill_24,
                                  color: Pallete.whiteColor),
                            ),
                            title: const Text('Bookmarked',
                                style: TextStyle(color: Pallete.whiteColor)),
                            onTap: () {
                              removebookmark();
                            },
                          ),
                    SizedBox(height: size.height * 0.1),
                    Expanded(
                      child: NotesPreview(
                        notes: widget.notes,
                        size: size,
                        disableonTap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
