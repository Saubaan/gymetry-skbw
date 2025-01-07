import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/components/auth_text_field.dart';
import 'package:skbwtrainer/components/primary_button.dart';
import 'package:skbwtrainer/themes/app_font.dart';
import 'package:skbwtrainer/utils/app_snack_bar.dart';

import '../cubits/auth_cubit.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
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
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: TextStyle(
            color: theme.onSurface,
            fontFamily: AppFont.primaryFont,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
            ),
          ],
        ),
      ),
    );
  }
}
