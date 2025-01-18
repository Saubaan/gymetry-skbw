import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skbwmember/features/auth/data/firebase_auth_repo.dart';
import 'package:skbwmember/features/auth/domain/repositories/auth_repo.dart';
import 'package:skbwmember/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:skbwmember/features/auth/presentation/cubits/auth_states.dart';
import 'package:skbwmember/features/auth/presentation/pages/auth_page.dart';
import 'package:skbwmember/features/member/presentation/pages/home_page_bloc.dart';
import 'package:skbwmember/theme/theme_cubit.dart';
import 'package:skbwmember/utils/app_snack_bar.dart';
import 'package:skbwmember/utils/error_message.dart';

class Gymetry extends StatelessWidget {
  final AuthRepo authRepo = FirebaseAuthRepo();

  Gymetry({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
        ),
        BlocProvider(create: (context) => ThemeCubit()..loadTheme()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.linear(1.0)),
                child: child!,
              );
            },
            title: 'Gymetry',
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
              // Unauthenticated
              if (state is Unauthenticated) {
                return const AuthPage();
              }

              // Authenticated
              else if (state is Authenticated) {
                return HomePageBloc(
                  user: state.user,
                );
              }

              // Loading
              else {
                return Scaffold(
                  body: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Theme.of(context).colorScheme.primary, size: 50),
                  ),
                );
              }
            }, listener: (context, state) {
              if (state is AuthError) {
                AppSnackBar.showError(
                    getFirebaseAuthErrorMessage(
                        state.message.replaceAll('Exception:', '')),
                    context);
              }
              if (state is AuthSuccess) {
                AppSnackBar.showSuccess(state.message, context);
              }
            }),
          );
        },
      ),
    );
  }
}
