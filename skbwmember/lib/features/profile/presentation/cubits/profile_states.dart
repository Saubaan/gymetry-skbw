import 'package:skbwmember/features/member/domain/entities/member.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Member member;

  ProfileLoaded(this.member);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

class ProfileSuccess extends ProfileState {
  final String message;

  ProfileSuccess(this.message);
}