import 'package:companion/features/notes/controller/notes_controller.dart';
import 'package:companion/features/notes/views/notes_pdf_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class FirebaseDynamicLinkService {
  static Future<void> createDynamicLink(bool short, String notesid, context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Creating Dynamic Link'),
        content: Text('Please wait...'),
      );
    },
  );

  String _linkMessage;
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://companion.lightheads.org/notes',
    link: Uri.parse('https://companion.lightheads.org/notes?id=$notesid'),
    androidParameters: const AndroidParameters(
      packageName: 'com.lightheads.companion.app',
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
  Navigator.pop(context); // Close the dialog
  return Share.share(_linkMessage);
}

  static Future<void> handleSpecificDynamicLink(
      Uri deepLink, WidgetRef ref, context) async {
    print(deepLink);
    var isNote = deepLink.pathSegments.contains('notes');
    if (isNote) {
      String id = deepLink.queryParameters['id']!;
      print(id);
      var notes = ref.watch(notesDataProvider)!;
      for(var note in notes){
        if(note.fileId == id){
          Navigator.push(context, MaterialPageRoute(builder: (context) => NotesPdfView(notes: note,)));
          break;
        }
      }
    }
  }

  static Future<void> initDynamicLink(
      BuildContext context, WidgetRef ref) async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      await handleSpecificDynamicLink(deepLink, ref, context);
    }

    FirebaseDynamicLinks.instance.onLink.listen((event) async {
      final deeplink = event.link;

      await handleSpecificDynamicLink(deeplink, ref, context);
    });
  }
}
