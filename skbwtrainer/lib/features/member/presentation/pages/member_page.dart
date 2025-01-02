import 'package:flutter/material.dart';
import 'package:skbwtrainer/components/primary_button.dart';
import 'package:skbwtrainer/components/title_card.dart';
import 'package:skbwtrainer/features/member/domain/entities/member.dart';
import 'package:skbwtrainer/features/member/presentation/components/calendar_container.dart';
import 'package:skbwtrainer/themes/app_font.dart';
import 'package:skbwtrainer/utils/app_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberPage extends StatelessWidget {
  final Member member;

  const MemberPage({super.key, required this.member});

  Future<void> launchDialer(String phoneNumber) async {
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            Text('Gymetry', style: TextStyle(fontFamily: AppFont.primaryFont)),
      ),
      body: SingleChildScrollView(
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
                          member.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppFont.primaryFont,
                          ),
                        ),
                        Text(
                          'Email: ${member.email}',
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.onSecondary.withAlpha(150),
                            fontFamily: AppFont.logoFont,
                          ),
                        ),
                        Text(
                          'Phone: ${member.phone}',
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.onSecondary.withAlpha(150),
                            fontFamily: AppFont.logoFont,
                          ),
                        ),
                        Text(
                          'Subscription expiry: ${member.expiryDate.day}/${member.expiryDate.month}/${member.expiryDate.year}',
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
                    text: 'Call',
                    color: theme.onSecondary,
                    textColor: theme.secondary,
                    onTap: () {
                      try {
                        launchDialer(member.phone);
                      } catch (e) {
                        AppSnackBar.showError(
                            "Couldn't launch dialer", context);
                      }
                    },
                  ),
                ],
              ),

              SizedBox(height: 10),

              // a title card to take membership actions
              TitleCard(
                title: 'Membership Actions',
                children: [
                  PrimaryButton(
                    text: 'Pause Subscription',
                    color: theme.onSecondary,
                    textColor: theme.secondary,
                    onTap: () {
                      // renew membership
                    },
                  ),
                  PrimaryButton(
                    text: 'Extend Subscription',
                    color: theme.onSecondary,
                    textColor: theme.secondary,
                    onTap: () {
                      // extend membership
                    },
                  ),
                  PrimaryButton(
                    text: 'Remove Member',
                    color: theme.error,
                    textColor: theme.onError,
                    onTap: () {
                      // cancel membership
                    },
                  ),
                ],
              ),

              SizedBox(height: 10),

              // a title card to display the member's attendance calendar
              TitleCard(
                title: 'Attendance',
                children: [
                  CalendarBloc(
                    startDate: member.createdAt,
                    endDate: member.expiryDate,
                    id: member.uid,
                    focusedDay: DateTime.now(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
