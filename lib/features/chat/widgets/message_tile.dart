import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';

Container MessageTile(Size size, Map<String, dynamic> chatMap, DateTime date) {
    return Container(
                            margin: EdgeInsets.only(
                                bottom: size.height * 0.025,
                                left: size.width * 0.04,
                                right: size.width * 0.02),
                            width: size.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 0.1,
                                  height: size.width * 0.1,
                                  decoration: BoxDecoration(
                                    color: Pallete.whiteColor,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          chatMap['senderPhotoUrl']),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.04,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          chatMap['senderName'].split(' ')[0],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.02,
                                        ),
                                        Text(
                                          '${date.toString().split(' ').first} ${date.toString().split(' ')[1].split('.').first}',
                                          style: TextStyle(
                                              color: Pallete.lightGreyColor),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Container(
                                      width: size.width * 0.7,
                                      child: Text(
                                        chatMap['message'],
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
  }
