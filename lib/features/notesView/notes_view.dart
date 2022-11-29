import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../theme/colors.dart';

/// Represents Homepage for Navigation
class NotesViewPage extends StatelessWidget {
  const NotesViewPage({super.key});
  @override
  Widget build(BuildContext context) {
    //get arguments from previous page
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: appWhiteColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          args['name'],
          style: const TextStyle(color: appWhiteColor),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(size.width * 0.1),
          child:  Padding(
            padding: EdgeInsets.all(size.width * 0.03),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(args['unit'],
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: appWhiteColor)),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  Text(args['course'],
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: appAccentColor)),
                ]),
          ),
        ),
      ),
      body: SizedBox(
        // height: size.height * 0.8,
        child: SfPdfViewer.network(
          args['wdlink'],
        ),
      ),
    );
  }
}
