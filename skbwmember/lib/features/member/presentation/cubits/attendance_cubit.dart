import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwmember/features/member/domain/entities/attendance.dart';
import 'package:skbwmember/features/member/domain/repositories/member_repo.dart';
import 'attendance_states.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final MemberRepo memberRepo;

  AttendanceCubit({required this.memberRepo}) : super(AttendanceInitial());

  Future<void> markAttendance(String id) async {
    emit(AttendanceLoading());
    try {
      await memberRepo.markAttendance(id);
      emit(AttendanceMarked());
      final isMarked = await memberRepo.getTodayAttendance(id);
      emit(AttendanceTodayMarked(isMarked));
    } on Exception catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }

  Future<bool> isTodayMarked(String id) async {
    emit(AttendanceLoading());
    try {
      final isMarked = await memberRepo.getTodayAttendance(id);
      emit(AttendanceTodayMarked(isMarked));
      return isMarked;
    } on Exception catch (e) {
      emit(AttendanceError(e.toString()));
      return false;
    }
  }

  Future<void> getAttendance(String id) async {
    emit(AttendanceLoading());
    try {
      final attendance = await memberRepo.getMemberAttendanceById(id);
      emit(AttendanceLoaded(attendance));
    } on Exception catch (e) {
      emit(AttendanceError(e.toString()));
      List<Attendance> attendance = [];
      emit(AttendanceLoaded(attendance));
    }
  }
}