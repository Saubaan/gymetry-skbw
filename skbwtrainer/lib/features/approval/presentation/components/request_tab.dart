import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/components/primary_button.dart';
import 'package:skbwtrainer/components/title_card.dart';
import 'package:skbwtrainer/features/approval/data/firebase_approval_repo.dart';
import 'package:skbwtrainer/features/approval/domain/repositories/approval_repo.dart';
import 'package:skbwtrainer/features/approval/presentation/cubits/approval_cubit.dart';
import 'package:skbwtrainer/features/approval/presentation/cubits/approval_states.dart';
import 'package:skbwtrainer/features/approval/presentation/pages/approval_list_bloc.dart';
import 'package:skbwtrainer/utils/navigation.dart';

class RequestTab extends StatelessWidget {
  final ApprovalRepo approvalRepo = FirebaseApprovalRepo();

  RequestTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (context) =>
          ApprovalCubit(approvalRepo: approvalRepo)..getNumber(),
      child: BlocConsumer<ApprovalCubit, ApprovalState>(
        builder: (context, state) {
          if (state is ApprovalLoading) {
            return SizedBox();
          } else if (state is NumberLoaded) {
            return state.number > 0
                ? Column(
                    children: [
                      TitleCard(
                        title: '${state.number} pending requests',
                        children: [
                          PrimaryButton(
                              text: 'View requests',
                              onTap: () async {
                                final approvalCubit =
                                    context.read<ApprovalCubit>();
                                await pushPage(context, ApprovalListBloc(), 1);
                                approvalCubit.getNumber();
                              },
                            color: theme.onSecondary,
                            textColor: theme.secondary,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  )
                : const SizedBox();
          } else {
            return const SizedBox();
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}
