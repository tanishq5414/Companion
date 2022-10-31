import 'package:flutter/material.dart';

import 'package:notesapp/config/colors.dart';
import 'package:notesapp/domain/user_modal.dart';
import 'package:notesapp/pages/components/custom_appbar.dart';
import 'package:notesapp/provider/firestore_methods.dart';
import 'package:notesapp/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../domain/courses_modal.dart';
import '../../provider/firebase_auth_methods.dart';
import '../../provider/get_courses.dart';

class CourseListFilterPage extends StatefulWidget {
  const CourseListFilterPage({super.key});

  @override
  State<CourseListFilterPage> createState() => _CourseListFilterPageState();
}

class _CourseListFilterPageState extends State<CourseListFilterPage> {
  late UserCollection user;
  @override
  // void initState() {
  //   super.initState();
  //   user = Provider.of<UserProvider>(context).getUser;
  // }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context).getUser;
    var size = MediaQuery.of(context).size;
    // print(user.cid);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Course List Filter',
      ),
      body: Stack(
        children: [
          FutureBuilder<List<Course>>(
            future: GetCourses.getCourses(),
            builder: (
              context,
              snapshot,
            ) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      activeColor: appWhiteColor,
                      checkColor: appWhiteColor,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                      title: Text(
                        snapshot.data![index].cname,
                        style: const TextStyle(color: appWhiteColor),
                      ),
                      value: user.cid.contains(snapshot.data![index].cid),
                      // value: true,
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true &&
                              user.cid.contains(snapshot.data![index].cid) ==
                                  false &&
                              user.cid.length < 6) {
                            user.cid.add(snapshot.data![index].cid);
                          } else {
                            user.cid.remove(snapshot.data![index].cid);
                          }
                          print(user.cid);
                        });
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            },
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              height: size.height * 0.1,
              color: appBackgroundColor,
              child: Padding(
                padding: EdgeInsets.only(left: size.width * 0.05),
                child: Container(
                  width: size.width,
                  height: size.height * 0.1,
                  color: appBackgroundColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${user.cid.length.toString()}/6 selected',
                          style: const TextStyle(
                              color: appWhiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: appBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Provider.of<FirestoreMethods>(context, listen: true)
                              .updateUserCourses(user.id, user.cid);
                          Provider.of<UserProvider>(context, listen: true)
                              .refreshUser();
                          // Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home', (route) => false);
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(color: appAccentColor, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
