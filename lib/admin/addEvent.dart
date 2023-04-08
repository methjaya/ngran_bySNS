import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:path/path.dart' as path;

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  DateTime dateTime = DateTime.now();
  bool isSelected = false;
  final _formKey = GlobalKey<FormState>();
  PlatformFile? _selectedFile;
  bool isUploaded = false;
  bool isReady = true;

  var Ename;
  var Edate;
  var Elocation;
  var Edescription;
  var Eimg;

  void _addEventSubmit() {
    final isValidAEForm = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValidAEForm) {
      _formKey.currentState!.save();

      FirebaseFirestore.instance.collection("events").doc().set({
        "name": Ename,
        "date": Edate,
        "location": Elocation,
        "description": Edescription,
        "eventExpire": Timestamp.fromDate(dateTime),
        "img": Eimg
      }).onError((e, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error Writing to Firebase ${e.toString()}'),
            duration: const Duration(seconds: 1),
          ),
        );
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Record Added'),
            duration: Duration(seconds: 1),
          ),
        );
      });
    }

    print(Ename);
    print(Edate);
    print(Elocation);
    print(Edescription);
  }

  Future fileSelecter() async {
    final selectedResult = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png']);

    if (selectedResult == null) {
      return;
    }

    setState(
      () {
        _selectedFile = selectedResult.files.first;
      },
    );
    print(_selectedFile!.path);
  }

  //

  Future<String> uploadFileToFilestack() async {
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select the image first '),
          duration: Duration(seconds: 1),
        ),
      );
      return "";
    }
    isUploaded = false;
    String fileExtensionType =
        path.extension(_selectedFile!.path!).replaceAll('.', '');

    print("EXTENSION : $fileExtensionType");

    if ((fileExtensionType == "jpeg" ||
            fileExtensionType == "jpg" ||
            fileExtensionType == "png") &&
        _selectedFile != null) {
      List<int> imageBytes = await File(_selectedFile!.path!).readAsBytes();

      print("passed extension check");

      // Send the binary data to Filestack API
      final response = await http.post(
          Uri.parse(
              'https://www.filestackapi.com/api/store/S3?key=AgQ54ULwmQrOkb0OkzeVYz'),
          headers: {
            'Content-Type': 'image/$fileExtensionType',
          },
          body: imageBytes);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Uploading Image'),
          duration: Duration(seconds: 1),
        ),
      );

      // Check the response and return the download URL
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image uploaded successfully'),
            duration: Duration(seconds: 1),
          ),
        );
        final responseData = json.decode(response.body);
        setState(() {
          isUploaded = true;
        });
        return responseData['url'];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Failed to upload file to CDN: ${response.statusCode}'),
            duration: const Duration(seconds: 1),
          ),
        );
        throw Exception(
            'Failed to upload file to Filestack: ${response.statusCode}');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid File Type'),
          duration: Duration(seconds: 1),
        ),
      );
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    return Scaffold(
      body: Card(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              TextFormField(
                key: const ValueKey("name"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Name cannot be empty";
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  Ename = newValue!;
                },
                decoration: const InputDecoration(
                  labelText: 'Event Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                key: const ValueKey("date"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Date cannot be empty";
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  Edate = newValue!;
                },
                decoration: const InputDecoration(
                  labelText: 'Event Date',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                key: const ValueKey("location"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Location cannot be empty";
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  Elocation = newValue!;
                },
                decoration: const InputDecoration(
                  labelText: 'Event Location',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                key: const ValueKey("description"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Description cannot be empty";
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  Edescription = newValue!;
                },
                decoration: const InputDecoration(
                  labelText: 'Event Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.all(14),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "DateTime Picker",
                        style: TextStyle(fontSize: 28),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              child: Builder(
                                builder: (context) {
                                  return Text(isSelected
                                      ? '${dateTime.year}/${dateTime.month}/${dateTime.day}'
                                      : "");
                                },
                              ),
                              onPressed: () async {
                                final date = await datePick();

                                if (date == null) return;

                                final dateTimeNew = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    dateTime.hour,
                                    dateTime.minute);

                                print(dateTime);

                                setState(
                                  () {
                                    isSelected = true;
                                    dateTime = dateTimeNew;
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              child: Text('$hours : $minutes'),
                              onPressed: () async {
                                final time = await timePick();

                                if (time == null) return;

                                final dateTimeNew = DateTime(
                                    dateTime.year,
                                    dateTime.month,
                                    dateTime.day,
                                    time.hour,
                                    time.minute);

                                print(dateTime);

                                setState(() {
                                  dateTime = dateTimeNew;
                                });

                                print(dateTime);
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_selectedFile != null)
                      Container(
                        color: Colors.green[50],
                        child: Image.file(
                          File(_selectedFile!.path!),
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ElevatedButton(
                      child: const Text("Select Image"),
                      onPressed: () async {
                        fileSelecter();
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (isUploaded != true) {
                          if (isReady == true) {
                            isReady = false;
                            Eimg = await uploadFileToFilestack();
                          }
                        } else {
                          _addEventSubmit();
                          setState(() {
                            isUploaded = false;
                            isReady = true;
                          });
                        }
                      },
                      child: Text(isUploaded ? "Add Record" : "Upload Image"),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> datePick() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2015),
      lastDate: DateTime(2100));

  Future<TimeOfDay?> timePick() =>
      showTimePicker(context: context, initialTime: TimeOfDay.now());
}
