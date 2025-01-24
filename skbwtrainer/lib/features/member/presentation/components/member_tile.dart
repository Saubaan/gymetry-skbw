import 'package:flutter/material.dart';
import 'package:skbwtrainer/features/member/domain/entities/member.dart';
import 'package:skbwtrainer/themes/app_font.dart';

class MemberTile extends StatelessWidget {
  final Member member;
  final void Function()? onTap;
  const MemberTile({super.key, required this.member, this.onTap});

  // get the expiry text for the member in months or days or expired
  String getExpiryText(DateTime expiryDate) {
    if (isExpired(expiryDate)) {
      return 'Subscription Expired!';
    }
    final days = expiryDate.difference(DateTime.now()).inDays;
    if (days > 30) {
      return 'Subscription expires in ${days ~/ 30} month ${days % 30} days';
    }
    return 'Subscription expires in $days days';
  }

  bool isExpired(DateTime expiryDate) {
    return expiryDate.difference(DateTime.now()).inDays < 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return ListTile(
      title: Text(member.name,
          style: TextStyle(
              fontFamily: AppFont.primaryFont)),
      subtitle: Text(
        getExpiryText(member.expiryDate),
        style: TextStyle(
          color: isExpired(member.expiryDate)
              ? theme.error
              : theme.onSecondary.withAlpha(150),
          fontFamily: AppFont.logoFont,
        ),
      ),
      onTap: onTap,
    );
  }
}
