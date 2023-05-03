import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

class EditAdminDetails extends StatefulWidget {
  const EditAdminDetails({super.key});

  @override
  State<EditAdminDetails> createState() => _EditAdminDetailsState();
}

class _EditAdminDetailsState extends State<EditAdminDetails> {
  final _formKey = GlobalKey<FormState>();

  String fName = '';
  String lName = '';
  String nic = '';
  int phNo = 0;

  Map<String, dynamic> _userData = {};
  TextEditingController _txtControllerFName = TextEditingController(text: "");
  TextEditingController _txtControllerLName = TextEditingController(text: "");
  TextEditingController _txtControllerUname = TextEditingController(text: "");
  TextEditingController _txtControllerNIC = TextEditingController(text: "");
  TextEditingController _txtControllerSID = TextEditingController(text: "");
  TextEditingController _txtControllerPHNo = TextEditingController(text: "");

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

  void _fSubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "nic": nic,
        "phoneNumber": phNo,
        "firstName": fName,
        "lastName": lName,
      }).onError((e, _) {
        _showdialog('Error Updating User Details: $e', context, false);
        print("Error Updating document: $e");
      }).then((value) {
        _showdialog('Details Updated Succussfully', context, true);
        print("record updated");
      });
    }
  }

  void _fetchUserData() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (documentSnapshot.exists) {
        setState(() {
          _userData = documentSnapshot.data() as Map<String, dynamic>;
          _txtControllerFName =
              TextEditingController(text: _userData["firstName"]);
          _txtControllerLName =
              TextEditingController(text: _userData["lastName"]);

          _txtControllerNIC = TextEditingController(text: _userData["nic"]);

          _txtControllerPHNo =
              TextEditingController(text: _userData["phoneNumber"].toString());
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error Getting User Details : $e'),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: FirebaseAuth.instance.currentUser!.email as String);
      _showdialog('An Email has been sent to your account', context, true);
    } catch (e) {
      _showdialog('Something went wrong', context, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Center(
                      child: Text("--Update Details--",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 25,
                    ),

                    TextFormField(
                      controller: _txtControllerFName,
                      key: const ValueKey("EFName"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "First name cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        fName = newValue!;
                      },
                      onChanged: (valfName) {
                        _txtControllerFName =
                            TextEditingController(text: valfName);
                      },
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                    ),
                    TextFormField(
                      controller: _txtControllerLName,
                      key: const ValueKey("ELstName"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Last name cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        lName = newValue!;
                      },
                      onChanged: (valLName) {
                        _txtControllerLName =
                            TextEditingController(text: valLName);
                      },
                      decoration: const InputDecoration(labelText: 'Last Name'),
                    ),
                    TextFormField(
                      controller: _txtControllerNIC,
                      key: const ValueKey("Enic"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "NIC cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        nic = newValue!;
                      },
                      onChanged: (valLName) {
                        _txtControllerNIC =
                            TextEditingController(text: valLName);
                      },
                      decoration: const InputDecoration(labelText: 'NIC'),
                    ),

                    TextFormField(
                      controller: _txtControllerPHNo,
                      key: const ValueKey("EphNo"),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 10) {
                          return "Phone Number cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        phNo = int.parse(newValue!);
                      },
                      onChanged: (valLName) {
                        _txtControllerPHNo =
                            TextEditingController(text: valLName);
                      },
                      decoration:
                          const InputDecoration(labelText: 'Phone Number'),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _fSubmit,
                            child: const Text("Update"),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Hold the button to reset the password'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            onLongPress: resetPassword,
                            child: const Text("Reset Password"),
                          ),
                        ),
                      ],
                    )
                    // ElevatedButton(
                    //   onPressed: _fSubmit,
                    //   child: const Text("Update"),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
