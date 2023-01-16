import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/features/auth/controller/auth_controller.dart';
import 'package:routemaster/routemaster.dart';

import 'package:notesapp/theme/colors.dart';

class NotesPreview extends ConsumerStatefulWidget {
  const NotesPreview(
      {super.key,
      required this.id,
      required this.name,
      required this.year,
      required this.branch,
      required this.course,
      required this.semester,
      required this.version,
      required this.unit,
      required this.wdlink});
  final String id;
  final String name;
  final String year;
  final String branch;
  final String course;
  final String semester;
  final String version;
  final String unit;
  final String wdlink;
  @override
  ConsumerState<NotesPreview> createState() => _NotesPreviewState();
}

class _NotesPreviewState extends ConsumerState<NotesPreview> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = ref.read(userProvider)!;
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.015,
          bottom: size.height * 0.007,
          right: size.width * 0.015),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: SizedBox(
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
                width: size.width * 0.43,
                height: size.width * 0.43,
                color: Colors.transparent,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        ref
                            .read(authControllerProvider.notifier)
                            .incrementNotesOpened(
                                context, user.id, widget.id.toString(), widget.name, widget.course, widget.unit,);
                        
                        Routemaster.of(context)
                            .push('/pdfview', queryParameters: {
                          'id': widget.id.toString(),
                          'name': widget.name,
                          'year': widget.year,
                          'branch': widget.branch,
                          'course': widget.course,
                          'semester': widget.semester,
                          'version': widget.version,
                          'unit': widget.unit,
                          'wdlink': widget.wdlink,
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.width * 0.04,
                            ),
                            SizedBox(
                              width: size.width * 0.34,
                              height: size.width * 0.2,
                              child: Text(widget.course,
                                  maxLines: 3,
                                  style: const TextStyle(
                                      overflow: TextOverflow.clip,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: appBackgroundColor,
                                      fontSize: 18,
                                      color: appWhiteColor)),
                            ),
                            SizedBox(
                              height: size.width * 0.02,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.34,
                                    height: size.width * 0.06,
                                    child: Text(
                                      widget.unit,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: appWhiteColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.34,
                                    height: size.width * 0.06,
                                    child: Text(
                                      widget.name,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: appAccentColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
