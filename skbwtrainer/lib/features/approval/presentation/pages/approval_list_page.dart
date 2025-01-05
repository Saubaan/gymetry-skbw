import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/features/approval/domain/entities/pending_member.dart';
import 'package:skbwtrainer/features/approval/presentation/pages/pending_member_bloc.dart';
import 'package:skbwtrainer/utils/navigation.dart';

import '../../../../themes/app_font.dart';
import '../cubits/approval_cubit.dart';

class ApprovalListPage extends StatefulWidget {
  final List<PendingMember> members;

  const ApprovalListPage({super.key, required this.members});

  @override
  State<ApprovalListPage> createState() => _ApprovalListPageState();
}

class _ApprovalListPageState extends State<ApprovalListPage> {
  String getMembershipText(DateTime createdAt, DateTime expiryDate) {
    final days = expiryDate.difference(createdAt).inDays;
    return 'Membership for $days days';
  }

  @override
  Widget build(BuildContext context) {
    final double sWidth = MediaQuery.of(context).size.width;
    final double sHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.secondary,
                borderRadius: BorderRadius.circular(sWidth / 30),
              ),
              height: sHeight,
              child: widget.members.isEmpty
                  ? Center(
                      child: Text(
                        'No pending members',
                        style: TextStyle(
                          fontFamily: AppFont.primaryFont,
                          color: theme.onSecondary,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: widget.members.length,
                      itemBuilder: (context, index) {
                        final member = widget.members[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.surface,
                              borderRadius: BorderRadius.circular(sWidth / 30),
                            ),
                            child: ListTile(
                              title: Text(member.name,
                                  style: TextStyle(
                                      fontFamily: AppFont.primaryFont)),
                              subtitle: Text(
                                getMembershipText(
                                    member.createdAt, member.expiryDate),
                                style: TextStyle(
                                  color: theme.onSecondary.withAlpha(150),
                                  fontFamily: AppFont.logoFont,
                                ),
                              ),
                              onTap: () async {
                                final approvalCubit =
                                    context.read<ApprovalCubit>();
                                await pushPage(
                                    context,
                                    PendingMemberBloc(
                                      email: member.email,
                                    ),
                                    1);
                                approvalCubit.getPendingMembers();
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
