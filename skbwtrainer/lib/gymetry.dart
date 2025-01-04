import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skbwtrainer/features/auth/data/firebase_auth_repo.dart';
import 'package:skbwtrainer/features/auth/domain/repositories/auth_repo.dart';
import 'package:skbwtrainer/features/auth/presentation/cubits/auth_states.dart';
import 'package:skbwtrainer/features/member/presentation/pages/home_page.dart';
import 'package:skbwtrainer/themes/dark_mode.dart';
import 'package:skbwtrainer/themes/light_mode.dart';
import 'package:skbwtrainer/utils/app_snack_bar.dart';
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
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
            child: child!,
          );
        },
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
                return Scaffold(
                  body: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(color: Theme.of(context).colorScheme.primary, size: 50),
                  ),
                );
              }
            },
            listener: (context, state) {
              if (state is AuthError) {
                AppSnackBar.showError(getFirebaseAuthErrorMessage(state.message), context);
              }
            }),
      ),
    );
  }
}
