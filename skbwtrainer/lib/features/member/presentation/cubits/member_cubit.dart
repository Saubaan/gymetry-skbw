import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/features/member/domain/repository/member_repo.dart';
import 'member_states.dart';

class MemberCubit extends Cubit<MemberState> {
  final MemberRepo memberRepo;

  MemberCubit(this.memberRepo) : super(MemberInitial());

  Future<void> getMembers() async {
    emit(MemberLoading());
    try {
      final members = await memberRepo.getMembers();
      emit(MemberLoaded(members));
    } on Exception catch (e) {
      emit(MemberError(e.toString()));
      emit(MemberInitial());
    }
  }
}