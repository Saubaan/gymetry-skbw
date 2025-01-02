import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skbwtrainer/features/member/data/firebase_member_repo.dart';
import 'package:skbwtrainer/features/member/domain/repository/member_repo.dart';
import 'package:skbwtrainer/features/member/presentation/components/attendance_calendar.dart';
import 'package:skbwtrainer/features/member/presentation/cubits/attendance_cubit.dart';
import 'package:skbwtrainer/features/member/presentation/cubits/attendance_states.dart';

class AttendanceCalendarBloc extends StatelessWidget {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime focusedDay;
  final MemberRepo memberRepo = FireBaseMemberRepo();

  AttendanceCalendarBloc(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.focusedDay, required this.id});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) => AttendanceCubit(memberRepo: memberRepo)..getAttendance(id),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: theme.onSurface.withAlpha(20),
          border: Border.all(
            color: theme.onSurface.withAlpha(50),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: BlocConsumer<AttendanceCubit, AttendanceState>(
            builder: (context, state) {
          if (state is AttendanceLoaded) {
            final presentDates = state.attendance.map((e) => e.date).toList();
            return AttendanceCalendar(
                startDate: startDate,
                expiryDate: endDate,
                presentDates: presentDates,
                focusedDay: focusedDay);
          } else {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(color: theme.primary, size: 50),
            );
          }
        }, listener: (context, state) {
          if (state is AttendanceError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        }),
      ),
    );
  }
}
