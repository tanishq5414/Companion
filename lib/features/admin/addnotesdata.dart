import 'dart:convert';

import 'package:companion_rebuild/core/provider/courses_provider.dart';
import 'package:companion_rebuild/core/keys/server_api_urls.dart';
import 'package:companion_rebuild/features/auth/components/text_field.dart';
import 'package:companion_rebuild/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;

import '../components/custom_appbar.dart';

class AddNotesDetails extends ConsumerStatefulWidget {
  const AddNotesDetails({super.key});

  @override
  ConsumerState<AddNotesDetails> createState() => _AddNotesDetailsState();
}

class _AddNotesDetailsState extends ConsumerState<AddNotesDetails> {
  final name = TextEditingController();
  final semester = TextEditingController();
  final version = TextEditingController();
  final unit = TextEditingController();
  String branch = "";
  String year = '1';
  String course = "";

  @override
  Widget build(BuildContext context) {
    // get args routemaster
    var args = Routemaster.of(context).currentRoute.queryParameters;
    var courselist = ref.read(coursesDataProvider);

    var fileId = args['fileId'];
    var webContentLink = args['webContentLink'];
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add notes details',
      ),
      body: courselist.when(
        data: (courselist) {
          courselist.sort((a, b) => a.cname.compareTo(b.cname));
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05, vertical: size.width * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Enter notes name: '),
                    SizedBox(
                      height: size.width * 0.01,
                    ),
                    CustomTextField(
                      size: size,
                      inputController: name,
                    ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    Text('Branch: '),
                    SizedBox(
                      height: size.width * 0.01,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: appGreyColor,
                      ),
                      child: DropdownSearch<String>(
                        
                        onChanged: (value) => branch = value!,
                        items: const [
                          "CSE",
                          "ECE",
                          "EEE",
                          "MECH",
                          "CIVIL",
                          "IT",
                          "MBA",
                          "MCA",
                          "CSIT",
                          "AIML",
                          "CS-DS",
                          "CSC"
                        ],
                        popupProps: PopupPropsMultiSelection.modalBottomSheet(
                          isFilterOnline: true,
                          showSelectedItems: true,
                          showSearchBox: false,
                          title: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Search for Branch',
                                style: TextStyle(color: Colors.black)),
                          ),
                          itemBuilder: (context, item, isSelected) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0.1, size.width * 0.05, 0, size.width * 0.05),
                              child: Text(
                                item,
                                style: TextStyle(
                                  color: isSelected
                                      ? appAccentColor
                                      : Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    Text('Year: '),
                    SizedBox(
                      height: size.width * 0.01,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: appGreyColor,
                      ),
                      child: DropdownSearch<String>(
                        onChanged: (value) => year = value!,
                        items: const ["1", "2", "3", "4"],
                        popupProps: PopupPropsMultiSelection.modalBottomSheet(
                          
                          isFilterOnline: true,
                          showSelectedItems: true,
                          showSearchBox: false,
                          title: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Year',
                                style: TextStyle(color: Colors.black)),
                          ),
                          itemBuilder: (context, item, isSelected) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0.1, size.width * 0.05, 0, size.width * 0.05),
                              child: Text(
                                item,
                                style: TextStyle(
                                  color: isSelected
                                      ? appAccentColor
                                      : Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    const Text('Course: '),
                    SizedBox(
                      height: size.width * 0.01,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: appGreyColor,
                      ),
                      child: DropdownSearch<String>(
                        onChanged: (value) => course = value!,
                        items: courselist.map((e) => e.cname).toList(),
                        popupProps: PopupPropsMultiSelection.modalBottomSheet(
                          searchFieldProps: const TextFieldProps(
                            cursorColor: appBlackColor,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(color: appBlackColor),
                            ),
                            style: TextStyle(color: appBlackColor, fontSize: 16),
                            
                          ),
                          isFilterOnline: true,
                          showSelectedItems: true,
                          showSearchBox: true,
                          title: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Search for Courses',
                                style: TextStyle(color: Colors.black)),
                          ),
                          itemBuilder: (context, item, isSelected) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0.1, size.width * 0.05, 0, size.width * 0.05),
                              child: Text(
                                item,
                                style: TextStyle(
                                  color:
                                      isSelected ? appAccentColor : Colors.grey,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    Text('Semester: '),
                    SizedBox(
                      height: size.width * 0.01,
                    ),
                    CustomTextField(
                      size: size,
                      inputController: semester,
                      inputformatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    Text('Version: '),
                    SizedBox(
                      height: size.width * 0.01,
                    ),
                    CustomTextField(
                      size: size,
                      inputController: version,
                      inputformatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    Text('Unit: '),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    CustomTextField(
                      size: size,
                      inputController: unit,
                      inputformatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    SizedBox(
                      height: size.width * 0.1,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (name.text.isEmpty ||
                              branch.isEmpty ||
                              course.isEmpty ||
                              semester.text.isEmpty ||
                              version.text.isEmpty ||
                              unit.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill all the fields'),
                              ),
                            );
                            return;
                          }
                          var body = jsonEncode({
                            "g_id": fileId,
                            "name": name.text,
                            "year": '1',
                            "branch": branch,
                            "course": course.trim(),
                            "semester": semester.text,
                            "version": version.text,
                            "unit": unit.text,
                            "wdlink": webContentLink,
                          });
                          http.Response request2 =
                              await http.post(Uri.parse(addFileData),
                                  headers: <String, String>{
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                  },
                                  body: body);
                          Routemaster.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(size.width, size.height * 0.1),
                          backgroundColor: appGreyColor,
                        ),
                        child: const Text(
                          'Add notes details',
                          style: TextStyle(color: appBlackColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) => Placeholder(),
      ),
    );
  }
}
