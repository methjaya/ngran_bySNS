import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class EditUserDetails extends StatefulWidget {
  const EditUserDetails({super.key});

  @override
  State<EditUserDetails> createState() => _EditUserDetailsState();
}

class _EditUserDetailsState extends State<EditUserDetails> {
  final _formKey = GlobalKey<FormState>();

  String password = '';
  String username = '';
  String fName = '';
  String lName = '';
  String nic = '';
  int stdID = 0;
  int phNo = 0;
  String degree = "SE-PLY";
  String dropDownValF = 'FOC';
  String dropDownValCD = 'SE-PLY';
  String dropDownValMD = 'MNG-1';
  String dropDownValB = '21.1';
  List<List<List<String>>> degreeList = [
    [
      ["Software Engineering", "Computer Science", "Cyber Security"],
      ["SE-PLY", "COMSC-PLY", "CYSEC-PLY"]
    ],
    [
      ["Management 1", "Management 2", "Management 3"],
      ["MNG-1", "MNG-2", "MNG-3"]
    ]
  ];
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
        "studentID": stdID,
        "nic": nic,
        "username": username.trim(),
        "phoneNumber": phNo,
        "firstName": fName,
        "lastName": lName,
        "faculty": dropDownValF,
        "degree": degree,
        "batch": dropDownValB
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
          print(_userData["firstName"]);
          _txtControllerFName =
              TextEditingController(text: _userData["firstName"]);
          _txtControllerLName =
              TextEditingController(text: _userData["lastName"]);
          _txtControllerUname =
              TextEditingController(text: _userData["username"]);
          _txtControllerNIC = TextEditingController(text: _userData["nic"]);
          _txtControllerSID =
              TextEditingController(text: _userData["studentID"].toString());
          _txtControllerPHNo =
              TextEditingController(text: _userData["phoneNumber"].toString());
          dropDownValB = _userData["batch"];

          dropDownValF = _userData["faculty"];
          if (_userData["username"] == 'FOC') {
            dropDownValCD = _userData["degree"];
          }
          if (_userData["username"] == 'FOB') {
            dropDownValMD = _userData["degree"];
          }
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

  void dropDownCallbackF(String? sValue) {
    if (sValue is String) {
      setState(() {
        dropDownValF = sValue;
      });
      if (sValue == "FOC") {
        degree = dropDownValCD;
      } else if (sValue == "FOB") {
        degree = dropDownValMD;
      }
    }
    print(dropDownValF);
  }

  void dropDownCallbackD(String? sValue) {
    if (sValue is String) {
      if (dropDownValF == 'FOC') {
        setState(() {
          dropDownValCD = sValue;
        });
        degree = dropDownValCD;
      }
      if (dropDownValF == 'FOB') {
        setState(() {
          dropDownValMD = sValue;
        });
        degree = dropDownValMD;
      }
    }
  }

  void dropDownCallbackB(String? sValue) {
    if (sValue is String) {
      setState(() {
        dropDownValB = sValue;
      });
    }
    print(dropDownValB);
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
                    TextFormField(
                      controller: _txtControllerUname,
                      key: const ValueKey("EUname"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        username = newValue!;
                      },
                      onChanged: (valUname) {
                        _txtControllerUname =
                            TextEditingController(text: valUname);
                      },
                      decoration: const InputDecoration(labelText: 'Username'),
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
                      controller: _txtControllerSID,
                      key: const ValueKey("EstdID"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Student ID cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        stdID = int.parse(newValue!);
                      },
                      onChanged: (valLName) {
                        _txtControllerSID =
                            TextEditingController(text: valLName);
                      },
                      decoration:
                          const InputDecoration(labelText: 'Student ID'),
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
                    DropdownButton(
                      key: const ValueKey("faculty"),
                      items: const [
                        DropdownMenuItem(value: "FOC", child: Text("FOC")),
                        DropdownMenuItem(value: "FOB", child: Text("FOB")),
                      ],
                      onChanged: dropDownCallbackF,
                      isExpanded: true,
                      value: dropDownValF,
                      // iconSize: 42.0,
                    ),
                    DropdownButton(
                      key: const ValueKey("degree"),
                      items: dropDownValF == "FOC"
                          ? [
                              DropdownMenuItem(
                                  value: degreeList[0][1][0].toString(),
                                  child: Text(degreeList[0][0][0].toString())),
                              DropdownMenuItem(
                                  value: degreeList[0][1][1].toString(),
                                  child: Text(degreeList[0][0][1].toString())),
                              DropdownMenuItem(
                                  value: degreeList[0][1][2].toString(),
                                  child: Text(degreeList[0][0][2].toString())),
                            ]
                          : [
                              DropdownMenuItem(
                                  value: degreeList[1][1][0].toString(),
                                  child: Text(degreeList[1][0][0].toString())),
                              DropdownMenuItem(
                                  value: degreeList[1][1][1].toString(),
                                  child: Text(degreeList[1][0][1].toString())),
                              DropdownMenuItem(
                                  value: degreeList[1][1][2].toString(),
                                  child: Text(degreeList[1][0][2].toString())),
                            ],
                      onChanged: dropDownCallbackD,
                      isExpanded: true,
                      value:
                          dropDownValF == "FOC" ? dropDownValCD : dropDownValMD,
                      // iconSize: 42.0,
                    ),
                    DropdownButton(
                      key: const ValueKey("batch"),
                      items: const [
                        DropdownMenuItem(value: "21.1", child: Text("21.1")),
                        DropdownMenuItem(value: "21.2", child: Text("21.2")),
                        DropdownMenuItem(value: "21.3", child: Text("21.3")),
                      ],
                      onChanged: dropDownCallbackB,
                      isExpanded: true,
                      value: dropDownValB,
                      // iconSize: 42.0,
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
