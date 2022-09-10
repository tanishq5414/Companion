import 'package:flutter/material.dart';

Container NotesPreview(Size size) {
  return Container(
    width: size.width * 0.34,
    child: Column(
      children: [
        TextButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            onPrimary: Colors.grey,
            primary: Colors.white,
          ),
          onPressed: () {},
          child: SizedBox(
            width: size.width * 0.34,
            height: size.width * 0.34,
            child: Column(
              children: [
                Container(
                  width: size.width * 0.34,
                  height: size.width * 0.34,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/pictures/black.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Unit 5',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text('v4.0',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
          ],
        ),
        SizedBox(
          height: size.height * 0.007,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              'Data Mining',
              style: TextStyle(fontSize: 11, color: Colors.black),
              overflow: TextOverflow.fade,
            ),
          ],
        ),
      ],
    ),
  );
}
