import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceCalendar extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final List<DateTime> presentDates;
  final DateTime focusedDay;

  const AttendanceCalendar({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.presentDates,
    required this.focusedDay,
  });

  bool isPresent(DateTime day) {
    return presentDates.any((presentDate) =>
        presentDate.year == day.year &&
        presentDate.month == day.month &&
        presentDate.day == day.day);
  }

  void showAttendanceTimePopup(BuildContext context, DateTime day) {
    DateTime? attendanceTime = getAttendanceTimeForDay(day);

    if (attendanceTime != null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Attendance for ${day.day}/${day.month}/${day.year}'),
            content: Text(
                'Attendance was marked at ${attendanceTime.hour}:${attendanceTime.minute}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  DateTime? getAttendanceTimeForDay(DateTime day) {
    return presentDates.firstWhere(
        (presentDate) =>
            presentDate.year == day.year &&
            presentDate.month == day.month &&
            presentDate.day == day.day,
        orElse: () => null as DateTime);
  }

  Widget buildDayMarker(DateTime day, Color color,
      {Color textColor = Colors.black38, bool isToday = false}) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      width: 40,
      height: 40,
      alignment: Alignment.center,
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarStyle: CalendarStyle(
        outsideTextStyle: const TextStyle(fontFamily: "Brigade"),
        defaultTextStyle: const TextStyle(fontFamily: "Brigade"),
        todayDecoration: BoxDecoration(
          color: Colors.blue.withAlpha(50),
          shape: BoxShape.circle,
        ),
      ),
      focusedDay: focusedDay,
      firstDay: startDate,
      lastDay: endDate,
      headerStyle: const HeaderStyle(
        titleTextStyle: TextStyle(fontFamily: "Brigade", fontSize: 20),
        formatButtonVisible: false,
        titleCentered: true,
        leftChevronVisible: false,
        rightChevronVisible: false,
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          return isPresent(day)
              ? GestureDetector(
                  onTap: () => showAttendanceTimePopup(context, day),
                  child: buildDayMarker(day, Colors.green,
                      textColor: Colors.white),
                )
              : buildDayMarker(day, Colors.grey, textColor: Colors.white);
        },
        todayBuilder: (context, day, focusedDay) {
          return isPresent(day)
              ? GestureDetector(
                  onTap: () => showAttendanceTimePopup(context, day),
                  child: buildDayMarker(day, Colors.green,
                      isToday: true, textColor: Colors.white),
                )
              : buildDayMarker(day, Colors.white,
                  isToday: true, textColor: Colors.black);
        },
      ),
    );
  }
}
