import 'package:flutter/material.dart';
import 'package:skbwmember/theme/app_font.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool isObscure;
  final void Function()? onPressed;
  const AuthTextField(
      {super.key,
      this.controller,
      this.hintText,
      this.isObscure = false,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    final sWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).colorScheme;

    return TextField(
      obscureText: isObscure,
      controller: controller,
      style: TextStyle(
        color: theme.onSurface,
        fontFamily: AppFont.primaryFont,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: theme.surface.withAlpha(200),
        filled: true,
        suffixIcon: onPressed != null
            ? IconButton(
                onPressed: onPressed,
                icon: isObscure
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(sWidth / 40),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.primary.withAlpha(150)),
          borderRadius: BorderRadius.circular(sWidth / 40),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(sWidth / 40),
        ),
        hintStyle: TextStyle(
          color: theme.onSurface.withAlpha(150),
          fontFamily: AppFont.primaryFont,
        ),
      ),
    );
  }
}
