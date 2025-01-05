import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skbwtrainer/features/approval/presentation/cubits/approval_cubit.dart';
import 'package:skbwtrainer/features/approval/presentation/cubits/approval_states.dart';
import 'package:skbwtrainer/features/approval/presentation/pages/pending_member_page.dart';

import '../../../../themes/app_font.dart';
import '../../../../utils/app_snack_bar.dart';
import '../../data/firebase_approval_repo.dart';
import '../../domain/repositories/approval_repo.dart';

class PendingMemberBloc extends StatelessWidget {
  final String email;
  final ApprovalRepo approvalRepo = FirebaseApprovalRepo();
  PendingMemberBloc({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (context) =>
          ApprovalCubit(approvalRepo: approvalRepo)..getPendingMember(email),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'S.K. Body Works Member',
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
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: theme.primary, size: 50),
              );
            } else if (state is PendingMemberLoaded) {
              return PendingMemberPage(
                member: state.member,
              );
            } else if (state is ApprovalSuccess) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: TextStyle(fontFamily: AppFont.primaryFont),
                    ),
                    ElevatedButton(
                        child: Text(
                          'Go back',
                          style: TextStyle(fontFamily: AppFont.primaryFont),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Error loading member details.', style: TextStyle(fontFamily: AppFont.primaryFont)),
                    // retry button to reload the member details
                    ElevatedButton(
                      onPressed: () {
                        context.read<ApprovalCubit>().getPendingMember(email);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
          },
          listener: (context, state) {
            if (state is ApprovalError) {
              AppSnackBar.showError(
                  state.message, context);
            }
          },
        ),
      ),
    );
  }
}
