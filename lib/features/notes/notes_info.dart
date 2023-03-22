import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:routemaster/routemaster.dart';

import '../../theme/colors.dart';
import '../components/notes_preview.dart';

class NotesInfo extends StatelessWidget {
  const NotesInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var notes = RouteData.of(context).queryParameters;
    return SafeArea(
      child: Scaffold(
        body: InkWell(
          onTap: () => Routemaster.of(context).history.back(),
          child: Container(
            width: size.width,
            height: size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                NotesPreview(
                            id: notes['id']!,
                            name: notes['name']!,
                            year: notes['year']!,
                            branch: notes['branch']!,
                            course: notes['course']!,
                            semester: notes['semester']!,
                            version: notes['version']!,
                            unit: notes['unit']!,
                            wdlink: notes['wdlink']!,
                            pressable: false,
                          ),
                SizedBox(height: size.height * 0.04,),
                Padding(
                  padding: EdgeInsets.only(top: size.width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Name: ', style: TextStyle(color: appAccentColor),),
                      Text(notes['name']!, style: const TextStyle(color: appWhiteColor),),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Branch: ', style: TextStyle(color: appAccentColor),),
                      Text(notes['branch']!, style: const TextStyle(color: appWhiteColor),),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Course: ', style: TextStyle(color: appAccentColor),),
                      Text(notes['course']!, style: const TextStyle(color: appWhiteColor),),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Unit: ', style: TextStyle(color: appAccentColor),),
                      Text(notes['unit']!, style: const TextStyle(color: appWhiteColor),),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Semester: ', style: TextStyle(color: appAccentColor),),
                      Text(notes['semester']!, style: const TextStyle(color: appWhiteColor),),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Year: ', style: TextStyle(color: appAccentColor),),
                      Text(notes['year']!, style: const TextStyle(color: appWhiteColor),),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Version: ', style: TextStyle(color: appAccentColor),),
                      Text(notes['version']!, style: const TextStyle(color: appWhiteColor),),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.04,),
              ],),
            ),
          ),
        )
      ),
    );
  }
}
