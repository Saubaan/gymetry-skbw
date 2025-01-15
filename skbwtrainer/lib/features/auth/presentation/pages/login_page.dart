import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/components/auth_text_field.dart';
import 'package:skbwtrainer/components/primary_button.dart';
import 'package:skbwtrainer/features/auth/presentation/cubits/auth_cubit.dart';

import '../../../../themes/app_font.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;

  void login() async {
    final email = emailController.text;
    final password = passwordController.text;

    final authCubit = context.read<AuthCubit>();
    if (email.isNotEmpty && password.isNotEmpty) {
      // Authentication
      await authCubit.login(email, password);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sWidth = MediaQuery.of(context).size.width;
    final sHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.surface,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          height: sHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.secondary.withAlpha(10),
                theme.secondary.withAlpha(5),
                theme.primary.withAlpha(-150),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(sWidth / 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),

                /// Logo Container
                Column(
                  children: [
                    /// Logo
                    ClipRRect(
                      borderRadius: BorderRadius.circular(sWidth / 40),
                      child: Image.asset(
                        'assets/logo/logo-w.png',
                        height: sWidth / 4,
                      ),
                    ),

                    /// Gymetry Trainer Text
                    Text(
                      'Gymetry Trainer',
                      style: TextStyle(
                        color: theme.onSurface,
                        fontSize: sWidth / 19,
                        fontFamily: AppFont.logoFont,
                      ),
                    ),
                  ],
                ),

                /// Login Form Container
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Login Text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// Login
                        Text(
                          'Login',
                          style: TextStyle(
                            color: theme.onSurface,
                            fontSize: sWidth / 12,
                            fontFamily: AppFont.primaryFont,
                          ),
                        ),

                        /// to your account.
                        Text(
                          'to your account.',
                          style: TextStyle(
                            color: theme.onSurface.withAlpha(150),
                            fontSize: sWidth / 18,
                            fontFamily: AppFont.primaryFont,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: sHeight / 80),

                    /// Login Form
                    Container(
                      padding: EdgeInsets.all(sWidth / 40),
                      decoration: BoxDecoration(
                          color: theme.onSurface.withAlpha(100),
                          borderRadius: BorderRadius.circular(sWidth / 20)),
                      child: Column(
                        children: [
                          /// E-mail Field
                          AuthTextField(
                            hintText: 'E-mail',
                            controller: emailController,
                          ),

                          SizedBox(height: sHeight / 80),

                          /// Password Field
                          AuthTextField(
                            hintText: 'Password',
                            controller: passwordController,
                            isObscure: isObscure,
                            onPressed: () {
                              setState(
                                () {
                                  isObscure = !isObscure;
                                },
                              );
                            },
                          ),

                          SizedBox(height: sHeight / 80),

                          /// Login Button
                          PrimaryButton(
                            text: 'Login',
                            onTap: login,
                            color: theme.primary,
                            textColor: theme.onPrimary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                const SizedBox(),

                /// Gym Name Text
                Column(
                  children: [
                    Text(
                      'made for',
                      style: TextStyle(
                        color: theme.onSurface.withAlpha(100),
                        fontSize: sWidth / 30,
                        fontFamily: AppFont.primaryFont,
                      ),
                    ),
                    Text(
                      'S K Body Care',
                      style: TextStyle(
                        color: theme.onSurface,
                        fontSize: sWidth / 24,
                        fontFamily: AppFont.primaryFont,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
