import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UpdateNotice extends StatefulWidget {
  const UpdateNotice({super.key});

  @override
  State<UpdateNotice> createState() => _UpdateNoticeState();
}

class _UpdateNoticeState extends State<UpdateNotice> {
  DateTime dateTime = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  var noticeTitle;
  var noticeSummary;
  var noticeDescription;

  late FixedExtentScrollController scrollController;
  static Set<String> _selectedGroups = {};
  String _selectedOption = '';
  List<dynamic> _options = [];
  late QuerySnapshot _querySnapshot;
  int indx = 0;
  TextEditingController _textEditingController1 =
      TextEditingController(text: "");
  TextEditingController _textEditingController2 =
      TextEditingController(text: "");
  TextEditingController _textEditingController3 =
      TextEditingController(text: "");

  void _fetchOptions() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("notices").get();

    _querySnapshot = querySnapshot;

    if (querySnapshot.docs.isNotEmpty) {
      _selectedGroups.clear();
      setState(() {
        _options = querySnapshot.docs.map((doc) => doc.data()).toList();
        dateTime = _options[indx]["noticeExpire"].toDate();
        _textEditingController1 =
            TextEditingController(text: _options[indx]["title"]);
        _textEditingController2 =
            TextEditingController(text: _options[indx]["summary"]);
        _textEditingController3 =
            TextEditingController(text: _options[indx]["description"]);
        _selectedGroups = Set<String>.from(
            _options[indx]["groups"].map((e) => e.toString()).toSet());
      });
    }
  }

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

  void _updateNoticeSubmit() {
    final isValidUNForm = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValidUNForm) {
      _formKey.currentState!.save();

      FirebaseFirestore.instance
          .collection("notices")
          .doc(_querySnapshot.docs[indx].id.toString())
          .update({
        "title": noticeTitle,
        "summary": noticeSummary,
        "description": noticeDescription,
        "expireDate": Timestamp.fromDate(dateTime),
        "groups": _selectedGroups
      }).onError((e, _) {
        print("Error writing document: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error writing document: $e'),
            duration: const Duration(seconds: 1),
          ),
        );
      }).then((value) {
        print("record updated");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Record Updated'),
            duration: Duration(seconds: 1),
          ),
        );
      });
    }

    print(noticeTitle);
    print(noticeSummary);
    print(noticeDescription);
  }

  void _deleteNoticeSubmit() async {
    await FirebaseFirestore.instance
        .collection("notices")
        .doc(_querySnapshot.docs[indx].id.toString())
        .delete()
        .onError((e, _) {
      print("Error Deleting document: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error Deleting Document: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    }).then((value) {
      print("record deleted");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notice Deleted'),
          duration: Duration(seconds: 2),
        ),
      );
    });
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
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Select options'),
                          content: const CheckboxListTileGroupsUpdate(),
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
                          _selectedGroups;
                        }));
                  },
                  child: const Text('Select options'),
                ),
                Flexible(
                  child: Text(_selectedGroups.toString()),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Select an option:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
                              scrollController = FixedExtentScrollController(
                                  initialItem: indx);
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
                  key: const ValueKey("Ntitle"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Title cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (valT) {
                    _textEditingController1 = TextEditingController(text: valT);
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
                  controller: _textEditingController2,
                  key: const ValueKey("Nsummary"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Notice Summary cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (valS) {
                    _textEditingController2 = TextEditingController(text: valS);
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
                  controller: _textEditingController3,
                  maxLines: null,
                  key: const ValueKey("Ndescription"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Notice Description cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (valD) {
                    _textEditingController3 = TextEditingController(text: valD);
                  },
                  onSaved: (newValue) {
                    noticeDescription = newValue!;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Notice Description',
                    border: OutlineInputBorder(),
                  ),
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
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: _updateNoticeSubmit,
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(180, 45)),
                  child: const Text("Update Notice"),
                ),
                const SizedBox(
                  height: 4,
                ),
                ElevatedButton(
                  onPressed: () {},
                  onLongPress: () {
                    if (_options.isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Delete Notice"),
                          content: const Text(
                              "Are you sure you want to delete the selected Notice?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                _deleteNoticeSubmit();
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Yes",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "No",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('There are no notices'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red, minimumSize: const Size(75, 40)),
                  child: const Text("Delete Notice"),
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

  Widget buildPicker() => _options.isNotEmpty
      ? SizedBox(
          height: 350,
          child: CupertinoPicker(
            scrollController: scrollController,
            itemExtent: 64,
            onSelectedItemChanged: (index) {
              _selectedGroups.clear();
              setState(() {
                indx = index;
                _textEditingController1 =
                    TextEditingController(text: _options[indx]["title"]);
                _textEditingController2 =
                    TextEditingController(text: _options[indx]["summary"]);
                _textEditingController3 =
                    TextEditingController(text: _options[indx]["description"]);
                _selectedOption = _options[index]["title"];
                dateTime = _options.isNotEmpty
                    ? (_options[index]["noticeExpire"]).toDate()
                    : DateTime.now();
                _selectedGroups = Set<String>.from(
                    _options[indx]["groups"].map((e) => e.toString()).toSet());
              });
            },
            children: _options
                .map((option) => Center(child: Text(option["title"])))
                .toList(),
          ),
        )
      : const CircularProgressIndicator();
}

class CheckboxListTileGroupsUpdate extends StatefulWidget {
  const CheckboxListTileGroupsUpdate({super.key});

  @override
  CheckboxListTileGroupsUpdateState createState() =>
      CheckboxListTileGroupsUpdateState();
}

class CheckboxListTileGroupsUpdateState
    extends State<CheckboxListTileGroupsUpdate> {
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
      if (_UpdateNoticeState._selectedGroups.contains(option)) {
        _UpdateNoticeState._selectedGroups.remove(option);
      } else {
        _UpdateNoticeState._selectedGroups.add(option);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      width: double.maxFinite,
      child: ListView.builder(
        itemCount: _options.length,
        itemBuilder: (BuildContext context, int index) {
          final option = _options[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: SizedBox(
              height: 55,
              width: 200,
              child: CheckboxListTile(
                title: Text(option),
                value: _UpdateNoticeState._selectedGroups.contains(option),
                onChanged: (value) {
                  setState(() {
                    _onOptionSelected(option);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
