import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skbwmember/features/auth/presentation/pages/register_page.dart';

import 'login_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  bool loading = false;

  void toggle() async {
    setState(() {
      loading = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      loading = false;
      isLogin = !isLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
              color: Theme.of(context).colorScheme.primary, size: 50),
        ),
      );
    } else {
      if(isLogin) {
        return LoginPage(onTap: toggle,);
      } else {
        return RegisterPage(onTap: toggle,);
      }
    }
  }
}
