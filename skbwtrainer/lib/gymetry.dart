import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/features/auth/data/firebase_auth_repo.dart';
import 'package:skbwtrainer/features/auth/domain/repositories/auth_repo.dart';
import 'package:skbwtrainer/features/auth/presentation/cubits/auth_states.dart';
import 'package:skbwtrainer/features/dashboard/presentation/pages/home_page.dart';
import 'package:skbwtrainer/themes/dark_mode.dart';
import 'package:skbwtrainer/themes/light_mode.dart';
import 'package:skbwtrainer/utils/error_message.dart';
import 'features/auth/presentation/cubits/auth_cubit.dart';
import 'features/auth/presentation/pages/login_page.dart';

class Gymetry extends StatelessWidget {
  final AuthRepo authRepo = FirebaseAuthRepo();

  Gymetry({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
      child: MaterialApp(
        title: 'Gymetry',
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        home: BlocConsumer<AuthCubit, AuthState>(
            builder: (context, state) {
              // Unauthenticated
              if (state is Unauthenticated) {
                return const LoginPage();
              }

              // Authenticated
              else if (state is Authenticated) {
                return const HomePage();
              }

              // Loading
              else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(getFirebaseAuthErrorMessage(state.message)),
                  ),
                );
              }
            }),
      ),
    );
  }
}
