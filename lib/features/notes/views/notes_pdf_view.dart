import 'dart:io';

import 'package:companion/modal/notes.modal.dart';
import 'package:companion/theme/pallete.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path_provider/path_provider.dart';

class NotesPdfView extends StatefulWidget {
  static Route route({required NotesModal notes}) {
    return MaterialPageRoute<void>(
      builder: (_) => NotesPdfView(notes: notes),
    );
  }

  final NotesModal notes;
  const NotesPdfView({super.key, required this.notes});

  @override
  State<NotesPdfView> createState() => _NotesPdfViewState();
}

class _NotesPdfViewState extends State<NotesPdfView> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late Directory tempDir;
  late bool _canShowPdf;
  late String tempPath;

  void initState() {
    _canShowPdf = false;
    super.initState();
    fileDownload();
  }

  late int percentage = 0, totalFileSize;

  // redownload file
  Future<void> filereDownload() async {
    if (await File(tempPath).exists()) {
      await File(tempPath).delete();
    }
    fileDownload();
  }

  Future<void> fileDownload() async {
    tempDir = await getTemporaryDirectory();
    //download file
    tempPath = tempDir.path + "/" + widget.notes.fileId!;

    final dio = Dio();

    if (await File(tempPath).exists()) {
      if (await File(tempPath).length() == 0) {
        dio.download(
          widget.notes.reslink!,
          tempPath,
          deleteOnError: true,
          onReceiveProgress: (count, total) {
            if (context.mounted) {
              setState(() {
                percentage = ((count / total) * 100).floor();
              });
            }
          }
        );
      } else {
        this.setState(() {
          percentage = 100;
        });
      }
    } else {
      dio.download(
        widget.notes.reslink!,
        tempPath,
        onReceiveProgress: (count, total) {
          if (context.mounted) {
            setState(() {
              percentage = ((count / total) * 100).floor();
            });
            percentage = ((count / total) * 100).floor();
            totalFileSize = total;
          }
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.notes.name!,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
      ),
      body: percentage == 100
          ? FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 200)).then((value) {
                _canShowPdf = true;
              }),
              builder: (context, snapshot) {
                if (_canShowPdf) {
                  return SfPdfViewer.file(
                    File(tempPath),
                    onDocumentLoadFailed: (details) {
                      filereDownload();
                    },
                  );
                } else {
                  return Container();
                }
              })
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: LinearProgressIndicator(
                      backgroundColor: Pallete.greyColor,
                      value: percentage.toDouble() / 100,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  Text(
                    (percentage.toDouble()).toString() + " %",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: Colors.white),
                  ),
                  Text("Please wait file downloading",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.white))
                ],
              ),
            ),
    );
  }
}
