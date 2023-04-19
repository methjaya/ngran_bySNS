import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/admin/user_data.dart';
import 'package:flutter_firebase_test/widgets/notice.dart';

class NoticesListWidget extends StatefulWidget {
  @override
  State<NoticesListWidget> createState() => _NoticesListWidgetState();
}

class _NoticesListWidgetState extends State<NoticesListWidget> {
  List<Map<String, dynamic>> eventData = [];

  Future<void> getDataWithWhereClause() async {
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
        print("empty");
      } else {
        print("not empty");
      }
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        eventData.add(doc.data() as Map<String, dynamic>);
      }
      print(UserData.userFaculty);
      print(UserData.userDegree);
      print(UserData.userBatch);
      print("Length is : ${eventData.length}" + "TIME IS : ${Timestamp.now()}");
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error Getting Data : ${e.toString()}'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDataWithWhereClause(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: eventData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  // Handle click event here
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoticeWidget(
                          eventData[index]['title'].toString(),
                          eventData[index]['description'].toString()),
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
        );
      },
    );
  }
}
