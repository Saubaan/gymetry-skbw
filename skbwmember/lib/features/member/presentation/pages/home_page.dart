import 'package:flutter/material.dart';
import 'package:skbwmember/components/title_card.dart';
import 'package:skbwmember/features/member/domain/entities/member.dart';
import 'package:skbwmember/features/member/presentation/components/attendance_calendar_bloc.dart';
import 'package:skbwmember/features/member/presentation/components/scanner_tile.dart';
import 'package:skbwmember/theme/app_font.dart';
import 'package:skbwmember/utils/calendar_functions.dart';

class HomePage extends StatefulWidget {
  final Member member;
  const HomePage({super.key, required this.member});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  getMemberShipText() {
    if (widget.member.isPaused) {
      return 'Membership paused on ${dateTimeToDate(widget.member.pauseStartDate)}';
    } else {
      if (widget.member.expiryDate.isAfter(DateTime.now())) {
        return 'Membership active until ${dateTimeToDate(widget.member.expiryDate)}';
      } else {
        return 'Membership expired ${widget.member.expiryDate.difference(DateTime.now()).inDays} days ago';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TitleCard(
              title: 'Hello there!',
              childrenAlign: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.member.name,
                  style:
                      TextStyle(fontSize: 20, fontFamily: AppFont.primaryFont),
                ),
                Text(
                  getMemberShipText(),
                  style: TextStyle(
                    color: widget.member.isPaused
                        ? theme.onSecondary.withAlpha(150)
                        : widget.member.expiryDate.isAfter(DateTime.now())
                            ? theme.primary
                            : theme.error,
                    fontSize: 13,
                    fontFamily: AppFont.logoFont,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            TitleCard(
              title: 'Attendance Calendar',
              children: [
                AttendanceCalendarBloc(
                  startDate: widget.member.createdAt,
                  endDate: widget.member.expiryDate,
                  focusedDay: DateTime.now(),
                  id: widget.member.uid,
                ),
              ],
            ),
            SizedBox(height: 10),

            ScannerTile(memberUID: widget.member.uid),
          ],
        ),
      ),
    );
  }
}
