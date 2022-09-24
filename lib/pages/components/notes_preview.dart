import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:notesapp/config/colors.dart';

class NotesPreview extends StatefulWidget {
  const NotesPreview(
      {super.key,
      required this.index,
      required this.name,
      required this.year,
      required this.branch,
      required this.course,
      required this.semester,
      required this.version,
      required this.unit,
      required this.wdlink});
  final index;
  final String name;
  final String year;
  final String branch;
  final String course;
  final String semester;
  final String version;
  final String unit;
  final String wdlink;
  @override
  State<NotesPreview> createState() => _NotesPreviewState();
}

class _NotesPreviewState extends State<NotesPreview> {
  List colors = [
    Color.fromARGB(221, 0, 0, 75),
    Color.fromARGB(255, 18, 21, 81),
    appGreyColor
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.001,
        ),
        Container(
          width: size.width * 0.34,
          height: size.height * 0.34,
          child: TextButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.grey, backgroundColor: appWhiteColor, minimumSize: Size.zero,
              padding: EdgeInsets.zero,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/pdfview', arguments: {
                'name': widget.name,
                'course': widget.course,
                'version': widget.version,
                'unit': widget.unit,
                'wdlink': widget.wdlink,
              });
            },
            child: SizedBox(
              width: size.width * 0.34,
              height: size.width * 0.34,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.grey.shade200.withOpacity(0.5)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        gradient: LinearGradient(
                          colors: [
                            colors[Random().nextInt(3)],
                            colors[Random().nextInt(3)],
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.02, right: size.width * 0.03),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: Text(widget.course,
                                    maxLines: 3,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: appWhiteColor)),
                              ),
                              Text(widget.unit,
                                  style: const TextStyle(
                                      fontSize: 12, color: appWhiteColor)),
                              Text(widget.name,
                                  style: const TextStyle(
                                      fontSize: 10, color: appWhiteColor)),
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.02,
        ),
      ],
    );
  }
}
