// ignore_for_file: unused_import, prefer_typing_uninitialized_variables

import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/features/auth/controller/auth_controller.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
          stalePeriod: const Duration(days: 2),
          maxNrOfCacheObjects: 30,
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

    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: appWhiteColor),
          onPressed: () {
            Routemaster.of(context).pop();
          },
        ),
        title: Text(
          notes['name']!,
          style: const TextStyle(color: appWhiteColor),
        ),
        actions: [
          flag == false
              ? IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {
                    addbookmark();
                  })
              : IconButton(
                  icon: const Icon(Icons.bookmark),
                  onPressed: () {
                    // print("{$flag} ${user.bid}");
                    removebookmark();
                  },
                ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
        ],
        centerTitle: false,
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
