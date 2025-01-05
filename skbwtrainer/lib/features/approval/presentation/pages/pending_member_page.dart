import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/components/primary_button.dart';
import 'package:skbwtrainer/components/title_card.dart';
import 'package:skbwtrainer/features/approval/domain/entities/pending_member.dart';

import '../../../../themes/app_font.dart';
import '../../../../utils/calendar_functions.dart';
import '../cubits/approval_cubit.dart';

class PendingMemberPage extends StatefulWidget {
  final PendingMember member;
  const PendingMemberPage({super.key, required this.member});

  @override
  State<PendingMemberPage> createState() => _PendingMemberPageState();
}

class _PendingMemberPageState extends State<PendingMemberPage> {

  void showConfirmDialog(BuildContext context, void Function()? onTap, {String title = 'Are you sure?', String content = 'This action cannot be undone'}) {
    final theme = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: AppFont.primaryFont,
              fontSize: 16,
              color: theme.onSurface,
            ),
          ),
          content: Text(
            content,
            style: TextStyle(
              fontFamily: AppFont.primaryFont,
              fontSize: 14,
            ),
          ),
          actions: [
            PrimaryButton(
              text: 'Cancel',
              onTap: () => Navigator.pop(context),
              color: theme.secondary.withAlpha(200),
              textColor: theme.onSecondary,
            ),
            SizedBox(height: 5),
            PrimaryButton(
              color: theme.primary,
              textColor: theme.onPrimary,
              text: 'Ok',
              onTap: () {
                onTap!();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void approveMember() {
    final approvalCubit = context.read<ApprovalCubit>();
    approvalCubit.approveMember(widget.member);
  }

  void rejectMember() {
    final approvalCubit = context.read<ApprovalCubit>();
    approvalCubit.rejectMember(widget.member.email);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TitleCard(
              title: 'New Member Details',
              children: [
                Divider(),
                //member details
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.member.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.member.email,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            widget.member.phone,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Request on: ${widget.member.createdAt.day} ${monthNameFromInt(widget.member.createdAt.month)} ${widget.member.createdAt.year}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Subscription duration: ${widget.member.expiryDate.difference(widget.member.createdAt).inDays} days',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            TitleCard(
              children: [
                PrimaryButton(
                  text: 'Approve',
                  onTap: () {
                    showConfirmDialog(context, approveMember, title: 'Approve Member', content: 'This will add the member to the gym with subscription of ${widget.member.expiryDate.difference(widget.member.createdAt).inDays} days');
                  },
                ),

                SizedBox(height: 5),

                PrimaryButton(
                  text: 'Reject',
                  onTap: () {
                    showConfirmDialog(context, rejectMember, title: 'Reject Member', content: 'This will remove the member from the pending list');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
