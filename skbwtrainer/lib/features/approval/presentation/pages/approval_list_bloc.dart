import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skbwtrainer/features/approval/data/firebase_approval_repo.dart';
import 'package:skbwtrainer/features/approval/domain/repositories/approval_repo.dart';
import 'package:skbwtrainer/features/approval/presentation/cubits/approval_cubit.dart';
import 'package:skbwtrainer/features/approval/presentation/cubits/approval_states.dart';

import '../../../../themes/app_font.dart';
import '../../../../utils/app_snack_bar.dart';
import 'approval_list_page.dart';

class ApprovalListBloc extends StatelessWidget {
  final ApprovalRepo approvalRepo = FirebaseApprovalRepo();

  ApprovalListBloc({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (context) => ApprovalCubit(approvalRepo: approvalRepo)..getPendingMembers(),
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
        body: BlocConsumer<ApprovalCubit, ApprovalState>(
          builder: (context, state) {
            if (state is ApprovalLoading) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(color: theme.primary, size: 50),
              );
            } else if (state is PendingMembersLoaded) {
              return ApprovalListPage(
                members: state.members,
              );
            } else {
              return const Center(
                child: Text('Error loading members'),
              );
            }
          },
          listener: (context, state) {
            if (state is ApprovalError) {
              AppSnackBar.showError(state.message, context);
            }
          },
        ),
      ),
    );
  }
}
