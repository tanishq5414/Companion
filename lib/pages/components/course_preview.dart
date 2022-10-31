import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:notesapp/config/colors.dart';

class CoursePreview extends StatefulWidget {
  CoursePreview(this.size, this.courseName, this.imageUrl, {super.key});
  late Size size;
  late String courseName;
  late String imageUrl;

  @override
  State<CoursePreview> createState() => _CoursePreviewState();
}

class _CoursePreviewState extends State<CoursePreview> {
  @override
  Widget build(BuildContext context) {
    // final appAccentColor = Theme.of(context).accentColor;
    return Padding(
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
                  border: Border.all(color: Colors.white.withOpacity(0.4)),
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
                      child: Padding(
                        padding: EdgeInsets.only(left: widget.size.width * 0.03),
                        child: SizedBox(
                          // height: widget.size.height * 0.3,
                          width: widget.size.width * 0.7,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              fixedSize: Size(
                                  widget.size.width, widget.size.height * 0.1),
                              backgroundColor: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/courseview');
                            },
                            child: Container(
                              color: Colors.transparent,
                              width: widget.size.width * 0.45,
                              height: widget.size.height * 0.02,
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
                    ),
                    Container(
                      height: widget.size.height * 0.0008,
                      color: appAccentColor,
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
