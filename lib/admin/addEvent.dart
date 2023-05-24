import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
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

  void _showdialog(String txt, BuildContext context, bool type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: type
            ? const Icon(
                size: 80,
                Icons.check_circle_outline_rounded,
                color: Colors.green,
              )
            : const Icon(
                size: 80,
                Icons.error_outline_rounded,
                color: Colors.red,
              ),
        content: Text(
          txt,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              textAlign: TextAlign.center,
              "Close",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

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
        _showdialog(
            "Something Went Wrong With Adding The Event", context, false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error Writing to Firebase ${e.toString()}'),
            duration: const Duration(seconds: 1),
          ),
        );
      }).then((value) {
        _showdialog("Event Added", context, true);
      });
    }

    print(Ename);
    print(Edate);
    print(Elocation);
    print(Edescription);
  }

  Future fileSelecter() async {
    try {
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something Went Wrong With Selecting Image!'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  //

  Future<String> uploadFileToFilestack() async {
    isUploaded = false;
    String fileExtensionType =
        path.extension(_selectedFile!.path!).replaceAll('.', '');

    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
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
    } else {
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
              const Center(
                child: Text("--Add Events--",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                padding: const EdgeInsets.all(14),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Event Expire",
                        style: TextStyle(fontSize: 18, color: Colors.cyan[900]),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyan[900]),
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
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyan[900]),
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
                maxLines: null,
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
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_selectedFile != null)
                      Container(
                        color: Colors.green[50],
                        child: Image.file(
                          File(_selectedFile!.path!),
                          width: double.maxFinite,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[800]),
                      onPressed: () async {
                        fileSelecter();
                      },
                      child: const Text("Select Image"),
                    ),
                    const SizedBox(width: 25),
                    ElevatedButton(
                      onPressed: () async {
                        if (_selectedFile == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select the image first '),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
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
              )
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
