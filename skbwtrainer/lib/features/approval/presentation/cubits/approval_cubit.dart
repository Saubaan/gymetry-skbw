import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/features/approval/domain/repositories/approval_repo.dart';
import 'package:skbwtrainer/features/approval/presentation/cubits/approval_states.dart';

import '../../domain/entities/pending_member.dart';

class ApprovalCubit extends Cubit<ApprovalState> {
  final ApprovalRepo approvalRepo;

  ApprovalCubit({required this.approvalRepo}) : super(ApprovalInitial());

  Future<void> getNumber() async {
    emit(ApprovalLoading());
    try {
      final number = await approvalRepo.getNumber();
      emit(NumberLoaded(number));
    } on Exception catch (e) {
      emit(ApprovalError(e.toString()));
    }
  }

  //ID is Email-ID
  Future<void> getPendingMember(String id) async {
    emit(ApprovalLoading());
    try {
      final member = await approvalRepo.getPendingMemberById(id);
      emit(PendingMemberLoaded(member));
    } on Exception catch (e) {
      emit(ApprovalError(e.toString()));
    }
  }

  Future<void> getPendingMembers() async {
    emit(ApprovalLoading());
    try {
      final members = await approvalRepo.getPendingMembers();
      emit(PendingMembersLoaded(members));
    } on Exception catch (e) {
      emit(ApprovalError(e.toString()));
    }
  }

  Future<void> approveMember(PendingMember pendingMember) async {
    emit(ApprovalLoading());
    try {
      await approvalRepo.approveAndCreateMember(pendingMember);
      emit(ApprovalSuccess('Member Approved'));
    } on Exception catch (e) {
      emit(ApprovalError(e.toString()));
    }
  }

  Future<void> rejectMember(String id) async {
    emit(ApprovalLoading());
    try {
      await approvalRepo.deletePendingMember(id);
      emit(ApprovalSuccess('Member Rejected'));
    } on Exception catch (e) {
      emit(ApprovalError(e.toString()));
    }
  }
}
