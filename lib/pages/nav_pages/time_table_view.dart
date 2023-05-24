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
  DateTime? selectedDate; // Store the selected date

  Future<Map<String, dynamic>> fetchData() async {
    var url = Uri.parse(
        'https://sheets.googleapis.com/v4/spreadsheets/1eYPsj8kZwNfA-AEjTGcHM8Iqeq7uSdwjP_hEpkN8Rx4/values/FOC?key=AIzaSyCljPBwMPw7cJT8e0-oLFTRN4v1Dz23GGM');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
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
        backgroundColor: const Color.fromRGBO(73, 141, 56, 1),
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
            FutureBuilder<Map<String, dynamic>>(
            future: fetchData(),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.hasData) {
                  Map<String, dynamic> data = snapshot.data!;
                  List<Appointment> appointments = getAppointments(data);

                  return Expanded(
                  child: SfCalendar(
                    key: ValueKey(currentPosition),
                    view: getCalendarView(),
                    dataSource: LectureSchedule(appointments),
                    initialDisplayDate: selectedDate, // Set initial display date
                    timeSlotViewSettings: const TimeSlotViewSettings(
                      startHour: 6, // Set the start time to 6AM since realistically there will not be any lectures / events scheduled before that
                      endHour: 24,
                    ),
                    onTap: (CalendarTapDetails details) {
                      if (details.targetElement == CalendarElement.calendarCell &&
                          getCalendarView() == CalendarView.month) {
                        // Switch to day view and update selected date
                        setState(() {
                          currentPosition = 0;
                          selectedDate = details.date!;
                        });
                      }
                    },
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

  if (events.containsKey('values')) {
    List<dynamic> values = events['values'];
    if (values.length > 1) {
      for (int i = 1; i < values.length; i++) {
        List<dynamic> dataRow = values[i];
        if (dataRow.length >= 5) {
          String subject = dataRow[1];
          String startString = dataRow[2];
          String endString = dataRow[3];
          String location = dataRow[4];

          DateTime start = DateFormat('dd/MM/yyyy HH:mm').parse(startString);
          DateTime end = DateFormat('dd/MM/yyyy HH:mm').parse(endString);

          Appointment appointment = Appointment(
            startTime: start,
            endTime: end,
            subject: "$subject at $location",
            color: const Color.fromRGBO(73, 141, 56, 1),
          );

          appointments.add(appointment);
        }
      }
    }
  }

  return appointments;
}

class LectureSchedule extends CalendarDataSource {
  LectureSchedule(List<Appointment> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments?[index].startTime!;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments?[index].endTime!;
  }
}
