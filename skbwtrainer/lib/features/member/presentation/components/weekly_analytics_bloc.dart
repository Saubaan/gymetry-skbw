import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skbwtrainer/features/member/data/firebase_member_repo.dart';
import 'package:skbwtrainer/features/member/domain/repository/member_repo.dart';
import 'package:skbwtrainer/features/member/presentation/components/weekly_analytics.dart';
import 'package:skbwtrainer/features/member/presentation/cubits/attendance_cubit.dart';

import '../cubits/attendance_states.dart';

class WeeklyAnalyticsBloc extends StatelessWidget {
  final MemberRepo memberRepo = FireBaseMemberRepo();

  WeeklyAnalyticsBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AttendanceCubit(memberRepo: memberRepo)..getWeekAttendancePerDay(),
      child: BlocConsumer<AttendanceCubit, AttendanceState>(
        builder: (context, state) {
          if (state is AttendanceLoading) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Theme.of(context).colorScheme.primary,
                size: 50,
              ),
            );
          } else if (state is AttendanceWeekLoaded) {
            return WeeklyAnalytics(weekAttendance: state.attendance);
          } else {
            return Center(child: Text('Error Loading Data'));
          }
        },
        listener: (context, state) {
          if (state is AttendanceError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
      ),
    );
  }
}
