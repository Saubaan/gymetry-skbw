import 'package:skbwtrainer/features/member/domain/entities/member.dart';
import 'package:skbwtrainer/features/approval/domain/entities/pending_member.dart';

abstract class MemberState {}

class MemberInitial extends MemberState {}

class MemberLoading extends MemberState {}

class MembersLoaded extends MemberState {
  final List<Member> members;
  MembersLoaded(this.members);
}

class MemberLoaded extends MemberState {
  final Member member;
  MemberLoaded(this.member);
}

class MemberSuccess extends MemberState {
  final String message;
  MemberSuccess(this.message);
}

class MemberError extends MemberState {
  final String message;
  MemberError(this.message);
}