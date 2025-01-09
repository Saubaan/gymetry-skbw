import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skbwtrainer/features/member/data/firebase_member_repo.dart';
import 'package:skbwtrainer/features/member/domain/repository/member_repo.dart';
import 'package:skbwtrainer/features/member/presentation/cubits/attendance_cubit.dart';
import 'package:skbwtrainer/features/member/presentation/cubits/attendance_states.dart';

import '../../../../themes/app_font.dart';
import '../../../../utils/calendar_functions.dart';

class DayAnalyticBloc extends StatelessWidget {
  final MemberRepo memberRepo = FireBaseMemberRepo();
  DayAnalyticBloc({super.key});

  String getLastVisitTime(DateTime dateTime) {
    return time24to12(dateTime.hour, dateTime.minute);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) =>
          AttendanceCubit(memberRepo: memberRepo)..getTodayAttendance(),
      child: BlocConsumer<AttendanceCubit, AttendanceState>(
        builder: (context, state) {
          if (state is AttendanceLoading) {
            return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
              color: Theme.of(context).colorScheme.primary,
              size: 50,
            ));
          } else if (state is AttendanceLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(
                  'Total visits today: ${state.attendance.length}',
                  style: TextStyle(
                    fontFamily: AppFont.primaryFont,
                    color: theme.onSecondary.withAlpha(150),
                  ),
                ),
                SizedBox(height: 5),
                state.attendance.isNotEmpty
                    ? Text(
                        'Last visit today: ${getLastVisitTime(state.attendance.last.date)}',
                        style: TextStyle(
                          fontFamily: AppFont.primaryFont,
                          color: theme.onSecondary.withAlpha(150),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            );
          } else if (state is AttendanceError) {
            return Center(
              child: Text(state.message),
            );
          }
          return const SizedBox.shrink();
        },
        listener: (context, state) {},
      ),
    );
  }
}
