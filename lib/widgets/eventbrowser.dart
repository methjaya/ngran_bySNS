import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/pages/detail_page_event.dart';

class EventBrowser extends StatefulWidget {
  const EventBrowser({super.key});

  @override
  _EventBrowserState createState() => _EventBrowserState();
}

class _EventBrowserState extends State<EventBrowser> {
  Future<void> getEvents() async {
    try {
      var eventData = await FirebaseFirestore.instance
          .collection("events")
          .where("eventExpire", isGreaterThanOrEqualTo: Timestamp.now())
          .get();

      for (int x = 0; x < eventData.docs.length; x++) {
        if (eventData.docs.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('There Are No Events'),
              duration: Duration(seconds: 4),
            ),
          );
        }
        events.add(
          Event(
            image: eventData.docs[x]['img'].toString(),
            eName: eventData.docs[x]['name'].toString(),
            eDate: eventData.docs[x]['date'].toString(),
            eDesc: eventData.docs[x]['description'].toString(),
            eLocation: eventData.docs[x]['location'].toString(),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An Error Occurred When Getting Event Data'),
          duration: Duration(seconds: 4),
        ),
      );
    }
  }

  List<Event> events = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getEvents(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.black,
              backgroundColor: Colors.green[100],
              title: const Text("Events"),
            ),
            body: Center(
              child: SizedBox(
                width: 350,
                child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPageEvent(
                                events[index].eName,
                                events[index].eDate,
                                events[index].eLocation,
                                events[index].eDesc,
                                events[index].image),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            events[index].image,
                            width: 300,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}

class Event {
  String image;
  String eName;
  String eDesc;
  String eLocation;
  String eDate;

  Event({
    required this.image,
    required this.eName,
    required this.eDate,
    required this.eDesc,
    required this.eLocation,
  });
}
