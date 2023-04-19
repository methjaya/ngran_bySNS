import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/widgets/authform.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
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
  ) async {
    UserCredential _userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        _userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        _userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_userCredential.user!.uid)
            .set({
          'username': username,
          'email': email,
          'firstName': fName,
          'lastName': lName,
          'nic': nic,
          'studentID': stdID,
          'phoneNumber': phNo,
          'faculty': dropDownValF,
          'degree': dropDownValD,
          'batch': dropDownValB,
        });
      }
    } on PlatformException catch (e) {
      var message = "Error occurred, Check your credentails";

      if (e.message != null) {
        message = e.message!;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text("zzzz"),
          backgroundColor: Colors.red,
        ),
      );

      setState(() {
        _isLoading = false;
      });

      print(message);
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Colors.green.withOpacity(1),
    //   // body: AuthForm(),
    //   body: AuthForm(_submitAuthForm, _isLoading),
    // );
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/login.png"),
            fit: BoxFit.cover,
          ),
        ),
        child:
            AuthForm(_submitAuthForm, _isLoading), /* add child content here */
      ),
    );
  }
}
