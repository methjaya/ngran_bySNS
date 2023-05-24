import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/admin/addEvent.dart';
import 'package:flutter_firebase_test/admin/admin_home_page.dart';
import 'package:flutter_firebase_test/admin/user_data.dart';
import 'package:flutter_firebase_test/pages/home_page.dart';

class VerifyUserEmail extends StatefulWidget {
  const VerifyUserEmail({super.key});

  @override
  State<VerifyUserEmail> createState() => _VerifyUserEmailState();
}

class _VerifyUserEmailState extends State<VerifyUserEmail> {
  bool isVerified = false;
  bool canResend = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isVerified) {
      sendEmailVerification();

      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        isVerifiedEmail();
        print("hello");
      });
    }
  }

  Future isVerifiedEmail() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isVerified) {
      timer!.cancel();
    }
  }

  Future sendEmailVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() {
        canResend = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResend = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to Send Email Verification'),
        ),
      );
    }
  }

  Future<bool> checkUserRole(String uid) async {
    try {
      var user =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      print(uid);

      if (user['role'] == "student") {
        UserData.userFaculty = user['faculty'];
        UserData.userDegree = user['degree'];
        UserData.userBatch = user['batch'];
        UserData.userRole = user['role'];
      } else {
        UserData.userRole = user['role'];
      }

      return true;

      // print(userRole);
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkUserRole(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.hasError) {
              return const Scaffold(
                body: Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Text(
                        "Error Initializing the app, Please try again later or contact an admin"),
                  ),
                ),
              );
            } else {
              print("fac :${UserData.userFaculty}");
              print("userole ; ${UserData.userRole}");
              return isVerified
                  ? (UserData.userRole == "student"
                      ? const HomePage()
                      : (UserData.userRole == "admin"
                          ? const HomePageAdmin()
                          : (UserData.userRole == "superadmin")
                              ? const HomePageAdmin()
                              : const AddEvent()))
                  : Scaffold(
                      appBar: AppBar(
                        title: const Text("Verify Email"),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 80),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "A Verification Email has been sent to your email",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              SizedBox(
                                height: 50,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(50)),
                                  onPressed: () {
                                    sendEmailVerification();
                                  },
                                  icon: const Icon(Icons.email, size: 34),
                                  label: const Text(
                                    "Resend Email",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              TextButton(
                                  onPressed: () =>
                                      FirebaseAuth.instance.signOut(),
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(fontSize: 24),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    );
            }
          } else {
            return const Scaffold(
              body: Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        });
  }

  // @override
  // Widget build(BuildContext context) => isVerified
  //     ? (UserData.userRole == "student"
  //         ? const HomePage()
  //         : (UserData.userRole == "admin"
  //             ? const HomePageAdmin()
  //             : (UserData.userRole == "superadmin")
  //                 ? const HomePageAdmin()
  //                 : const AddEvent()))
  //     : Scaffold(
  //         appBar: AppBar(
  //           title: const Text("Verify Email"),
  //         ),
  //         body: Padding(
  //           padding: const EdgeInsets.all(16),
  //           child: Container(
  //             margin: const EdgeInsets.fromLTRB(0, 0, 0, 80),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 const Text(
  //                   "A Verification Email has been sent to your email",
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                   ),
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 const SizedBox(
  //                   height: 18,
  //                 ),
  //                 SizedBox(
  //                   height: 50,
  //                   child: ElevatedButton.icon(
  //                     style: ElevatedButton.styleFrom(
  //                         minimumSize: const Size.fromHeight(50)),
  //                     onPressed: () {
  //                       sendEmailVerification();
  //                     },
  //                     icon: const Icon(Icons.email, size: 34),
  //                     label: const Text(
  //                       "Resend Email",
  //                       style: TextStyle(fontSize: 24),
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 18,
  //                 ),
  //                 TextButton(
  //                     onPressed: () => FirebaseAuth.instance.signOut(),
  //                     child: const Text(
  //                       "Cancel",
  //                       style: TextStyle(fontSize: 24),
  //                     ))
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
}


// isVerified
//       ? (UserData.userRole == "student"
//           ? const HomePage()
//           : (UserData.userRole == "admin"
//               ? const HomePageAdmin()
//               : (UserData.userRole == "superadmin")
//                   ? const HomePageAdmin()
//                   : const AddEvent()))
//       : Scaffold(
//           appBar: AppBar(
//             title: const Text("Verify Email"),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Container(
//               margin: const EdgeInsets.fromLTRB(0, 0, 0, 80),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "A Verification Email has been sent to your email",
//                     style: TextStyle(
//                       fontSize: 20,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(
//                     height: 18,
//                   ),
//                   SizedBox(
//                     height: 50,
//                     child: ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                           minimumSize: const Size.fromHeight(50)),
//                       onPressed: () {
//                         sendEmailVerification();
//                       },
//                       icon: const Icon(Icons.email, size: 34),
//                       label: const Text(
//                         "Resend Email",
//                         style: TextStyle(fontSize: 24),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 18,
//                   ),
//                   TextButton(
//                       onPressed: () => FirebaseAuth.instance.signOut(),
//                       child: const Text(
//                         "Cancel",
//                         style: TextStyle(fontSize: 24),
//                       ))
//                 ],
//               ),
//             ),
//           ),
//         );