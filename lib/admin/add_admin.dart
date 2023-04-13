import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RegisterAdmin extends StatefulWidget {
  const RegisterAdmin({super.key});

  @override
  State<RegisterAdmin> createState() => _RegisterAdminState();
}

class _RegisterAdminState extends State<RegisterAdmin> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _uid = "";
  String _password = '';
  String _fName = '';
  String _lName = '';
  String _nic = '';
  int _phNo = 0;

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
          style: TextStyle(fontWeight: FontWeight.bold),
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

  void _addUserDetails(String uid) async {
    await FirebaseFirestore.instance.collection("users").doc(uid).set(
      {
        'uid': uid,
        "firstName": _fName,
        "lastName": _lName,
        "nic": _nic,
        "phoneNumber": _phNo,
        "email": _email,
        "role": 'Admin'
      },
    ).onError((e, _) {
      _showdialog("Error Creating Document: $e", context, false);
      print("Error Creating Document: $e");
    }).then(
      (value) {
        print("record updated");
        _showdialog("User Details Added Successfully", context, true);
      },
    );
  }

  void _signupUser() async {
    // FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseApp firebaseApp = await Firebase.initializeApp(
        name: "tempApp", options: Firebase.app().options);

    try {
      FirebaseAuth auth = FirebaseAuth.instanceFor(app: firebaseApp);
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      _uid = userCredential.user!.uid.toString();

      print('User ${userCredential.user!.uid} created successfully.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User Succussfully Registered'),
          duration: Duration(seconds: 4),
        ),
      );

      _addUserDetails(
        _uid,
      );

      await firebaseApp.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The Provided Password is too Weak.'),
            duration: Duration(seconds: 3),
          ),
        );
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An Account Already Exist For That Email.'),
            duration: Duration(seconds: 4),
          ),
        );
        print('The account already exists for that email.');
      }
    } catch (e) {
      _showdialog('Error creating user: $e', context, false);
      print('Error creating user: $e');
    }
  }

  void _fSubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      _password = _genPassword();
      _signupUser();
    }
  }

  String _genPassword() {
    const charList = "abcdefghijklmnopqrstuvwxyz0123456789";
    final rnd = Random.secure();
    final pass =
        List.generate(8, (index) => charList[rnd.nextInt(charList.length)])
            .join();

    return pass.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                      TextFormField(
                        key: const ValueKey("email"),
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return "Email is invalid";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          _email = newValue!;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            labelText: 'Email Address',
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        key: const ValueKey("fName"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "First name cannot be empty";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _fName = newValue!;
                        },
                        decoration: const InputDecoration(
                            labelText: 'First Name',
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        key: const ValueKey("lName"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Last name cannot be empty";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _lName = newValue!;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Last Name',
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        key: const ValueKey("nic"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "NIC cannot be empty";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _nic = newValue!;
                        },
                        decoration: const InputDecoration(
                            labelText: 'NIC', border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        key: const ValueKey("phNo"),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 10) {
                            return "Phone Number cannot be empty";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _phNo = int.parse(newValue!);
                        },
                        decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _fSubmit();
                        },
                        child: const Text('Sign up'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
