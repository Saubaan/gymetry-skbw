import 'package:skbwtrainer/features/profile/domain/entities/gym.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Gym gym;

  ProfileLoaded(this.gym);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

class ProfileSuccess extends ProfileState {
  final String message;

  ProfileSuccess(this.message);
}