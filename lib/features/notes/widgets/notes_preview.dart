import 'package:companion/constants/constants.dart';
import 'package:companion/features/hive/boxes.dart';
import 'package:companion/features/notes/views/notes_menu.dart';
import 'package:companion/features/notes/views/notes_pdf_view.dart';
import 'package:companion/modal/notes.modal.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class NotesPreview extends StatelessWidget {
  const NotesPreview({
    super.key,
    required this.size,
    this.disableonTap = false,
    required this.notes,
  });

  final Size size;
  final NotesModal notes;
  final bool disableonTap;

  @override
  Widget build(BuildContext context) {
    var millis = notes.createdAt;
    int getSingleDigitNumber(String number) {
      return int.parse(number.characters.last);
    }

    int index = getSingleDigitNumber(millis ?? '978296400000');
    var date = DateTime.fromMillisecondsSinceEpoch(
        int.parse(millis ?? '978296400000'));
    var d12 = DateFormat('dd/MM/yyyy').format(date);
    Color color = UIConstants.lightColors[index];
    Color darkColor = UIConstants.darkColors[index];
    return ZoomTapAnimation(
      onTap: () {
        if (disableonTap) {
          return;
        }
        recentlyAccessedBox.add(
            [notes.fileId!, DateTime.now().millisecondsSinceEpoch.toString()]);
        trendingBox.add(notes.fileId!);
        Navigator.push(context, NotesPdfView.route(notes: notes));
      },
      onLongTap: () {
        if (disableonTap) {
          return;
        }
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false, // set to false
            pageBuilder: (_, __, ___) => NotesMenu(
              notes: notes,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        margin:
            EdgeInsets.only(right: size.width * 0.03, top: size.width * 0.03),
        height: size.width * 0.44,
        width: size.width * 0.42,
        color: darkColor,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              size.width * 0.03, size.width * 0.03, size.width * 0.03, 0),
          child: Column(
            children: [
              Container(
                height: size.width * 0.35,
                color: color,
                child: Padding(
                  padding: EdgeInsets.only(left: size.width * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      SizedBox(
                        width: size.width * 0.4,
                        height: size.width * 0.17,
                        child: Text(
                          notes.name ?? 'Notes name',
                          style: TextStyle(
                              color: Pallete.whiteColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        child: Text(
                          notes.course ?? 'Course name',
                          style: TextStyle(
                              color: Pallete.whiteColor, fontSize: 10),
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.01,
                      ),
                      Text(
                        '${notes.unit ?? '0'} Unit',
                        style:
                            TextStyle(color: Pallete.whiteColor, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.width * 0.02),
                child: SizedBox(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          notes.author ?? 'Author Name',
                          style: TextStyle(
                              color: Pallete.whiteColor, fontSize: 10),
                        ),
                        Text(
                          d12,
                          style: TextStyle(
                              color: Pallete.whiteColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 10),
                        ),
                      ],
                    ),
                    Text(notes.branch ?? 'Branch name',
                        style:
                            TextStyle(color: Pallete.whiteColor, fontSize: 10)),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
