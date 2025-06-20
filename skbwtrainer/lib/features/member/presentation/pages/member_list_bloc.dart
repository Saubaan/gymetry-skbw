import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skbwtrainer/features/member/data/firebase_member_repo.dart';
import 'package:skbwtrainer/features/member/domain/entities/attendance.dart';
import 'package:skbwtrainer/features/member/domain/entities/member.dart';
import 'package:skbwtrainer/features/member/domain/repository/member_repo.dart';
import 'package:skbwtrainer/features/member/presentation/cubits/member_cubit.dart';
import 'package:skbwtrainer/features/member/presentation/cubits/member_states.dart';
import 'package:skbwtrainer/utils/app_snack_bar.dart';

import '../../../../themes/app_font.dart';
import '../../../approval/presentation/components/request_notification.dart';
import 'member_list_page.dart';

class MemberListBloc extends StatelessWidget {
  final MemberRepo memberRepo = FirebaseMemberRepo();
  final List<Attendance>? attendance;
  MemberListBloc({super.key, this.attendance});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) => MemberCubit(memberRepo: memberRepo)..getMembers(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.secondary,
          centerTitle: true,
          title: Text(
            attendance == null? 'All members' : 'Today\'s attendance',
            style: TextStyle(
              fontFamily: AppFont.primaryFont,
              fontSize: 18,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: RequestNotification(),
            ),
          ],
        ),
        body: BlocConsumer<MemberCubit, MemberState>(
          builder: (context, state) {
            if (state is MemberLoading) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: theme.primary, size: 50),
              );
            } else if (state is MembersLoaded) {
              List<Member> members = state.members;
              if (attendance != null) {
                // only keep members who have attended today
                members = members.where((member) {
                  return attendance!.any((element) => element.memberId == member.uid);
                }).toList();
              }
              return MemberListPage(
                members: members,
              );
            } else {
              return const Center(
                child: Text('Error loading members'),
              );
            }
          },
          listener: (context, state) {
            if (state is MemberError) {
              AppSnackBar.showError(state.message, context);
            }
          },
        ),
      ),
    );
  }
}
