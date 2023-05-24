import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var uname = "test";
  var userID;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> userName() async {
    try {
      final userID = auth.currentUser!.uid;
      // print(userID);
      var uname1 = await FirebaseFirestore.instance
          .collection("users")
          .doc(auth.currentUser!.uid)
          .get();
      // print(uname1['firstName']);
      uname = uname1['firstName'].toString();
      return "null";
    } catch (e) {
      print(e.toString());
      return "null";
    }
  }

  // @override
  // void initState() {
  //   print(uname);
  //   setState(() {
  //     print(userName());
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userName(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Hello $uname"),
              actions: [
                DropdownButton(
                  items: [
                    DropdownMenuItem(
                      value: 'logout',
                      child: Container(
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.exit_to_app),
                            SizedBox(
                              width: 8,
                            ),
                            Text("Logout")
                          ],
                        ),
                      ),
                    ),
                  ],
                  onChanged: (itemIdentifier) {
                    if (itemIdentifier == 'logout') {
                      FirebaseAuth.instance.signOut();
                    }
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.purple[800],
                  ),
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
