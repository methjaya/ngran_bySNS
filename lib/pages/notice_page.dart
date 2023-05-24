import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/admin/user_data.dart';

class NoticesListWidget extends StatefulWidget {
  const NoticesListWidget({super.key});

  @override
  State<NoticesListWidget> createState() => _NoticesListWidgetState();
}

class _NoticesListWidgetState extends State<NoticesListWidget> {
  List<Map<String, dynamic>> eventData = [];

  Future<void> getUserData() async {
    if (UserData.userRole == "student") {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("notices")
            .where("noticeExpire", isGreaterThanOrEqualTo: Timestamp.now())
            .where(
          "groups",
          arrayContainsAny: [
            UserData.userFaculty,
            UserData.userDegree,
            UserData.userBatch
          ],
        ).get();
        if (querySnapshot.docs.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('There Are No Notices'),
              duration: Duration(seconds: 4),
            ),
          );
        }
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          eventData.add(doc.data() as Map<String, dynamic>);
        }
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error Getting Notice Data'),
            duration: Duration(seconds: 60),
          ),
        );
      }
    } else {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("notices")
            .where("noticeExpire", isGreaterThanOrEqualTo: Timestamp.now())
            .get();

        if (querySnapshot.docs.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('There Are No Notices'),
              duration: Duration(seconds: 4),
            ),
          );
        }

        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          eventData.add(doc.data() as Map<String, dynamic>);
        }
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error Getting Notice Data'),
            duration: Duration(seconds: 60),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.green[100],
            title: const Text("Notices"),
          ),
          body: ListView.builder(
            itemCount: eventData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(eventData[index]['title']),
                        content: Flexible(
                          child: Text(
                            eventData[index]['description'].toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
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
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            eventData[index]['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            eventData[index]['summary'].toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
