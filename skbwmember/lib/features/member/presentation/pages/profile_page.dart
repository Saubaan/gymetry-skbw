import 'package:flutter/material.dart';
import 'package:skbwmember/features/member/domain/entities/member.dart';
import 'package:skbwmember/features/member/presentation/pages/edit_profile_page.dart';
import 'package:skbwmember/utils/navigation.dart';

class ProfilePage extends StatelessWidget {
  final Member member;
  const ProfilePage({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primary,
        foregroundColor: theme.onPrimary,
        centerTitle: true,
        title: Text('Profile'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.secondary,
              foregroundColor: theme.onSecondary,
            ),
            onPressed: () {
              pushPage(context, EditProfilePage(member: member), 1);
            },
            child: Text('Edit'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(member.name),
            Text(member.phone),
            Text(member.email),
          ],
        ),
      ),
    );
  }
}
