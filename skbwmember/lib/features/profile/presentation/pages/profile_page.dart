import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwmember/components/primary_button.dart';
import 'package:skbwmember/components/title_card.dart';
import 'package:skbwmember/features/auth/presentation/components/auth_text_field.dart';
import 'package:skbwmember/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:skbwmember/features/auth/presentation/pages/settings_page.dart';
import 'package:skbwmember/features/member/domain/entities/member.dart';
import 'package:skbwmember/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:skbwmember/theme/app_font.dart';
import 'package:skbwmember/utils/app_snack_bar.dart';
import 'package:skbwmember/utils/calendar_functions.dart';
import 'package:skbwmember/utils/navigation.dart';

class ProfilePage extends StatefulWidget {
  final Member member;
  const ProfilePage({super.key, required this.member});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final globalKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  // name validator
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    } else if (value.length < 3) {
      return 'Name must be at least 3 characters';
    } else if (value.length > 50) {
      return 'Name must be at most 50 characters';
    } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'Name must contain only alphabets';
    }
    return null;
  }

  // phone validator
  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone is required';
    } else if (!RegExp(r'^[789]\d{9}$').hasMatch(value)) {
      return 'Invalid phone number';
    }
    return null;
  }

  void updateProfile() {
    if(widget.member.name == nameController.text && widget.member.phone == phoneController.text) {
      Navigator.pop(context);
      AppSnackBar.showInfo('No changes made', context);
    } else {
      if (globalKey.currentState!.validate()) {
        final member = widget.member.copyWith(
          name: nameController.text,
          phone: phoneController.text,
        );
        Navigator.pop(context);
        context.read<ProfileCubit>().updateProfile(member);
      }
    }
  }

  void showEditDialog(BuildContext context) {
    nameController.text = widget.member.name;
    phoneController.text = widget.member.phone;
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context).colorScheme;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: theme.surface,
          title: ListTile(
            leading: Icon(Icons.edit, color: theme.onSurface),
            title: Text(
              'Edit Profile',
              style: TextStyle(
                fontFamily: AppFont.primaryFont,
                fontSize: 20,
                color: theme.onSurface,
              ),
            ),
          ),
          content: Form(
            key: globalKey,
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AuthTextField(
                    controller: nameController,
                    hintText: 'Name',
                    validator: nameValidator,
                    keyBoardType: TextInputType.name,
                  ),
                  SizedBox(height: 5),
                  AuthTextField(
                    controller: phoneController,
                    hintText: 'Phone',
                    validator: phoneValidator,
                    keyBoardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            PrimaryButton(
              text: 'Cancel',
              onTap: () => Navigator.pop(context),
              color: theme.onSecondary,
              textColor: theme.secondary,
            ),
            SizedBox(height: 5),
            PrimaryButton(
              text: 'Update',
              onTap: updateProfile,
              color: theme.primary,
              textColor: theme.onPrimary,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleCard(
              title: 'Profile',
              childrenAlign: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.member.name,
                  style: TextStyle(
                    fontFamily: AppFont.primaryFont,
                    fontSize: 20,
                  ),
                ),
                Divider(color: theme.onSurface.withAlpha(100)),
                ListTile(
                  leading: Icon(Icons.phone, color: theme.onSurface, size: 20,),
                  title: Text(
                    widget.member.phone,
                    style: TextStyle(
                      fontFamily: AppFont.logoFont,
                      fontSize: 16,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.email, color: theme.onSurface, size: 20,),
                  title: Text(
                    widget.member.email,
                    style: TextStyle(
                      fontFamily: AppFont.logoFont,
                      fontSize: 16,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.date_range, color: theme.onSurface, size: 20,),
                  title: Text(
                    dateTimeToDate(widget.member.createdAt),
                    style: TextStyle(
                      fontFamily: AppFont.logoFont,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            TitleCard(
              title: 'Settings',
              children: [
                PrimaryButton(
                  text: 'Edit Profile',
                  onTap: () {
                    showEditDialog(context);
                  },
                  color: theme.onSecondary,
                  textColor: theme.secondary,
                ),
                SizedBox(height: 5),
                PrimaryButton(
                  text: 'Change Password',
                  onTap: () {
                    Navigator.pop(context);
                    pushPage(context, SettingsPage(), 1);
                  },
                  color: theme.onSecondary,
                  textColor: theme.secondary,
                ),
                SizedBox(height: 5),
                PrimaryButton(
                  text: 'Logout',
                  onTap: () {
                    Navigator.pop(context);
                    context.read<AuthCubit>().logout();
                  },
                  color: theme.error,
                  textColor: theme.onError,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
