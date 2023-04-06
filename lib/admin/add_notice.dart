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
  DateTime dateTime = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  bool isSelected = false;

  var noticeTitle;
  var noticeSummary;
  var noticeDescription;

  void _addEventSubmit() {
    final isValidANForm = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValidANForm) {
      _formKey.currentState!.save();

      FirebaseFirestore.instance
          .collection("notices")
          .doc()
          .set({
            "title": noticeTitle,
            "summary": noticeSummary,
            "description": noticeDescription,
            "expireDate": Timestamp.fromDate(dateTime)
          })
          .onError((e, _) => print("Error writing document: $e"))
          .then((value) => print("record added"));
    }

    print(noticeTitle);
    print(noticeSummary);
    print(noticeDescription);
  }

  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

    return Card(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
            Container(
              padding: EdgeInsets.all(14),
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
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: _addEventSubmit,
              child: const Text("Add Event"),
            ),
          ]),
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
