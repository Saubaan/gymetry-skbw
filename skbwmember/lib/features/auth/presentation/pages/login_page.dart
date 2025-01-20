import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwmember/features/auth/presentation/components/auth_text_field.dart';
import 'package:skbwmember/components/primary_button.dart';
import 'package:skbwmember/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:skbwmember/theme/app_font.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, this.onTap});

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
                        Theme.of(context).brightness == Brightness.dark
                            ? 'assets/logo/logo-w.png'
                            : 'assets/logo/logo-b.png',
                        height: sWidth / 4,
                      ),
                    ),

                    /// Gymetry Text
                    Text(
                      'Gymetry',
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

                    SizedBox(height: sHeight / 100),

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
                            keyBoardType: TextInputType.emailAddress,
                          ),

                          SizedBox(height: sHeight / 100),

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

                          SizedBox(height: sHeight / 100),

                          /// Login Button
                          PrimaryButton(
                            text: 'Login',
                            onTap: login,
                            color: theme.primary,
                            textColor: theme.onPrimary,
                          ),

                          SizedBox(height: sHeight / 100),

                          /// Register Button
                          PrimaryButton(
                            text: 'Not a member?',
                            onTap: widget.onTap,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                /// Gym Name Text
                Column(
                  children: [
                    Text(
                      'Developed by Bitvert',
                      style: TextStyle(
                        color: theme.onSurface.withAlpha(100),
                        fontSize: sWidth / 30,
                        fontFamily: AppFont.primaryFont,
                      ),
                    ),
                    // about text button
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'About Us',
                        style: TextStyle(
                          color: theme.onSurface.withAlpha(200),
                          fontSize: sWidth / 30,
                          fontFamily: AppFont.primaryFont,
                        ),
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
