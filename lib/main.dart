import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_test/pages/detail_page_event.dart';
import 'package:flutter_firebase_test/pages/home_page.dart';
import 'package:flutter_firebase_test/pages/notice_page.dart';

import 'package:flutter_firebase_test/screens/authscreen.dart';
import 'package:flutter_firebase_test/screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var userRole;

  void getDataFromFirestore(String uid) {
    // Initialize Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      var user = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((value) => userRole = value.data()!['role'])
          .catchError((error) {
        print('Error reading data from Firestore: $error');
      });
      print(userRole);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkUserRole(String uid) async {
    try {
      var user =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      print(uid);

      userRole = user['role'];

      return true;

      // print(userRole);
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'San-francisco',
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return FutureBuilder(
                future: checkUserRole(userSnapshot.data!.uid),
                builder: (contxt, snapshot) {
                  if (userRole == "student") {
                    return Material(child: NoticesListWidget());
                  } else if (userRole == "admin") {
                    return DetailPageEvent();
                  } else {
                    return AuthScreen();
                  }
                });

            // checkUserRole(userSnapshot.data!.uid);
            // getDataFromFirestore(userSnapshot.data!.uid);

            // if (userRole == "student") {
            //   return HomePage();
            // } else if (userRole == "admin") {
            //   return DetailPageEvent();
            // } else {
            //   return AuthScreen();
            // }
          } else {
            return AuthScreen();
          }
        },
      ),
    );
  }
}
