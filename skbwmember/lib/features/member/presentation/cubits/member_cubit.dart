import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwmember/features/member/domain/repositories/member_repo.dart';
import 'package:skbwmember/features/member/domain/entities/member.dart';
import 'package:skbwmember/features/member/presentation/cubits/member_states.dart';

class MemberCubit extends Cubit<MemberState> {
  final MemberRepo memberRepo;

  MemberCubit({required this.memberRepo}) : super(MemberInitial());

  Future<void> getMember(String id) async {
    emit(MemberLoading());
    try {
      final member = await memberRepo.getMemberById(id);
      emit(MemberLoaded(member));
    } on Exception catch (e) {
      emit(MemberError(e.toString()));
    }
  }

  Future<void> updateMember(Member member, String message) async {
    emit(MemberLoading());
    try {
      final updatedMember = await memberRepo.updateMember(member);
      emit(MemberSuccess(message));
      emit(MemberLoaded(updatedMember));
    } on Exception catch (e) {
      emit(MemberError(e.toString()));
    }
  }
}