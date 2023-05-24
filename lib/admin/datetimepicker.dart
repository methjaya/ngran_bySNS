import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({super.key});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime dateTime = DateTime(2023, 04, 06, 15, 45);

  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(14),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "DateTime Picker",
                style: TextStyle(fontSize: 28),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      child: Text(
                          '${dateTime.year}/${dateTime.month}/${dateTime.day}'),
                      onPressed: () async {
                        final date = datePick();

                        if (date == null) return;

                        final dateTimeNew = DateTime(
                            dateTime.year,
                            dateTime.month,
                            dateTime.day,
                            dateTime.hour,
                            dateTime.minute);

                        setState(
                          () {
                            dateTime = date as DateTime;
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      child: Text('$hours : $minutes'),
                      onPressed: () async {
                        final time = await timePick();

                        if (time == null) return;

                        final dateTimeNew = DateTime(
                            dateTime.year,
                            dateTime.month,
                            dateTime.day,
                            time.hour,
                            time.minute);

                        print(dateTime);

                        setState(() {
                          dateTime = dateTimeNew;
                        });

                        print(dateTime);
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> datePick() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2015),
      lastDate: DateTime(2100));

  Future<TimeOfDay?> timePick() =>
      showTimePicker(context: context, initialTime: TimeOfDay.now());
}
