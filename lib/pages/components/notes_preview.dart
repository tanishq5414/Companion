import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:notesapp/config/colors.dart';

class NotesPreview extends StatefulWidget {
  const NotesPreview(
      {super.key,
      required this.name,
      required this.year,
      required this.branch,
      required this.course,
      required this.semester,
      required this.version,
      required this.unit,
      required this.wdlink});
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
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.015,
          bottom: size.height * 0.007,
          right: size.width * 0.015),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Container(
          width: size.width * 0.43,
          height: size.width * 0.43,
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(
                  //sigmaX is the Horizontal blur
                  sigmaX: 4.0,
                  //sigmaY is the Vertical blur
                  sigmaY: 4.0,
                ),
                //we use this container to scale up the blur effect to fit its
                //  parent, without this container the blur effect doesn't appear.
                child: Container(),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white.withOpacity(0.4), width: 0.7),
                  // border: Border.all(color: Colors.white.withOpacity(0.13)),
                  borderRadius: BorderRadius.circular(4),

                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        //begin color
                        Colors.black.withOpacity(0.05),
                        //end color
                        Colors.white.withOpacity(0.07),
                      ]),
                ),
              ),
              //gradient effect ==> the second layer of stack

              Container(
                width: size.width * 0.34,
                height: size.width * 0.34,
                color: Colors.transparent,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Flexible(
                      child: TextButton(
                        style: ElevatedButton.styleFrom(
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
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    child: Text(widget.course,
                                        maxLines: 3,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: appWhiteColor)),
                                  ),
                                  Text(widget.unit,
                                      style: const TextStyle(
                                          fontSize: 12, color: appWhiteColor)),
                                  Text(widget.name,
                                      style: const TextStyle(
                                          fontSize: 11, color: appAccentColor)),
                                ]),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.009,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
