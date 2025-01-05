import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/features/approval/presentation/pages/approval_list_bloc.dart';
import 'package:skbwtrainer/themes/app_font.dart';
import 'package:skbwtrainer/utils/navigation.dart';

import '../../data/firebase_approval_repo.dart';
import '../../domain/repositories/approval_repo.dart';
import '../cubits/approval_cubit.dart';
import '../cubits/approval_states.dart';

class RequestNotification extends StatelessWidget {
  final ApprovalRepo approvalRepo = FirebaseApprovalRepo();

  RequestNotification({super.key});

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
            return state.number > 0?InkWell(
              onTap: () async {
                final approvalCubit = context.read<ApprovalCubit>();
                await pushPage(context, ApprovalListBloc(), 1);
                approvalCubit.getNumber();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.onSecondary,
                ),
                child: Text(
                  state.number.toString(),
                  style: TextStyle(
                    color: theme.secondary,
                    fontFamily: AppFont.primaryFont,
                  ),
                ),
              ),
            ) : const SizedBox();
          } else {
            return const SizedBox();
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}
