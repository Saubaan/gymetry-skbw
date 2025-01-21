import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwmember/features/member/domain/entities/member.dart';
import 'package:skbwmember/features/profile/domain/repositories/profile_repo.dart';
import 'package:skbwmember/features/profile/presentation/cubits/profile_states.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  void getProfile() async {
    emit(ProfileLoading());
    try{
      final member = await profileRepo.getProfile();
      emit(ProfileLoaded(member));
    } on Exception catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void updateProfile(Member member) async {
    emit(ProfileLoading());
    try{
      final updatedMember = await profileRepo.updateProfile(member);
      emit(ProfileSuccess('Profile updated successfully'));
      emit(ProfileLoaded(updatedMember));
    } on Exception catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}