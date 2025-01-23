import 'package:flutter/material.dart';
import 'package:skbwmember/theme/app_font.dart';
import 'package:skbwmember/utils/calendar_functions.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceCalendar extends StatelessWidget {
  final DateTime startDate;
  final DateTime expiryDate;
  final List<DateTime> presentDates;
  final DateTime focusedDay;

  const AttendanceCalendar({
    super.key,
    required this.startDate,
    required this.expiryDate,
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
          final theme = Theme.of(context).colorScheme;
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${day.day} ${monthNameFromInt(day.month)} ${day.year}',
                  style: const TextStyle(
                    fontFamily: AppFont.primaryFont,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Attendance was marked on',
                  style: TextStyle(
                      fontFamily: AppFont.primaryFont,
                      color: theme.onSurface.withAlpha(100)),
                ),
                Text(
                  time24to12(attendanceTime.hour, attendanceTime.minute),
                  style:
                      TextStyle(fontFamily: AppFont.primaryFont, fontSize: 20),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  DateTime? getAttendanceTimeForDay(DateTime day) {
    for (DateTime presentDate in presentDates) {
      if (presentDate.year == day.year &&
          presentDate.month == day.month &&
          presentDate.day == day.day) {
        return presentDate;
      }
    }
    return null;
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
          fontFamily: AppFont.logoFont,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    
    return TableCalendar(
      calendarStyle: CalendarStyle(
        outsideTextStyle: const TextStyle(fontFamily: AppFont.logoFont),
        defaultTextStyle: const TextStyle(fontFamily: AppFont.logoFont),
      ),
      focusedDay: focusedDay,
      firstDay: startDate,
      lastDay: expiryDate.isAfter(DateTime.now()) ? expiryDate : DateTime.now(),
      headerStyle: const HeaderStyle(
        titleTextStyle: TextStyle(fontFamily: AppFont.logoFont, fontSize: 20),
        formatButtonVisible: false,
        titleCentered: true,
        leftChevronVisible: false,
        rightChevronVisible: false,
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          if(day.weekday == 7) {
            return buildDayMarker(day, Colors.red.shade500, textColor: Colors.white);
          } else if(isPresent(day)){
            return GestureDetector(
              onTap: () => showAttendanceTimePopup(context, day),
              child: buildDayMarker(day, Colors.green, textColor: Colors.white),
            );
          } else if(expiryDate.isAfter(day)){
            return buildDayMarker(day, Colors.grey.shade800, textColor: Colors.white);
          } else {
            return buildDayMarker(day, Colors.transparent, textColor: theme.onSurface);
          }
        },
        todayBuilder: (context, day, focusedDay) {
          if(isPresent(day)) {
            return GestureDetector(
              onTap: () => showAttendanceTimePopup(context, day),
              child: buildDayMarker(day, Colors.green, isToday: true, textColor: Colors.white),
            );
          } else {
            return buildDayMarker(day, Colors.white, isToday: true, textColor: Colors.black);
          }
        },
      ),
    );
  }
}
