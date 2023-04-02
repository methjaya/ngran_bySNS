import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();

  var Ename;
  var Edate;
  var Elocation;
  var Edescription;

  void _addEventSubmit() {
    final isValidAEForm = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValidAEForm) {
      _formKey.currentState!.save();

      FirebaseFirestore.instance.collection("events").doc().set({
        "name": Ename,
        "date": Edate,
        "location": Elocation,
        "description": Edescription
      }).onError((e, _) => print("Error writing document: $e")).then((value) => print("record added"));
    }

    print(Ename);
    print(Edate);
    print(Elocation);
    print(Edescription);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
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
              decoration: InputDecoration(
                labelText: 'Event Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              key: ValueKey("date"),
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
              decoration: InputDecoration(
                labelText: 'Event Date',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              key: ValueKey("location"),
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
              decoration: InputDecoration(
                labelText: 'Event Location',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              key: ValueKey("description"),
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
              decoration: InputDecoration(
                labelText: 'Event Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: _addEventSubmit,
              child: Text("Add Event"),
            ),
          ]),
        ),
      ),
    );
  }
}
