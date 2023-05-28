import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Book extends StatefulWidget {
  final int index;
  // ignore: public_member_api_docs
  Book(this.index);

  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  late Directory tempDir;
  late bool _canShowPdf;
  late String tempPath;

  List booklist = [
    'https://rongdhonustudio.com/islamic_books/Tafsir_Ibn_Katheer/Tafseer-Ibn-Kathir-01.pdf',
    'https://rongdhonustudio.com/islamic_books/Tafsir_Ibn_Katheer/Tafseer-Ibn-Kathir-02.pdf',
    'https://rongdhonustudio.com/islamic_books/Tafsir_Ibn_Katheer/Tafseer-Ibn-Kathir-03.pdf',
    'https://rongdhonustudio.com/islamic_books/Tafsir_Ibn_Katheer/Tafseer-Ibn-Kathir-04.pdf',
  ];

  @override
  void initState() {
    _canShowPdf = false;
    super.initState();
    fileDownload();
  }

  late int percentage = 0, totalFileSize;

  Future<void> fileDownload() async {
    tempDir = await getTemporaryDirectory();
    //download file
    tempPath = tempDir.path + "/" + booklist[widget.index];

    final dio = Dio();

    if (await File(tempPath).exists()) {
      if (await File(tempPath).length() == 0) {
        dio.download(
          booklist[widget.index],
          tempPath,
          onReceiveProgress: (count, total) {
            this.setState(() {
              percentage = ((count / total) * 100).floor();
            });
          },
        );
      } else {
        this.setState(() {
          percentage = 100;
        });
      }
    } else {
      dio.download(
        booklist[widget.index],
        tempPath,
        onReceiveProgress: (count, total) {
          this.setState(() {
            percentage = ((count / total) * 100).floor();
          });
          percentage = ((count / total) * 100).floor();
          totalFileSize = total;
        },
      );
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Syncfusion Flutter PDF Viewer'),
      ),
      body: percentage == 100
          ? FutureBuilder(
          future: Future.delayed(Duration(milliseconds: 200)).then((value) {
            _canShowPdf = true;
          }),
          builder: (context, snapshot) {
            if (_canShowPdf) {
              return  SfPdfViewer.file(
                File(tempPath),
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
                backgroundColor: Colors.white,
                value: percentage.toDouble() / 100,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            ),
            Text(
              (percentage.toDouble()).toString() + " %",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            Text("Please wait file downloading",
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 23))
          ],
        ),
      ),
    );
  }
}