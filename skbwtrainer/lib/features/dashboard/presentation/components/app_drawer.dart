import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:skbwtrainer/features/profile/presentation/pages/profile_page.dart';
import 'package:skbwtrainer/themes/app_font.dart';
import 'package:skbwtrainer/utils/navigation.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    void logout() {
      context.read<AuthCubit>().logout();
    }

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
                  'assets/logo/logo-w.png',
                  height: sWidth / 15,
                ),
              ),
              title: Text(
                'Gymetry SKBW',
                style: TextStyle(
                  fontFamily: AppFont.primaryFont,
                  fontSize: 24,
                  color: theme.onSurface,
                ),
              ),
            ),

            /// Profile Tile
            ListTile(
              leading: Icon(Icons.person, color: theme.onSurface),
              title: Text(
                'Profile',
                style: TextStyle(fontFamily: AppFont.primaryFont),
              ),
              splashColor: theme.primary.withAlpha(50),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, createAnimatedRoute(ProfilePage(), 1));
              },
            ),

            /// Settings Tile
            ListTile(
              leading: Icon(Icons.settings, color: theme.onSurface),
              title: Text(
                'Settings',
                style: TextStyle(fontFamily: AppFont.primaryFont),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            /// Logout Tile
            ListTile(
              leading: Icon(Icons.logout, color: theme.onSurface),
              title: Text(
                'Logout',
                style: TextStyle(fontFamily: AppFont.primaryFont),
              ),
              onTap: logout,
            ),

            Spacer(),

            Divider(
              color: theme.onSurface.withAlpha(100),
            ),

            ///Help Tile
            ListTile(
              leading: Icon(Icons.help, color: theme.onSurface),
              title: Text(
                'Help',
                style: TextStyle(fontFamily: AppFont.primaryFont),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            /// Contact Tile
            ListTile(
              leading: Icon(Icons.mail, color: theme.onSurface),
              title: Text(
                'Contact Us',
                style: TextStyle(fontFamily: AppFont.primaryFont),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            /// Developer Name Text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Developed by Bitvert',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.onSurface,
                  fontSize: sWidth / 35,
                  fontFamily: AppFont.primaryFont,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
