import 'package:skbwtrainer/features/member/domain/entities/member.dart';

abstract class MemberState {}

class MemberInitial extends MemberState {}

class MemberLoading extends MemberState {}

class MemberLoaded extends MemberState {
  final List<Member> members;
  MemberLoaded(this.members);
}

class MemberError extends MemberState {
  final String message;
  MemberError(this.message);
}