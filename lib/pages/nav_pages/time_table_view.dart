import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TimeTable extends StatefulWidget {
  const TimeTable({Key? key}) : super(key: key);

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  int currentPosition = 0;
  List<String> viewType = ['Day View', 'Week View', 'Month View'];

    Future<String> fetchData() async {
    var url = Uri.parse(
        'https://sheets.googleapis.com/v4/spreadsheets/1eYPsj8kZwNfA-AEjTGcHM8Iqeq7uSdwjP_hEpkN8Rx4/values/FOC?key=AIzaSyCljPBwMPw7cJT8e0-oLFTRN4v1Dz23GGM');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void changeViewType(int newIndex) {
    setState(() {
      currentPosition = newIndex;
    });
  }

  CalendarView getCalendarView() {
    if (currentPosition == 0) {
      return CalendarView.day;
    } else if (currentPosition == 1) {
      return CalendarView.week;
    } else if (currentPosition == 2) {
      return CalendarView.month;
    } else {
      return CalendarView.day;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Time Table',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  // Decrease the index and update the view type
                  int newIndex = currentPosition - 1;
                  if (newIndex < 0) newIndex = 0;
                  changeViewType(newIndex);
                },
                icon: const Icon(Icons.arrow_left_rounded),
                iconSize: 35.0,
              ),
              Text(
                viewType[currentPosition], // Display the current view type
                style: const TextStyle(fontSize: 18.0),
              ),
              IconButton(
                onPressed: () {
                  // Increase the index and update the view type
                  int newIndex = currentPosition + 1;
                  if (newIndex >= viewType.length) {
                    newIndex = viewType.length - 1;
                  }
                  changeViewType(newIndex);
                },
                icon: const Icon(Icons.arrow_right_rounded),
                iconSize: 35.0,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          
          FutureBuilder<String>(
            future: fetchData(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> map = jsonDecode(snapshot.data!);
                Map<String, dynamic> TData = {};

              for (int i = 0; i < map['values'][0].length; i++) {
                TData[map['values'][0][i]] = [          map['values'][1][i],
                map['values'][2][i]
                ];
                }

            List<Appointment> appointments = getAppointments(TData);

            return Expanded(
              child: SfCalendar(
                key: ValueKey(currentPosition),
                view: getCalendarView(),
                //dataSource: LectureSchedule(appointments),
              ),
      );
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    } else {
      return const CircularProgressIndicator();
    }
  },
),
        ],
      ),
    );
  }
}

List<Appointment> getAppointments(Map<String, dynamic> events) {
  List<Appointment> appointments = [];

  events.forEach((dateString, eventInfo) {
    DateTime date = DateFormat('d-MMM-yy').parse(dateString);
    for (String info in eventInfo) {
      List<String> parts = info.trim().split(' I ');
      if (parts.length >= 3) {
        String subject = parts[0];
        String startString = parts[1];
        String endString = parts[2];
        DateTime start = DateFormat('hh:mma').parse(startString, date as bool);
        DateTime end = DateFormat('hh:mma').parse(endString, date as bool);
        appointments.add(Appointment(
          startTime: start,
          endTime: end,
          subject: subject,
          color: Colors.blue,
        ));
      }
    }
  });

  return appointments;
}

class LectureSchedule extends CalendarDataSource {
  LectureSchedule(List<Appointment> source) {
    appointments = source;
  }
}
