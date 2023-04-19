import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_test/pages/detail_page_event.dart';
import 'package:flutter_firebase_test/pages/home_page.dart';
import 'package:flutter_firebase_test/pages/notice_page.dart';
import 'package:flutter_firebase_test/admin/user_data.dart';

import 'package:flutter_firebase_test/screens/authscreen.dart';
import 'package:flutter_firebase_test/screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var userRole;

  Future<void> checkUserRole(String uid) async {
    try {
      var user =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      print(uid);

      userRole = user['role'];
      UserData.userFaculty = user['faculty'];
      UserData.userDegree = user['degree'];
      UserData.userBatch = user['batch'];

      // print(userRole);
    } catch (e) {
      print(e.toString());
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
                    return HomePage();
                  } else if (userRole == "admin") {
                    return HomePage();
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
