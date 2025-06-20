import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/features/member/domain/entities/member.dart';
import 'package:skbwtrainer/features/member/domain/repository/member_repo.dart';
import 'member_states.dart';

class MemberCubit extends Cubit<MemberState> {
  final MemberRepo memberRepo;

  MemberCubit({required this.memberRepo}) : super(MemberInitial());

  Future<void> getMembers() async {
    emit(MemberLoading());
    try {
      final members = await memberRepo.getMembers();
      emit(MembersLoaded(members));
    } on Exception catch (e) {
      emit(MemberError(e.toString()));
    }
  }

  Future<void> getMember(String id) async {
    emit(MemberLoading());
    try {
      final member = await memberRepo.getMemberById(id);
      emit(MemberLoaded(member));
    } on Exception catch (e) {
      emit(MemberError(e.toString()));
    }
  }

  Future<void> deleteMember(String id) async {
    emit(MemberLoading());
    try {
      await memberRepo.deleteMember(id);
    } on Exception catch (e) {
      emit(MemberError(e.toString()));
    }
  }

  Future<void> updateMember(Member member, String message) async {
    emit(MemberLoading());
    try {
      final updatedMember = await memberRepo.updateMemberById(member);
      emit(MemberSuccess(message));
      emit(MemberLoaded(updatedMember));
    } on Exception catch (e) {
      emit(MemberError(e.toString()));
    }
  }
}