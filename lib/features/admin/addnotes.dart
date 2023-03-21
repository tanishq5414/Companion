// ignore_for_file: unused_field

import 'dart:convert';
import 'dart:io';

import 'package:companion_rebuild/features/admin/modal/file_modal.dart';
import 'package:companion_rebuild/core/keys/server_api_urls.dart';
import 'package:companion_rebuild/features/auth/controller/auth_controller.dart';
import 'package:companion_rebuild/theme/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../components/custom_appbar.dart';
import 'package:http/http.dart' as http;

class AddNotes extends ConsumerStatefulWidget {
  const AddNotes({super.key});

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends ConsumerState<AddNotes> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  bool _isLoading = false;
  bool _userAborted = false;
  final bool _multiPick = false;
  final FileType _pickingType = FileType.any;
  final TextEditingController _controller = TextEditingController();

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
              onFileLoading: (FilePickerStatus status) => print(status),
              allowedExtensions: ['pdf']))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = ref.read(userProvider)!;
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      home: Scaffold(
        backgroundColor: appBackgroundColor,
        key: _scaffoldKey,
        appBar: CustomAppBar(
          title: 'Add Notes',
        ),
        body: (user.isAdmin)
            ? Padding(
                padding: EdgeInsets.only(left: size.width * 0.05),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                        child: Column(
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: appWhiteColor,
                                minimumSize:
                                    Size(size.width * 0.9, size.height * 0.3),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () => _pickFiles(),
                              child: const Icon(
                                OctIcons.plus_16,
                                color: appGreyColor,
                                size: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                            // HttpClient().connectionTimeout = Duration(seconds: 20);
                          if (_paths != null) {
                            String? fileName =
                                _paths!.map((e) => e.name).toString();
                            String? filePath =
                                _paths!.map((e) => e.path).toString();
                            late File file;
                            int index = filePath.lastIndexOf('/');
                            fileName =
                                fileName.substring(1, fileName.length - 1);
                            filePath = filePath.substring(1, index);
                            var t = _paths!.map((e) => e.bytes).first!;
                            FilePicker.platform.clearTemporaryFiles();
                            var upfile;
                            if (_paths != null) {
                              var upfile = _paths!.first.bytes;
                            }
                            var request = http.MultipartRequest(
                                'POST', Uri.parse(singleFileUpload));
                          // request.persistentConnection = false;
                            request.files.add(
                              http.MultipartFile.fromBytes('pdf', t,
                                  filename: fileName),
                            );
                            print('request: $request');
                            http.StreamedResponse res = await request.send();
                            print('res: ${res.statusCode}');
                            print(fileName.characters.length);
                            var body = jsonEncode({
                              "filename": fileName,
                              "filepath": "./pdfStorage",
                            });
                            // print('map: $map');
                            http.Response request2 =
                                await http.post(Uri.parse(addFiletoGoogleDrive),
                                    headers: <String, String>{
                                      'Content-Type':
                                          'application/json; charset=UTF-8',
                                    },
                                    body: body);

                            print('request2: ${request2.body}');
                            if (request2.statusCode == 200 && res.statusCode == 200) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('File Uploaded'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('File Not Uploaded'),
                                ),
                              );
                            }
                            var fileId = jsonDecode(request2.body)['fileId'];
                            var webContentLink =
                                jsonDecode(request2.body)['webContentLink'];
                            Routemaster.of(context).push('/addnotesdata',
                                queryParameters: {
                                  'fileId': fileId,
                                  'webContentLink': webContentLink,
                                  'fileName': fileName,
                                });
                            
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Please select a file'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(size.width * 0.9, size.height * 0.1),
                          backgroundColor: appGreyColor,
                        ),
                        child: const Text(
                          'Add Details',
                          style: TextStyle(color: appBlackColor),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
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
                                    ),
                                  )
                                : _directoryPath != null
                                    ? ListTile(
                                        title: const Text(
                                          'Directory path',
                                          style: TextStyle(
                                            color: appWhiteColor,
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
                                                0.50,
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
                                                      color: appAccentColor,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    path ?? '',
                                                    style: TextStyle(
                                                      color: appWhiteColor,
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
                    ],
                  ),
                ),
              )
            : const Center(
                child: Text(
                  'You are not authorized to access this page',
                  style: TextStyle(color: appWhiteColor),
                ),
              ),
      ),
    );
  }
}
