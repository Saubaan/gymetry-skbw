import '../../domain/entities/pending_member.dart';

abstract class ApprovalState {}

class ApprovalInitial extends ApprovalState {}

class ApprovalLoading extends ApprovalState {}

class PendingMembersLoaded extends ApprovalState {
  final List<PendingMember> members;

  PendingMembersLoaded(this.members);
}

class PendingMemberLoaded extends ApprovalState {
  final PendingMember member;

  PendingMemberLoaded(this.member);
}

class NumberLoaded extends ApprovalState {
  final int number;

  NumberLoaded(this.number);
}

class ApprovalError extends ApprovalState {
  final String message;

  ApprovalError(this.message);
}

class ApprovalSuccess extends ApprovalState {
  final String message;

  ApprovalSuccess(this.message);
}