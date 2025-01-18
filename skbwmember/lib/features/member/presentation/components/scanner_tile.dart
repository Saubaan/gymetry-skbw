import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skbwmember/components/title_card.dart';
import 'package:skbwmember/features/member/data/firebase_member_repo.dart';
import 'package:skbwmember/features/member/domain/repositories/member_repo.dart';
import 'package:skbwmember/features/member/presentation/components/scanner_button.dart';
import 'package:skbwmember/features/member/presentation/cubits/attendance_cubit.dart';
import 'package:skbwmember/features/member/presentation/cubits/attendance_states.dart';
import 'package:skbwmember/utils/app_snack_bar.dart';

import '../cubits/member_cubit.dart';

class ScannerTile extends StatefulWidget {
  final String memberUID;
  const ScannerTile({super.key, required this.memberUID});

  @override
  State<ScannerTile> createState() => _ScannerTileState();
}

class _ScannerTileState extends State<ScannerTile> {
  final MemberRepo memberRepo = FirebaseMemberRepo();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) => AttendanceCubit(memberRepo: memberRepo)
        ..isTodayMarked(widget.memberUID),
      child: TitleCard(
        title: 'Mark Attendance',
        children: [
          BlocConsumer<AttendanceCubit, AttendanceState>(
            builder: (context, state) {
              if (state is AttendanceLoading) {
                return LoadingAnimationWidget.staggeredDotsWave(
                    color: theme.primary, size: 50);
              } else if (state is AttendanceTodayMarked) {
                return ScannerButton(memberUID: widget.memberUID, isMarked: state.isMarked);
              } else {
                return Text('Something went wrong');
              }
            },
            listener: (context, state) {
              if (state is AttendanceMarked) {
                AppSnackBar.showSuccess('Attendance marked successfully', context);
                final memberCubit = context.read<MemberCubit>();
                memberCubit.getMember(widget.memberUID);
              }
              if (state is AttendanceError) {
                final message = state.message.replaceAll('Exception:', '');
                AppSnackBar.showError(message, context);
              }
            },
          ),
        ],
      ),
    );
  }
}
