import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/features/profile/domain/entities/gym.dart';
import 'package:skbwtrainer/features/profile/domain/repository/profile_repo.dart';
import 'package:skbwtrainer/features/profile/presentation/cubits/profile_states.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  void getGym() async {
    emit(ProfileLoading());
    try{
      final gym = await profileRepo.getGym();
      emit(ProfileLoaded(gym));
    } on Exception catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void updateGym(Gym gym) async {
    emit(ProfileLoading());
    try{
      final updatedProfile = await profileRepo.updateGym(gym);
      emit(ProfileSuccess('Profile updated successfully'));
      emit(ProfileLoaded(updatedProfile));
    } on Exception catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}