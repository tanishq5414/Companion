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
            child: Container(
              color: Colors.black87,
              child: Padding(
                padding: EdgeInsets.only(left: size.width*0.001,right: size.width*0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Text('Automata Compiler Design',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Text('Unit 1',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white)),
                  
                  Text('imp Questions',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.white)),
                ]),
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
      ],
    ),
  );
}
