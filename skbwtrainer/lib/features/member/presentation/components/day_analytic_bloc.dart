import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skbwtrainer/components/primary_button.dart';
import 'package:skbwtrainer/features/member/data/firebase_member_repo.dart';
import 'package:skbwtrainer/features/member/domain/repository/member_repo.dart';
import 'package:skbwtrainer/features/member/presentation/cubits/attendance_cubit.dart';
import 'package:skbwtrainer/features/member/presentation/cubits/attendance_states.dart';
import 'package:skbwtrainer/features/member/presentation/pages/member_list_bloc.dart';
import 'package:skbwtrainer/utils/navigation.dart';

import '../../../../themes/app_font.dart';
import '../../../../utils/calendar_functions.dart';

class DayAnalyticBloc extends StatelessWidget {
  DayAnalyticBloc({super.key});

  final MemberRepo memberRepo = FirebaseMemberRepo();

  String getLastVisitTime(DateTime dateTime) {
    return time24to12(dateTime.hour, dateTime.minute);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final sWidth = MediaQuery.of(context).size.width;
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
              children: [
                SizedBox(height: 5),
                Text(
                  'Total visits today: ${state.attendance.length}',
                  style: TextStyle(
                    fontFamily: AppFont.primaryFont,
                    color: theme.primary.withAlpha(250),
                  ),
                ),
                SizedBox(height: 5),
                state.attendance.isNotEmpty
                    ? Column(
                        children: [
                          Text(
                            'Last visit today: ${getLastVisitTime(state.attendance.last.date)}',
                            style: TextStyle(
                              fontFamily: AppFont.primaryFont,
                              color: theme.onSecondary.withAlpha(150),
                            ),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                SizedBox(height: 10),
                SizedBox(
                  width: sWidth * 0.8,
                  child: PrimaryButton(
                    text: 'View Visitors',
                    onTap: () {
                      pushPage(
                          context,
                          MemberListBloc(
                            attendance: state.attendance,
                          ),
                          1);
                    },
                  ),
                ),
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
