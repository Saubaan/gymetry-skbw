import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:skbwtrainer/themes/app_font.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void logout() async {
    AuthCubit authCubit = context.read<AuthCubit>();
    await authCubit.logout();// Logout
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Authenticated', style: TextStyle(fontFamily: AppFont.primaryFont),),
            TextButton(onPressed: logout, child: Text('Logout')),
          ],
        ),
      ),
    );
  }
}
