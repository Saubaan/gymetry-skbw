import 'package:flutter/material.dart';
import 'package:skbwtrainer/themes/app_font.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primary,
        foregroundColor: theme.onPrimary,
        centerTitle: true,
        title: Text('Profile', style: TextStyle(fontFamily: AppFont.primaryFont),),
      ),
      body: Center(
        child: Text('Profile Page', style: TextStyle(fontFamily: AppFont.primaryFont),),
      ),
    );
  }
}
