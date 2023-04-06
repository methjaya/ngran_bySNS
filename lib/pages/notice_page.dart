import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/widgets/notice.dart';

class NoticesListWidget extends StatelessWidget {
  List<Map<String, dynamic>> eventData = [];

  Future<List<DocumentSnapshot>> getDataWithWhereClause(
      String collectionName, String field, dynamic value) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(collectionName)
        .where(field, isGreaterThanOrEqualTo: value)
        .get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      eventData.add(doc.data() as Map<String, dynamic>);
    }
    print("Length is : ${eventData.length}" + "TIME IS : ${Timestamp.now()}");

    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            getDataWithWhereClause("notices", "noticeExpire", Timestamp.now()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              eventData[index]['summary'].toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        });
  }
}
