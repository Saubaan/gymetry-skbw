import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/components/auth_text_field.dart';
import 'package:skbwtrainer/components/primary_button.dart';
import 'package:skbwtrainer/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:skbwtrainer/themes/app_font.dart';

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
    if (email.isNotEmpty &&
        password.isNotEmpty) {
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
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(sWidth / 40),
                        child: Image.asset(
                          'assets/logo/logo-w.png',
                          height: sWidth / 6,
                        ),
                      ),
                      Text(
                        'Gymetry Trainer',
                        style: TextStyle(
                          color: theme.onSurface,
                          fontSize: sWidth / 15,
                          fontFamily: AppFont.logoFont,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Login Text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              color: theme.onSurface,
                              fontSize: sWidth / 10,
                              fontFamily: AppFont.primaryFont,
                            ),
                          ),
                          Text(
                            'to your account.',
                            style: TextStyle(
                              color: theme.onSurface.withAlpha(150),
                              fontSize: sWidth / 15,
                              fontFamily: AppFont.primaryFont,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sHeight / 80),
                      // Login Form
                      Container(
                        padding: EdgeInsets.all(sWidth / 40),
                        decoration: BoxDecoration(
                            color: theme.onSurface.withAlpha(100),
                            borderRadius: BorderRadius.circular(sWidth / 20)),
                        child: Column(
                          children: [
                            // Icon Image
                            // E-mail Field
                            AuthTextField(
                              hintText: 'E-mail',
                              controller: emailController,
                            ),
                            SizedBox(height: sHeight / 80),
                            // Password Field
                            AuthTextField(
                              hintText: 'Password',
                              controller: passwordController,
                              isObscure: isObscure,
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                },);
                              },
                            ),
                            SizedBox(height: sHeight / 80),
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
                  Column(
                    children: [
                      Text(
                        'made for',
                        style: TextStyle(
                          color: theme.onSurface.withAlpha(100),
                          fontSize: sWidth / 24,
                          fontFamily: AppFont.primaryFont,
                        ),
                      ),
                      Text(
                        'S. K. Body Works',
                        style: TextStyle(
                          color: theme.onSurface,
                          fontSize: sWidth / 18,
                          fontFamily: AppFont.primaryFont,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
