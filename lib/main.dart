import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_test/admin/verify_email.dart';

import 'package:flutter_firebase_test/screens/authscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var isVerified;

  MyApp({super.key});

  Future<void> checkUserVerification(String uid) async {
    try {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      // print(userRole);
    } catch (e) {
      print(e.toString());
    }
  }
  //   Future<void> checkUserRole(String uid) async {
  //   try {
  //     var user =
  //         await FirebaseFirestore.instance.collection("users").doc(uid).get();

  //     print(uid);

  //     userRole = user['role'];
  //     UserData.userFaculty = user['faculty'];
  //     UserData.userDegree = user['degree'];
  //     UserData.userBatch = user['batch'];
  //     UserData.userRole = user['role'];

  //     // print(userRole);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

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
            return const VerifyUserEmail();
            // FutureBuilder(
            //     future: checkUserVerification(userSnapshot.data!.uid),
            //     builder: (contxt, snapshot) {
            //       if (isVerified == false) {
            //         // return const HomePage();
            //         return const VerifyUserEmail();
            //       }
            //       else {
            //         return const Scaffold(
            //           body: Center(
            //             child: SizedBox(
            //               height: 200,
            //               width: 200,
            //               child: CircularProgressIndicator(),
            //             ),
            //           ),
            //         );
            //         ;
            //       }
            //     });

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
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
