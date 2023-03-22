// ignore_for_file: unused_import, prefer_typing_uninitialized_variables

import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
import 'package:companion_rebuild/features/auth/controller/auth_controller.dart';
import 'package:companion_rebuild/features/components/dynamicLinks/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:notesapp/features/dynamicLinks/firebase_dynamic_links.dart';
import 'package:routemaster/routemaster.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../theme/colors.dart';

var flag;

/// Represents Homepage for Navigation
class NotesViewPage extends ConsumerStatefulWidget {
  const NotesViewPage({super.key});

  @override
  ConsumerState<NotesViewPage> createState() => _NotesViewPageState();
}

class _NotesViewPageState extends ConsumerState<NotesViewPage> {
  bool _isLoading = true;
  late PDFDocument document;
  changePDF(url) async {
    setState(() => _isLoading = true);
    PDFDocument document = await PDFDocument.fromURL(
      url,
      cacheManager: CacheManager(
        Config(
          'pdfCache',
          stalePeriod: const Duration(days: 20),
          maxNrOfCacheObjects: 80,
        ),
      ),
    );
    setState(() => _isLoading = false);
    return document;
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final notes = RouteData.of(context).queryParameters;
      changePDF(notes['wdlink'])
          .then((value) => setState(() => document = value));
      final user = ref.read(userProvider)!;
      if (user.bid.contains(notes['id'])) {
        flag = true;
      } else {
        flag = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
      await FirebaseDynamicLinkService.createDynamicLink(
          true, notes['id']!);
      // print(deeplink);
    }

    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        elevation: 0,
        leading: ZoomTapAnimation(
          child: IconButton(
            icon: const Icon(OctIcons.arrow_left_16, color: appWhiteColor, size: 15,),
            onPressed: () {
              Routemaster.of(context).history.back();
            },
          ),
        ),
        title: Text(
          notes['name']!,
          style: const TextStyle(color: appWhiteColor,fontSize: 15),
        ),
        
        actions: [
          flag == false
              ? ZoomTapAnimation(
                child: IconButton(
                    icon: const Icon(OctIcons.bookmark_16),
                    onPressed: () {
                      addbookmark();
                    }),
              )
              : ZoomTapAnimation(
                child: IconButton(
                    icon: const Icon(OctIcons.bookmark_fill_24),
                    onPressed: () {
                      // print("{$flag} ${user.bid}");
                      removebookmark();
                    },
                  ),
              ),
          ZoomTapAnimation(
            child: IconButton(
                onPressed: () {
                  createShareLink();
                },
                icon: const Icon(OctIcons.share_16)),
          ),
        ],
        centerTitle: true,
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(size.width * 0.1),
        //   child: Padding(
        //     padding: EdgeInsets.all(size.width * 0.03),
        //     child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text(notes['unit']!,
        //               style: const TextStyle(
        //                   fontSize: 10,
        //                   fontWeight: FontWeight.bold,
        //                   color: appWhiteColor)),
        //           SizedBox(
        //             height: size.height * 0.005,
        //           ),
        //           Text(notes['course']!,
        //               style: const TextStyle(
        //                   fontSize: 14,
        //                   fontWeight: FontWeight.bold,
        //                   color: appAccentColor)),
        //         ]),
        //   ),
        // ),
      ),
      body: SizedBox(
        height: size.height * 0.9,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: appAccentColor,
                ),
              )
            : PDFViewer(
                document: document,
                lazyLoad: false,
                showPicker: false,
                zoomSteps: 1,
                indicatorPosition: IndicatorPosition.bottomLeft,
                enableSwipeNavigation: true,
                scrollDirection: Axis.vertical,
                pickerButtonColor: appAccentColor,
              ),
      ),
    );
  }
}
