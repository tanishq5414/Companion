import 'dart:io';

import 'package:companion/core/core.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:companion/common/app_bar.dart';
import 'package:companion/common/common.dart';
import 'package:companion/constants/constants.dart';
import 'package:companion/features/courses/controller/courses_controller.dart';
import 'package:companion/features/notes/controller/notes_controller.dart';
import 'package:companion/features/user/controller/user_controller.dart';
import 'package:companion/theme/pallete.dart';

class AddNotesView extends ConsumerStatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const AddNotesView());
  }

  const AddNotesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddNotesViewState();
}

class _AddNotesViewState extends ConsumerState<AddNotesView> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  bool _isLoading = false;
  bool _userAborted = false;
  final bool _multiPick = false;
  String year = "";
  String branch = "";
  String course = "";
  String semester = "";
  String version = "";
  String unit = "";
  @override
  void initState() {
    super.initState();
  }

  void _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
              withData: true,
              type: FileType.custom,
              allowMultiple: _multiPick,
              // ignore: avoid_print
              onFileLoading: (FilePickerStatus status) =>
                  (kDebugMode) ? print(status) : null,
              allowedExtensions: ['pdf']))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation$e');
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
    });
  }

  void _logException(String message) {
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }

  final nameController = TextEditingController();
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDataProvider);
    final size = MediaQuery.of(context).size;
    final Loading = ref.watch(notesControllerProvider);
    final courselist = ref.watch(coursesDataProvider);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(title: 'Add Notes'),
        body: (Loading)
            ? const Loader()
            : SingleChildScrollView(

                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Enter notes name: ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      CustomTextField(
                        size: size,
                        inputController: nameController,
                        hint: 'Name',
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Select course: ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: size.width * 0.01,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Pallete.whiteColor,
                        ),
                        child: DropdownSearch<String>(
                          onChanged: (value) => course = value!,
                          items: courselist!.map((e) => e.cname!).toList(),
                          popupProps: PopupPropsMultiSelection.modalBottomSheet(
                            searchFieldProps: const TextFieldProps(
                              cursorColor: Pallete.whiteColor,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                              style: TextStyle(
                                  color: Pallete.blackColor, fontSize: 16),
                            ),
                            isFilterOnline: true,
                            showSelectedItems: true,
                            showSearchBox: true,
                            itemBuilder: (context, item, isSelected) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(size.width * 0.1,
                                    size.width * 0.05, 0, size.width * 0.05),
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Pallete.blackColor
                                        : Pallete.greyColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Enter branch: ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: size.width * 0.01,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Pallete.whiteColor,
                        ),
                        child: DropdownSearch<String>(
                          onChanged: (value) => branch = value!,
                          items: UIConstants.branchDetails,
                          popupProps: PopupPropsMultiSelection.modalBottomSheet(
                            searchFieldProps: const TextFieldProps(
                              cursorColor: Pallete.whiteColor,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                              style: TextStyle(
                                  color: Pallete.blackColor, fontSize: 16),
                            ),
                            isFilterOnline: true,
                            showSelectedItems: true,
                            showSearchBox: true,
                            itemBuilder: (context, item, isSelected) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(size.width * 0.1,
                                    size.width * 0.05, 0, size.width * 0.05),
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Pallete.blackColor
                                        : Pallete.greyColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Enter unit: ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: size.width * 0.01,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Pallete.whiteColor,
                        ),
                        child: DropdownSearch<String>(
                          onChanged: (value) => unit = value!,
                          items: ['0', '1', '2', '3', '4', '5'],
                          popupProps: PopupPropsMultiSelection.modalBottomSheet(
                            searchFieldProps: const TextFieldProps(
                              cursorColor: Pallete.whiteColor,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                              style: TextStyle(
                                  color: Pallete.blackColor, fontSize: 16),
                            ),
                            isFilterOnline: true,
                            showSelectedItems: true,
                            showSearchBox: true,
                            itemBuilder: (context, item, isSelected) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(size.width * 0.1,
                                    size.width * 0.05, 0, size.width * 0.05),
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Pallete.blackColor
                                        : Pallete.greyColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Enter year: ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: size.width * 0.01,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Pallete.whiteColor,
                        ),
                        child: DropdownSearch<String>(
                          onChanged: (value) => year = value!,
                          items: ['1', '2', '3', '4'],
                          popupProps: PopupPropsMultiSelection.modalBottomSheet(
                            searchFieldProps: const TextFieldProps(
                              cursorColor: Pallete.whiteColor,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                              style: TextStyle(
                                  color: Pallete.blackColor, fontSize: 16),
                            ),
                            isFilterOnline: true,
                            showSelectedItems: true,
                            showSearchBox: true,
                            itemBuilder: (context, item, isSelected) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(size.width * 0.1,
                                    size.width * 0.05, 0, size.width * 0.05),
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Pallete.blackColor
                                        : Pallete.greyColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Enter semester: ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: size.width * 0.01,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Pallete.whiteColor,
                        ),
                        child: DropdownSearch<String>(
                          onChanged: (value) => semester = value!,
                          items: ['1', '2'],
                          popupProps: PopupPropsMultiSelection.modalBottomSheet(
                            searchFieldProps: const TextFieldProps(
                              cursorColor: Pallete.whiteColor,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                              style: TextStyle(
                                  color: Pallete.blackColor, fontSize: 16),
                            ),
                            isFilterOnline: true,
                            showSelectedItems: true,
                            showSearchBox: true,
                            itemBuilder: (context, item, isSelected) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(size.width * 0.1,
                                    size.width * 0.05, 0, size.width * 0.05),
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Pallete.blackColor
                                        : Pallete.greyColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Upload PDF:',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: size.width * 0.01,
                      ),
                      Container(
                        child: TextButton(
                          onPressed: () => _pickFiles(),
                          child: Text('Upload PDF'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Builder(
                        builder: (BuildContext context) => _isLoading
                            ? const Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: CircularProgressIndicator(),
                              )
                            : _userAborted
                                // ignore: prefer_const_constructors
                                ? Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: const Text(
                                      'User has aborted the dialog',
                                      style: TextStyle(
                                        color: Pallete.whiteColor,
                                      ),
                                    ),
                                  )
                                : _directoryPath != null
                                    ? ListTile(
                                        title: const Text(
                                          'Directory path',
                                          style: TextStyle(
                                            color: Pallete.whiteColor,
                                          ),
                                        ),
                                        subtitle: Text(_directoryPath!),
                                      )
                                    : _paths != null
                                        ? Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 30.0),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                            child: Scrollbar(
                                                child: ListView.separated(
                                              itemCount: _paths != null &&
                                                      _paths!.isNotEmpty
                                                  ? _paths!.length
                                                  : 1,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final bool isMultiPath =
                                                    _paths != null &&
                                                        _paths!.isNotEmpty;
                                                final String name =
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    'File name: ' +
                                                        (isMultiPath
                                                            ? _paths!
                                                                .map((e) =>
                                                                    e.name)
                                                                .toList()[index]
                                                            : _fileName ??
                                                                '...');
                                                final path = kIsWeb
                                                    ? null
                                                    : _paths!
                                                        .map((e) => e.path)
                                                        .toList()[index]
                                                        .toString();

                                                return ListTile(
                                                  title: Text(
                                                    name,
                                                    style: TextStyle(
                                                      color: Pallete.whiteColor,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    path ?? '',
                                                    style: TextStyle(
                                                      color: Pallete.whiteColor,
                                                    ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      const Divider(),
                                            )),
                                          )
                                        : _saveAsFileName != null
                                            ? ListTile(
                                                title: const Text('Save file'),
                                                subtitle:
                                                    Text(_saveAsFileName!),
                                              )
                                            : const SizedBox(),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (nameController.text == "" ||
                              branch == "" ||
                              course == "" ||
                              semester == "" ||
                              year == "" ||
                              unit == "" ||
                              _paths == null) {
                            showSnackBar(context, "Please fill all the fields");
                            return;
                          }
                          File file = File(_paths!
                              .map((e) => e.path)
                              .toList()[0]
                              .toString());
                          await ref
                              .read(notesControllerProvider.notifier)
                              .uploadNotes(
                                name: nameController.text,
                                branch: branch,
                                course: course,
                                semester: semester,
                                unit: unit,
                                year: year,
                                pdf: file,
                                version: "1",
                                author: user!.name!,
                                authorId: user.uid!,
                                context: context,
                              );
                          ref
                              .read(userControllerProvider.notifier)
                              .updateContributed(
                                  context, nameController.text, course);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(size.width, size.height * 0.1),
                          backgroundColor: Pallete.whiteColor,
                        ),
                        child: const Text(
                          'Add Notes',
                          style: TextStyle(color: Pallete.blackColor),
                        ),
                      ),
                      SizedBox(height: size.height * 0.1)
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

@immutable
class CustomTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var obscureText;
  var hint;
  var inputformatters;
  CustomTextField({
    Key? key,
    required this.size,
    required this.inputController,
    this.inputformatters,
    this.hint,
    this.obscureText = false,
  }) : super(key: key);

  final Size size;
  final Color inputTextColor = Pallete.blackColor;
  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        height: size.height * 0.06,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Pallete.whiteColor),
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.03),
            child: Center(
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                cursorColor: Colors.black,
                // cursorHeight: size.height * 0.03,
                controller: inputController,
                inputFormatters: inputformatters,
                obscureText: obscureText,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  fillColor: inputTextColor,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
