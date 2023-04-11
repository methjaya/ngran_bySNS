import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({Key? key}) : super(key: key);

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  int currentPosition = 0;
  List<String> viewType = ['Day View', 'Week View', 'Month View'];

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
          Expanded(
            child: SfCalendar(
              key: ValueKey(currentPosition),
              view: getCalendarView(),
            ),
          ),
        ],
      ),
    );
  }
}