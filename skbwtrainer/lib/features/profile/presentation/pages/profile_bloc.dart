import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skbwtrainer/features/profile/data/firebase_profile_repo.dart';
import 'package:skbwtrainer/features/profile/domain/repository/profile_repo.dart';
import 'package:skbwtrainer/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:skbwtrainer/features/profile/presentation/cubits/profile_states.dart';
import 'package:skbwtrainer/features/profile/presentation/pages/profile_page.dart';
import 'package:skbwtrainer/themes/app_font.dart';
import 'package:skbwtrainer/utils/app_snack_bar.dart';

class ProfileBloc extends StatelessWidget {
  final ProfileRepo profileRepo = FirebaseProfileRepo();
  ProfileBloc({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) => ProfileCubit(profileRepo: profileRepo)..getGym(),
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: theme.primary,
        foregroundColor: theme.onPrimary,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(fontFamily: AppFont.primaryFont),
        ),
      ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: theme.primary,
                  size: 50,
                ),
              );
            } else if (state is ProfileLoaded) {
              return ProfilePage(gym: state.gym);
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          },
          listener: (context, state) {
            if (state is ProfileError) {
              AppSnackBar.showError(state.message, context);
            } else if (state is ProfileSuccess) {
              AppSnackBar.showSuccess(state.message, context);
            }
          },
        ),
      ),
    );
  }
}
