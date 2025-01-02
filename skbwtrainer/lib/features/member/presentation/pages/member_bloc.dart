import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skbwtrainer/features/member/data/firebase_member_repo.dart';
import 'package:skbwtrainer/features/member/domain/repository/member_repo.dart';

import '../../../../themes/app_font.dart';
import '../../../../utils/app_snack_bar.dart';
import '../cubits/member_cubit.dart';
import '../cubits/member_states.dart';
import 'member_page.dart';

class MemberBloc extends StatelessWidget {
  final String id;
  final MemberRepo memberRepo = FireBaseMemberRepo();

  MemberBloc({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (context) => MemberCubit(memberRepo: memberRepo)..getMember(id),
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
        body: BlocConsumer<MemberCubit, MemberState>(
          builder: (context, state) {
            if (state is MemberLoading) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(color: theme.primary, size: 50),
              );
            } else if (state is MemberLoaded) {
              return MemberPage(
                member: state.member,
              );
            } else {
              return Center(
                child: Column(
                  children: [
                    const Text('Error loading member details.'),
                    // retry button to reload the member details
                    ElevatedButton(
                      onPressed: () {
                        context.read<MemberCubit>().getMember(id);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
          },
          listener: (context, state) {
            if (state is MemberError) {
              AppSnackBar.showError('An error occurred: ${state.message}', context);
            }
            if (state is MemberSuccess) {
              AppSnackBar.showSuccess(state.message, context);
            }
          },
        ),
      ),
    );
  }
}
