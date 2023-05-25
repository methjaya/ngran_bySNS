import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class AddNotice extends StatefulWidget {
  const AddNotice({super.key});

  @override
  State<AddNotice> createState() => _AddNoticeState();
}

class _AddNoticeState extends State<AddNotice> {
  static Set<String> _selectedOptions = {};
  DateTime dateTime = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  bool isSelected = false;

  var noticeTitle;
  var noticeSummary;
  var noticeDescription;

  void _showdialog(String txt, bool type) {
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

  void _addNoticeSubmit() {
    final isValidANForm = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValidANForm &&
        ((dateTime.day != DateTime.now().day)) &&
        _selectedOptions.isNotEmpty) {
      _formKey.currentState!.save();

      FirebaseFirestore.instance
          .collection("notices")
          .doc()
          .set({
            "title": noticeTitle,
            "summary": noticeSummary,
            "description": noticeDescription,
            "noticeExpire": Timestamp.fromDate(dateTime),
            "groups": _selectedOptions
          })
          .onError((e, _) =>
              _showdialog("Something Went Wrong With Adding The Noitce", false))
          .then((value) => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  icon: const Icon(
                    size: 80,
                    Icons.check_circle_outline_rounded,
                    color: Colors.green,
                  ),
                  content: const Text(
                    "Notice Added Successfully",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
              ));
    }
    if (dateTime.day == DateTime.now().day) {
      print('Please Select An Valid Expire Date For The Notice.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Select an Valid Expire Date for The Notice.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
    if (_selectedOptions.isEmpty) {
      print('Please Select at least One Group');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Select At Least One Group'),
          duration: Duration(seconds: 3),
        ),
      );
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Center(
                  child: Text("--Add Notices--",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800]),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text('Select Groups'),
                          content: CheckboxListTileGroups(),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('CLOSE'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    ).then((value) => setState(() {
                          _selectedOptions;
                        }));
                  },
                  child: const Text('Select Groups'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: Text(_selectedOptions.toString()),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  key: const ValueKey("Ntitle"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Title cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    noticeTitle = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Notice Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  key: const ValueKey("Nsummary"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Notice Summary cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    noticeSummary = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Notice Summary',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  maxLines: null,
                  key: const ValueKey("Ndescription"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Notice Description cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    noticeDescription = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Notice Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Container(
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
                          "Notice Expire",
                          style:
                              TextStyle(fontSize: 18, color: Colors.cyan[900]),
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

                                  setState(
                                    () {
                                      dateTime = dateTimeNew;
                                    },
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: _addNoticeSubmit,
                  child: const Text("Add Notice"),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
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

class CheckboxListTileGroups extends StatefulWidget {
  @override
  CheckboxListTileGroupsState createState() => CheckboxListTileGroupsState();
}

class CheckboxListTileGroupsState extends State<CheckboxListTileGroups> {
  final List<String> _options = [
    'FOC',
    'SE-PLY',
    'CYSEC-PLY',
    'COMSC-PLY',
    'FOB',
    'MNG-1',
    'MNG-2',
    'MNG-3',
    '21.1',
    '21.2',
    '21.3',
  ];

  void _onOptionSelected(String option) {
    setState(() {
      if (_AddNoticeState._selectedOptions.contains(option)) {
        _AddNoticeState._selectedOptions.remove(option);
      } else {
        _AddNoticeState._selectedOptions.add(option);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      width: double.maxFinite,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _options.length,
        itemBuilder: (BuildContext context, int index) {
          final option = _options[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: SizedBox(
              height: 40,
              width: 200,
              child: CheckboxListTile(
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(20)),
                title: Text(option),
                value: _AddNoticeState._selectedOptions.contains(option),
                onChanged: (value) {
                  _onOptionSelected(option);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
