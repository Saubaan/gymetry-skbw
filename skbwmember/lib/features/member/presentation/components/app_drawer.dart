import 'package:flutter/material.dart';
import 'package:skbwmember/features/auth/presentation/pages/settings_page.dart';
import 'package:skbwmember/features/profile/presentation/pages/profile_bloc.dart';
import 'package:skbwmember/theme/app_font.dart';
import 'package:skbwmember/utils/about_page.dart';
import 'package:skbwmember/utils/navigation.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context).colorScheme;
    final sWidth = MediaQuery.of(context).size.width;

    return Drawer(
      shape: const Border(),
      child: SafeArea(
        child: Column(
          children: [
            /// Title Tile
            ListTile(
              tileColor: theme.primary.withAlpha(50),
              leading: ClipOval(
                child: Image.asset(
                  'assets/logo/logo-wg.png',
                  height: sWidth / 15,
                ),
              ),
              title: Text(
                'SK Body Care',
                style: TextStyle(
                  fontFamily: AppFont.logoFont,
                  fontSize: sWidth / 25,
                  color: theme.onSurface,
                ),
              ),
            ),

            /// Profile Tile
            ListTile(
              leading: Icon(Icons.account_circle, color: theme.onSurface),
              title: Text(
                'Profile',
                style: TextStyle(
                    fontFamily: AppFont.primaryFont, fontSize: sWidth / 28),
              ),
              onTap: () {
                Navigator.pop(context);
                pushPage(context, ProfileBloc(), 1);
              },
            ),

            /// Settings Tile
            ListTile(
              leading: Icon(Icons.settings, color: theme.onSurface),
              title: Text(
                'Settings',
                style: TextStyle(
                    fontFamily: AppFont.primaryFont, fontSize: sWidth / 28),
              ),
              onTap: () {
                Navigator.pop(context);
                pushPage(context, SettingsPage(), 1);
              },
            ),

            Spacer(),

            Divider(
              color: theme.onSurface.withAlpha(100),
            ),

            /// Developer Name Text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Developed by Bitvert, ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: theme.onSurface.withAlpha(150),
                      fontSize: sWidth / 35,
                      fontFamily: AppFont.primaryFont,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    child: Text(
                      'About Us',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: theme.onSurface,
                        fontSize: sWidth / 35,
                        fontFamily: AppFont.primaryFont,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      pushPage(context, AboutPage(), 1);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
