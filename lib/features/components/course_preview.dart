// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:companion_rebuild/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CoursePreview extends StatefulWidget {
  CoursePreview(this.size, this.courseName, this.cid, {super.key});
  late Size size;
  late String courseName;
  late String cid;

  @override
  State<CoursePreview> createState() => _CoursePreviewState();
}

class _CoursePreviewState extends State<CoursePreview> {
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      child: Padding(
        padding: EdgeInsets.only(
            left: widget.size.width * 0.015,
            bottom: widget.size.height * 0.005,
            right: widget.size.width * 0.015),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: SizedBox(
            width: widget.size.width * 0.45,
            height: widget.size.height * 0.9,
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
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.4), width: 2),
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

                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          // height: widget.size.height * 0.3,
                          width: widget.size.width * 0.7,
                          child: ElevatedButton(                      
                            style: ElevatedButton.styleFrom(
                              splashFactory: NoSplash.splashFactory,
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              fixedSize: Size(
                                  widget.size.width, widget.size.height * 0.1),
                              backgroundColor: Colors.white.withOpacity(0.05),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                              ),
                            ),
                            onPressed: () {
                              Routemaster.of(context)
                                  .push('/courseview', queryParameters: {
                                'id': widget.cid.toString(),
                                'name': widget.courseName,
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: widget.size.width * 0.035,
                                  top: widget.size.height * 0.01,
                                  right: widget.size.width * 0.01,
                                  bottom: widget.size.height * 0.01),
                              // color: Colors.transparent,
                              width: widget.size.width * 0.45,
                              // height: widget.size.height * 0.02,
                              child: Text(
                                widget.courseName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: widget.size.height * 0.001,
                        color: appAccentColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
