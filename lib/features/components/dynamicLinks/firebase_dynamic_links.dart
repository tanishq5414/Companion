import 'package:companion_rebuild/core/provider/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:share_plus/share_plus.dart';

import '../../../modal/notes_modal.dart';

FirebaseDynamicLinkService firebaseDynamicLinkService =
    FirebaseDynamicLinkService();

class FirebaseDynamicLinkService {
  static Future<void> createDynamicLink(bool short, String notesid) async {
    String _linkMessage;
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://companion.lightheads.org/notes',
      link: Uri.parse('https://companion.lightheads.org/notes?id=${notesid}'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.notesapp',
        minimumVersion: 0,
      ),
    );
    final link = FirebaseDynamicLinks.instance;
    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await link.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await link.buildLink(parameters);
    }

    _linkMessage = url.toString();
    print(_linkMessage);
    return Share.share(_linkMessage);
  }

  static Future<void> initDynamicLink(
      BuildContext context, ref) async {
    FirebaseDynamicLinks.instance.onLink.listen((event) {
      final deeplink = event.link;
      var isNote = deeplink.pathSegments.contains('notes');
      print(isNote);
      if (isNote) {
        String id = deeplink.queryParameters['id']!;
        print('this is the id $id');
        final AsyncValue<List<Notes>> notesData = ref.watch(notesDataProvider);
        print(notesData.value);
        var noteList = notesData.value!;
            for (int i = 0; i < noteList.length - 1; i++) {
              print(noteList[i].id == id);
              if (noteList[i].id == id) {
                final notes = noteList[i];
                print(notes);
                // Routemaster.of(context).popUntil((routeData) => false);
                Routemaster.of(context).push('/pdfview', queryParameters: {
                  'id': notes.id,
                  'name': notes.name,
                  'year': notes.year,
                  'branch': notes.branch,
                  'course': notes.course,
                  'semester': notes.semester,
                  'version': notes.version,
                  'unit': notes.unit,
                  'wdlink': notes.wdlink,
                });
              }
            }
      }
    });

      }
}
