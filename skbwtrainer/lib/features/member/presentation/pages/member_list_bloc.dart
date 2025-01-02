import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skbwtrainer/features/member/data/firebase_member_repo.dart';
import 'package:skbwtrainer/features/member/domain/repository/member_repo.dart';
import 'package:skbwtrainer/features/member/presentation/cubits/member_cubit.dart';
import 'package:skbwtrainer/features/member/presentation/cubits/member_states.dart';
import 'package:skbwtrainer/themes/app_font.dart';
import 'package:skbwtrainer/utils/app_snack_bar.dart';

import 'member_list_page.dart';

class MemberListBloc extends StatelessWidget {
  final MemberRepo memberRepo = FireBaseMemberRepo();
  MemberListBloc({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) => MemberCubit(memberRepo: memberRepo)..getMembers(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'All members',
            style: TextStyle(
              fontFamily: AppFont.primaryFont,
              fontSize: 18,
            ),
          ),
        ),
        body: BlocConsumer<MemberCubit, MemberState>(
          builder: (context, state) {
            if (state is MemberLoading) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(color: theme.primary, size: 50),
              );
            } else if (state is MembersLoaded) {
              return MemberListPage(
                members: state.members,
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
