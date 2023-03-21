import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../theme/colors.dart';
import '../auth/controller/auth_controller.dart';
import '../components/dynamicLinks/firebase_dynamic_links.dart';
import '../components/notes_preview.dart';

class NotesMenu extends ConsumerStatefulWidget {
  const NotesMenu({super.key});

  @override
  ConsumerState<NotesMenu> createState() => _NotesMenuState();
}

class _NotesMenuState extends ConsumerState<NotesMenu> {
  @override
  @override
  Widget build(BuildContext context) {
    bool bookmark() {
      late bool flag;
      final notes = RouteData.of(context).queryParameters;
      final user = ref.read(userProvider)!;
      if (user.bid.contains(notes['id'])) {
        flag = true;
      } else {
        flag = false;
      }
      return flag;
    }

    bool flag = bookmark();
    final user = ref.read(userProvider)!;
    var bid = user.bid;
    final size = MediaQuery.of(context).size;
    var notes = RouteData.of(context).queryParameters;
    void addbookmark() {
      bid.add(notes['id']!);
      setState(() {
        ref
            .read(authControllerProvider.notifier)
            .bookmarkNotes(context, user.id, bid);
        flag = true;
      });
    }

    flag = bookmark();
    void removebookmark() {
      bid.remove(notes['id']!);
      setState(() {
        ref
            .read(authControllerProvider.notifier)
            .bookmarkNotes(context, user.id, bid);
        flag = false;
      });
    }

    void createShareLink() async {
      await FirebaseDynamicLinkService.createDynamicLink(true, notes['id']!);
    }

    return SafeArea(
      child: Scaffold(
        body: InkWell(
          onTap: () => Routemaster.of(context).history.back(),
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.12, right: size.width * 0.12),
              child: Column(
                verticalDirection: VerticalDirection.up,
                children: [
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  ListTile(
                    leading: const Icon(OctIcons.info_16, color: appWhiteColor),
                    title: const ZoomTapAnimation(
                      child:
                          Text('Info', style: TextStyle(color: appWhiteColor)),
                    ),
                    onTap: () {
                      Routemaster.of(context)
                          .push('/notesinfo', queryParameters: notes);
                    },
                  ),
                  ListTile(
                    leading:
                        const Icon(OctIcons.share_16, color: appWhiteColor),
                    title: const ZoomTapAnimation(
                      child:
                          Text('Share', style: TextStyle(color: appWhiteColor)),
                    ),
                    onTap: (() => createShareLink()),
                  ),
                  (flag == false)
                      ? ListTile(
                          leading: const Icon(OctIcons.bookmark_16,
                              color: appWhiteColor),
                          title: const ZoomTapAnimation(
                            child: Text('Bookmark',
                                style: TextStyle(color: appWhiteColor)),
                          ),
                          onTap: () {
                            addbookmark();
                          },
                        )
                      : ListTile(
                          leading: const ZoomTapAnimation(
                            child: Icon(OctIcons.bookmark_fill_24,
                                color: appAccentColor),
                          ),
                          title: const Text('Bookmarked',
                              style: TextStyle(color: appWhiteColor)),
                          onTap: () {
                            removebookmark();
                          },
                        ),
                  SizedBox(height: size.height * 0.1),
                  NotesPreview(
                    id: notes['id']!,
                    name: notes['name']!,
                    year: notes['year']!,
                    branch: notes['branch']!,
                    course: notes['course']!,
                    semester: notes['semester']!,
                    version: notes['version']!,
                    unit: notes['unit']!,
                    wdlink: notes['wdlink']!,
                    pressable: false,
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
