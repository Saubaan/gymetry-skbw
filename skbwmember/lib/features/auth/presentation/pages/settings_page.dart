import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwmember/components/primary_button.dart';
import 'package:skbwmember/components/title_card.dart';
import 'package:skbwmember/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:skbwmember/theme/app_font.dart';
import 'package:skbwmember/theme/theme_cubit.dart';
import 'package:skbwmember/utils/app_snack_bar.dart';
import 'package:skbwmember/features/auth/presentation/components/auth_text_field.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isObscure = true;
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  void changePassword() {
    final password = passwordController.text;
    final newPassword = newPasswordController.text;
    final confirmNewPassword = confirmNewPasswordController.text;

    if (password.isNotEmpty &&
        newPassword.isNotEmpty &&
        confirmNewPassword.isNotEmpty) {
      if (newPassword == confirmNewPassword) {
        final authCubit = context.read<AuthCubit>();
        authCubit.changePassword(password, newPassword);
        Navigator.pop(context);
      } else {
        AppSnackBar.showError(
          'New Password and Confirm Password are not same',
          context,
        );
      }
    } else {
      AppSnackBar.showError('All fields are required', context);
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeCubit = context.read<ThemeCubit>();
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.secondary,
        foregroundColor: theme.onSecondary,
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(
            fontFamily: AppFont.primaryFont,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TitleCard(
                title: 'Appearance',
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.brightness_6,
                      color: theme.onSurface,
                    ),
                    title: Text(
                      'Dark Mode',
                      style: TextStyle(
                        color: theme.onSurface,
                        fontFamily: AppFont.primaryFont,
                        fontSize: 16,
                      ),
                    ),
                    trailing: Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        themeCubit.toggleTheme();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              TitleCard(
                title: 'Change Password',
                children: [
                  AuthTextField(
                    controller: passwordController,
                    hintText: 'Current Password',
                    isObscure: isObscure,
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  AuthTextField(
                    controller: newPasswordController,
                    hintText: 'New Password',
                    isObscure: true,
                  ),
                  SizedBox(height: 10),
                  AuthTextField(
                    controller: confirmNewPasswordController,
                    hintText: 'Confirm New Password',
                    isObscure: false,
                  ),
                  SizedBox(height: 10),
                  PrimaryButton(
                    text: 'Change Password',
                    onTap: changePassword,
                    color: theme.onSecondary,
                    textColor: theme.secondary,
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
