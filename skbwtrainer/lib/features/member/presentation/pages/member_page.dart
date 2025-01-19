import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/components/primary_button.dart';
import 'package:skbwtrainer/components/title_card.dart';
import 'package:skbwtrainer/features/member/domain/entities/member.dart';
import 'package:skbwtrainer/features/member/presentation/components/attendance_calendar_bloc.dart';
import 'package:skbwtrainer/utils/app_snack_bar.dart';
import 'package:skbwtrainer/utils/calendar_functions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../themes/app_font.dart';
import '../cubits/member_cubit.dart';

class MemberPage extends StatefulWidget {
  final Member member;

  const MemberPage({super.key, required this.member});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class Subscription {
  final String name;
  final String duration;

  Subscription(this.name, this.duration);
}

class _MemberPageState extends State<MemberPage> {
  Future<void> launchDialer(String phoneNumber) async {
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  Future<String?> showSubscriptionDialog(BuildContext context) async {
    final List<Subscription> subscriptions = [
      Subscription('1 Month', '30'),
      Subscription('3 Months', '90'),
      Subscription('6 Months', '180'),
      Subscription('1 Year', '365'),
    ];

    String? selectedValue;

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final theme = Theme.of(context).colorScheme;
        return AlertDialog(
          clipBehavior: Clip.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            'Select Subscription',
            style: TextStyle(
              fontFamily: AppFont.primaryFont,
              fontSize: 16,
            ),
          ),
          content: DropdownButtonFormField<String>(
            style: TextStyle(
                fontSize: 14,
                fontFamily: AppFont.primaryFont,
                color: theme.onSecondary),
            hint: Text('None selected',
                style:
                    TextStyle(fontSize: 14, fontFamily: AppFont.primaryFont)),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            value: selectedValue, // Initial value
            items: subscriptions
                .map((subscription) => DropdownMenuItem<String>(
                      value: subscription.duration,
                      child: Text(subscription.name),
                    ))
                .toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue;
              });
            },
            validator: (value) =>
                value == null ? 'Please select an option' : null,
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
              text: 'Ok',
              onTap: () => Navigator.pop(context, selectedValue),
              color: theme.secondary.withAlpha(200),
              textColor: theme.onSecondary,
            ),
          ],
        );
      },
    );
  }

  void showConfirmDeleteDialog(BuildContext context, void Function()? onTap,
      {String title = 'Are you sure?',
      String content = 'This action cannot be undone'}) {
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
              color: theme.error,
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
              color: theme.error,
              textColor: theme.onError,
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

  void removeMember() async {
    final memberCubit = context.read<MemberCubit>();

    memberCubit.deleteMember(widget.member.uid);
    AppSnackBar.showSuccess('Member removed successfully', context);
    Navigator.pop(context);
  }

  void pauseSubscription() async {
    final DateTime now = DateTime.now();
    if (widget.member.expiryDate.isBefore(now)) {
      AppSnackBar.showError('Subscription has already expired', context);
      return;
    } else {
      final memberCubit = context.read<MemberCubit>();

      Member pausedMember = widget.member.copyWith(
        isPaused: true,
        pauseStartDate: DateTime(now.year, now.month, now.day),
      );

      memberCubit.updateMember(
          pausedMember, 'Subscription paused successfully');
    }
  }

  void resumeSubscription() async {
    final memberCubit = context.read<MemberCubit>();
    final DateTime now = DateTime.now();
    final DateTime newExpiryDate = widget.member.expiryDate.add(
        Duration(days: now.difference(widget.member.pauseStartDate).inDays));

    Member resumedMember = widget.member.copyWith(
      expiryDate: newExpiryDate,
      isPaused: false,
    );

    memberCubit.updateMember(
        resumedMember, 'Subscription resumed successfully');
  }

  void extendSubscription(String duration) async {
    final memberCubit = context.read<MemberCubit>();
    final DateTime newExpiryDate =
        widget.member.expiryDate.add(Duration(days: int.parse(duration)));

    Member extendedMember = widget.member.copyWith(
      expiryDate: newExpiryDate,
    );

    try {
      memberCubit.updateMember(
        extendedMember,
        'Subscription extended successfully',
      );
    } on Exception catch (e) {
      AppSnackBar.showError('An error occurred: $e', context);
    }
  }

  void reduceSubscription(String duration) async {
    final memberCubit = context.read<MemberCubit>();
    if (widget.member.expiryDate.isBefore(DateTime.now())) {
      AppSnackBar.showError('Subscription has already expired', context);
      return;
    } else {
      final DateTime newExpiryDate = widget.member.expiryDate
          .subtract(Duration(days: int.parse(duration)));

      Member reducedMember = widget.member.copyWith(
        expiryDate: newExpiryDate,
      );

      try {
        memberCubit.updateMember(
          reducedMember,
          'Subscription reduced successfully',
        );
      } on Exception catch (e) {
        AppSnackBar.showError('An error occurred: $e', context);
      }
    }
  }

  void revokeSubscription() async {
    final memberCubit = context.read<MemberCubit>();
    final DateTime newExpiryDate = DateTime.now();

    Member revokedMember = widget.member.copyWith(
      expiryDate: newExpiryDate,
      isPaused: false,
    );

    try {
      memberCubit.updateMember(
        revokedMember,
        'Subscription revoked successfully',
      );
    } on Exception catch (e) {
      AppSnackBar.showError('An error occurred: $e', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // a title card to display the member's details
            TitleCard(
              title: 'Member Details',
              childrenAlign: CrossAxisAlignment.start,
              children: [
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // display the member's name, email, phone number and subscription expiry date
                      Text(
                        widget.member.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: AppFont.primaryFont,
                        ),
                      ),
                      Text(
                        'Email: ${widget.member.email}',
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.onSecondary.withAlpha(150),
                          fontFamily: AppFont.logoFont,
                        ),
                      ),
                      Text(
                        'Phone: ${widget.member.phone}',
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.onSecondary.withAlpha(150),
                          fontFamily: AppFont.logoFont,
                        ),
                      ),
                      Text(
                        'Joined on: ${dateTimeToDate(widget.member.createdAt)}',
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.onSecondary.withAlpha(150),
                          fontFamily: AppFont.logoFont,
                        ),
                      ),
                    ],
                  ),
                ),
                // a button to launch the default phone app and dial the number on the dialer
                PrimaryButton(
                  text: 'Call ${widget.member.phone}',
                  color: theme.primary,
                  textColor: theme.onPrimary,
                  onTap: () {
                    try {
                      launchDialer(widget.member.phone);
                    } catch (e) {
                      AppSnackBar.showError("Couldn't launch dialer", context);
                    }
                  },
                ),
              ],
            ),

            SizedBox(height: 10),
            // title card to display the status of the subscription
            TitleCard(
              childrenAlign: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.member.isPaused
                                ? 'Subscription Paused'
                                : widget.member.expiryDate
                                        .isAfter(DateTime.now())
                                    ? 'Subscription Active'
                                    : 'Subscription Expired',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: AppFont.primaryFont,
                              color: widget.member.expiryDate
                                      .isAfter(DateTime.now())
                                  ? theme.onSecondary
                                  : theme.error,
                            ),
                          ),
                          Text(
                            widget.member.isPaused
                                ? 'Paused on: ${dateTimeToDate(widget.member.pauseStartDate)}'
                                : '${widget.member.expiryDate.isAfter(DateTime.now()) ? 'Expires on' : 'Expired on'} ${dateTimeToDate(widget.member.expiryDate)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: theme.onSecondary.withAlpha(150),
                              fontFamily: AppFont.primaryFont,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            // a title card to display the member's attendance calendar
            TitleCard(
              title: 'Attendance',
              children: [
                AttendanceCalendarBloc(
                  startDate: widget.member.createdAt,
                  endDate: widget.member.expiryDate,
                  id: widget.member.uid,
                  focusedDay: DateTime.now(),
                ),
              ],
            ),

            SizedBox(height: 10),

            // a title card to take membership actions
            TitleCard(
              title: 'Membership Actions',
              children: [
                PrimaryButton(
                  text: widget.member.isPaused
                      ? 'Resume Subscription'
                      : 'Pause Subscription',
                  color: theme.onSecondary,
                  textColor: theme.secondary,
                  onTap: () {
                    widget.member.isPaused
                        ? resumeSubscription()
                        : pauseSubscription();
                  },
                ),
                SizedBox(height: 5),
                PrimaryButton(
                  text: 'Extend Subscription',
                  color: theme.onSecondary,
                  textColor: theme.secondary,
                  onTap: () async {
                    String? duration = await showSubscriptionDialog(context);
                    if (duration != null) {
                      extendSubscription(duration);
                    }
                  },
                ),
                SizedBox(height: 5),
                PrimaryButton(
                  text: 'Reduce Subscription',
                  color: theme.onSecondary,
                  textColor: theme.secondary,
                  onTap: () async {
                    String? duration = await showSubscriptionDialog(context);
                    if (duration != null) {
                      reduceSubscription(duration);
                    }
                  },
                ),
                SizedBox(height: 5),
                PrimaryButton(
                  text: 'Revoke Subscription',
                  color: theme.error,
                  textColor: theme.onError,
                  onTap: () {
                    showConfirmDeleteDialog(
                      context,
                      revokeSubscription,
                      title: 'Revoke Subscription',
                      content: 'This action will end the'
                          ' current subscription of the member.',
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 10),

            TitleCard(
              children: [
                PrimaryButton(
                  text: 'Remove Member',
                  color: theme.error,
                  textColor: theme.onError,
                  onTap: () {
                    showConfirmDeleteDialog(
                      context,
                      removeMember,
                      title: 'Remove Member',
                      content: 'Are you sure you want to remove this member?',
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
