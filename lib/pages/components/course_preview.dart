import 'package:flutter/material.dart';

class coursePreview extends StatefulWidget {
  coursePreview(this.size, this.courseName, this.imageUrl, {super.key});
  late Size size;
  late String courseName;
  late String imageUrl;

  @override
  State<coursePreview> createState() => _coursePreviewState();
}

class _coursePreviewState extends State<coursePreview> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: widget.size.width * 0.015,
          bottom: widget.size.height * 0.007,
          right: widget.size.width * 0.015),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.zero,
          backgroundColor: Colors.white,
          padding: EdgeInsets.zero,
          fixedSize: Size(widget.size.width * 0.34, widget.size.height * 0.2),
          side: const BorderSide(color: Colors.grey, width: 1),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        onPressed: () {
          print('pressed');
        },
        child: SizedBox(
          width: widget.size.width / 2.1,
          height: widget.size.height * 0.03,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: widget.size.width * 0.03,
              ),
              Flexible(
                child: Text(
                  widget.courseName,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: widget.size.width * 0.13,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
