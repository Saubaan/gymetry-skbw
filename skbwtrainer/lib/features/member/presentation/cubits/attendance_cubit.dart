import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/features/member/domain/entities/attendance.dart';
import 'package:skbwtrainer/features/member/domain/repository/member_repo.dart';
import 'attendance_states.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final MemberRepo memberRepo;

  AttendanceCubit({required this.memberRepo}) : super(AttendanceInitial());

  // Get all attendance marked today
  Future<void> getTodayAttendance() async {
    emit(AttendanceLoading());
    try {
      final attendance = await memberRepo.getDayAttendance(DateTime.now());
      emit(AttendanceLoaded(attendance));
    } on Exception catch (e) {
      emit(AttendanceError(e.toString()));
      List<Attendance> attendance = [];
      emit(AttendanceLoaded(attendance));
    }
  }

  Future<void> getWeekAttendancePerDay() async {
    emit(AttendanceLoading());
    try {
      final attendance = await memberRepo.getWeekAttendancePerDay(DateTime.now());
      emit(AttendanceWeekLoaded(attendance));
    } on Exception catch (e) {
      emit(AttendanceError(e.toString()));
      List<int> attendance = [0, 0, 0, 0, 0, 0, 0];
      emit(AttendanceWeekLoaded(attendance));

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