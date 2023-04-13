import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import "package:http/http.dart" as http;
import 'package:path/path.dart' as path;

class UpdateEvent extends StatefulWidget {
  const UpdateEvent({
    super.key,
  });

  @override
  State<UpdateEvent> createState() => _UpdateEventState();
}

class _UpdateEventState extends State<UpdateEvent> {
  DateTime dateTime = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  PlatformFile? _selectedFile;
  bool isReady = true;
  bool readyLocal = false;
  bool readyNetwork = false;
  TextEditingController _textEditingController1 =
      TextEditingController(text: "");
  TextEditingController _textEditingController2 =
      TextEditingController(text: "");
  TextEditingController _textEditingController3 =
      TextEditingController(text: "");
  TextEditingController _textEditingController4 =
      TextEditingController(text: "");

  var Ename;
  var Edate;
  var Elocation;
  var Edescription;
  var Eimg;
  late FixedExtentScrollController scrollController;
  String _selectedOption = '';
  List<dynamic> _options = [];
  late QuerySnapshot _querySnapshot;
  int indx = 0;

  @override
  void initState() {
    super.initState();
    _fetchOptions();
    scrollController = FixedExtentScrollController(initialItem: indx);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _updateEventSubmit() async {
    final isValidUEForm = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_selectedFile != null) {
      Eimg = await uploadFileToFilestack();
    } else {
      Eimg = _options[indx]["img"];
    }

    if (isValidUEForm) {
      _formKey.currentState!.save();

      if (Eimg != null && Eimg != "") {
        FirebaseFirestore.instance
            .collection("events")
            .doc(_querySnapshot.docs[indx].id.toString())
            .update({
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
              content: Text('Record Updated'),
              duration: Duration(seconds: 1),
            ),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image is Empty'),
            duration: Duration(seconds: 1),
          ),
        );
      }
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
        readyLocal = true;
        readyNetwork = false;
      },
    );
    print(_selectedFile!.path);
  }

  //

  Future<String> uploadFileToFilestack() async {
    String fileExtensionType =
        path.extension(_selectedFile!.path!).replaceAll('.', '');

    print("EXTENSION : $fileExtensionType");

    if ((fileExtensionType == "jpeg" ||
            fileExtensionType == "jpg" ||
            fileExtensionType == "png") &&
        _selectedFile != null) {
      List<int> imageBytes = await File(_selectedFile!.path!).readAsBytes();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Uploading Image'),
          duration: Duration(seconds: 1),
        ),
      );

      print("passed extension check");

      // Send the binary data to Filestack API
      final response = await http.post(
          Uri.parse(
              'https://www.filestackapi.com/api/store/S3?key=AgQ54ULwmQrOkb0OkzeVYz'),
          headers: {
            'Content-Type': 'image/$fileExtensionType',
          },
          body: imageBytes);

      // Check the response and return the download URL
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image uploaded successfully'),
            duration: Duration(seconds: 1),
          ),
        );
        final responseData = json.decode(response.body);
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

  void _fetchOptions() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("events").get();

    _querySnapshot = querySnapshot;

    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        _options = querySnapshot.docs.map((doc) => doc.data()).toList();
        dateTime = _options[indx]["eventExpire"].toDate();
        _textEditingController1 =
            TextEditingController(text: _options[indx]["name"]);
        _textEditingController2 =
            TextEditingController(text: _options[indx]["date"]);
        _textEditingController3 =
            TextEditingController(text: _options[indx]["location"]);
        _textEditingController4 =
            TextEditingController(text: _options[indx]["description"]);
      });
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
              Container(
                padding: const EdgeInsets.all(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Select an option:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _selectedOption,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CupertinoButton.filled(
                          child: const Text("Open Picker"),
                          onPressed: () {
                            scrollController.dispose();
                            scrollController =
                                FixedExtentScrollController(initialItem: indx);
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) => CupertinoActionSheet(
                                      actions: [buildPicker()],
                                    ));
                          }),
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: _textEditingController1,
                key: const ValueKey("name"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Name cannot be empty";
                  } else {
                    return null;
                  }
                },
                onChanged: (valN) {
                  _textEditingController1 = TextEditingController(text: valN);
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
                controller: _textEditingController2,
                key: const ValueKey("date"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Date cannot be empty";
                  } else {
                    return null;
                  }
                },
                onChanged: (valD) {
                  _textEditingController2 = TextEditingController(text: valD);
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
                controller: _textEditingController3,
                key: const ValueKey("location"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Location cannot be empty";
                  } else {
                    return null;
                  }
                },
                onChanged: (valL) {
                  _textEditingController3 = TextEditingController(text: valL);
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
                controller: _textEditingController4,
                maxLines: null,
                key: const ValueKey("description"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Description cannot be empty";
                  } else {
                    return null;
                  }
                },
                onChanged: (valDes) {
                  _textEditingController4 = TextEditingController(text: valDes);
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
                                  return Text(
                                      '${dateTime.year}/${dateTime.month}/${dateTime.day}');
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
                    Container(
                      color: Colors.green[50],
                      child: readyLocal
                          ? Image.file(
                              File(_selectedFile!.path!),
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            )
                          : Image.network(_options.isNotEmpty
                              ? _options[indx]["img"]
                              : "https://via.placeholder.com/200x200"),
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
                        print(isReady);

                        if (isReady) {
                          isReady = false;
                          await _updateEventSubmit();
                          isReady = true;
                        }
                      },
                      child: const Text("Update Record"),
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

  Widget buildPicker() => _options.isNotEmpty
      ? SizedBox(
          height: 350,
          child: CupertinoPicker(
            scrollController: scrollController,
            itemExtent: 64,
            onSelectedItemChanged: (index) {
              setState(() {
                indx = index;
                _textEditingController1 =
                    TextEditingController(text: _options[indx]["name"]);
                _textEditingController2 =
                    TextEditingController(text: _options[indx]["date"]);
                _textEditingController3 =
                    TextEditingController(text: _options[indx]["location"]);
                _textEditingController4 =
                    TextEditingController(text: _options[indx]["description"]);
                _selectedOption = _options[index]["name"];
                dateTime = _options.isNotEmpty
                    ? (_options[index]["eventExpire"]).toDate()
                    : DateTime.now();
                readyNetwork = true;
                readyLocal = false;
                _selectedFile = null;
              });
            },
            children: _options
                .map((option) => Center(child: Text(option["name"])))
                .toList(),
          ),
        )
      : const CircularProgressIndicator();
}
