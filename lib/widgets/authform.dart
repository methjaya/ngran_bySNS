
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final int isError;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
    String fName,
    String lName,
    String nic,
    int stdID,
    int phNo,
    String dropDownValF,
    String degree,
    String dropDownValB,
  ) submitFn;

  const AuthForm(this.submitFn, this.isLoading, this.isError, {super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;
  String email = '';
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

  void _fSubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        email,
        password.trim(),
        username.trim(),
        _isLogin,
        context,
        fName,
        lName,
        nic,
        stdID,
        phNo,
        dropDownValF,
        degree,
        dropDownValB,
      );
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
    return Center(
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
                      email = newValue!;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(labelText: 'Email Address'),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey("uname"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        username = newValue!;
                      },
                      decoration: const InputDecoration(labelText: 'Username'),
                    ),
                  TextFormField(
                    key: const ValueKey("pass"),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password should have at least 7 characters';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (newValue) {
                      password = newValue!;
                    },
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey("fName"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "First name cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        fName = newValue!;
                      },
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey("lName"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Last name cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        lName = newValue!;
                      },
                      decoration: const InputDecoration(labelText: 'Last Name'),
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey("nic"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "NIC cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        nic = newValue!;
                      },
                      decoration: const InputDecoration(labelText: 'NIC'),
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey("stdID"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Student ID cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        stdID = int.parse(newValue!);
                      },
                      decoration:
                          const InputDecoration(labelText: 'Student ID'),
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey("phNo"),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 10) {
                          return "Phone Number cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        phNo = int.parse(newValue!);
                      },
                      decoration:
                          const InputDecoration(labelText: 'Phone Number'),
                    ),
                  if (!_isLogin)
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
                  if (!_isLogin)
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
                  if (!_isLogin)
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
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      onPressed: () {
                        _fSubmit();
                        if (widget.isError == 1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Login Error : Check Your Credentials'),
                              duration: Duration(seconds: 4),
                            ),
                          );
                        } else if (widget.isError == 2) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'An Error occured while trying to sign you in'),
                              duration: Duration(seconds: 4),
                            ),
                          );
                        }
                      },
                      child: Text(_isLogin ? 'Login' : 'Sign up'),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create New Account'
                          : 'I already have an account'),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
