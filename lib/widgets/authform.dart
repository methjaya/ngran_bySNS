import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
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
    String dropDownValD,
    String dropDownValB,
  ) submitFn;

  AuthForm(this.submitFn, this.isLoading);

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
  String dropDownValF = 'FOC';
  String dropDownValD = 'se';
  String dropDownValB = '21.1';

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
        dropDownValD,
        dropDownValB,
      );
    }
  }

  void dropDownCallbackF(String? sValue) {
    if (sValue is String) {
      setState(() {
        dropDownValF = sValue;
      });
    }
    print(dropDownValF);
  }

  void dropDownCallbackD(String? sValue) {
    if (sValue is String) {
      setState(() {
        dropDownValD = sValue;
      });
    }
    print(dropDownValD);
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
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: ValueKey("email"),
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
                    decoration: InputDecoration(labelText: 'Email Address'),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey("uname"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        username = newValue!;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                  TextFormField(
                    key: ValueKey("pass"),
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
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey("fName"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "First name cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        fName = newValue!;
                      },
                      decoration: InputDecoration(labelText: 'First Name'),
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey("lName"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Last name cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        lName = newValue!;
                      },
                      decoration: InputDecoration(labelText: 'Last Name'),
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey("nic"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "NIC cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        nic = newValue!;
                      },
                      decoration: InputDecoration(labelText: 'NIC'),
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey("stdID"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Student ID cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        stdID = int.parse(newValue!);
                      },
                      decoration: InputDecoration(labelText: 'Student ID'),
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey("phNo"),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 10) {
                          return "Phone Number cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        phNo = int.parse(newValue!);
                      },
                      decoration: InputDecoration(labelText: 'Phone Number'),
                    ),
                  if (!_isLogin)
                    DropdownButton(
                      key: ValueKey("faculty"),
                      items: const [
                        DropdownMenuItem(child: Text("FOC"), value: "FOC"),
                        DropdownMenuItem(child: Text("FOB"), value: "FOB"),
                        DropdownMenuItem(child: Text("FOE"), value: "FOE"),
                      ],
                      onChanged: dropDownCallbackF,
                      isExpanded: true,
                      value: dropDownValF,
                      // iconSize: 42.0,
                    ),
                  if (!_isLogin)
                    DropdownButton(
                      key: ValueKey("degree"),
                      items: const [
                        DropdownMenuItem(
                            child: Text("Software Engineering"), value: "se"),
                        DropdownMenuItem(
                            child: Text("Computer Science"), value: "csc"),
                        DropdownMenuItem(
                            child: Text("Cyber security"), value: "cse"),
                      ],
                      onChanged: dropDownCallbackD,
                      isExpanded: true,
                      value: dropDownValD,
                      // iconSize: 42.0,
                    ),
                  if (!_isLogin)
                    DropdownButton(
                      key: ValueKey("batch"),
                      items: const [
                        DropdownMenuItem(child: Text("21.1"), value: "21.1"),
                        DropdownMenuItem(child: Text("21.2"), value: "21.2"),
                        DropdownMenuItem(child: Text("21.3"), value: "21.3"),
                      ],
                      onChanged: dropDownCallbackB,
                      isExpanded: true,
                      value: dropDownValB,
                      // iconSize: 42.0,
                    ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      onPressed: _fSubmit,
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
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
