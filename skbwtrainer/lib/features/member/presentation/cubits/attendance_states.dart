import 'package:skbwtrainer/features/member/domain/entities/attendance.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<Attendance> attendance;
  AttendanceLoaded(this.attendance);
}

class AttendanceWeekLoaded extends AttendanceState {
  final List<int> attendance;
  AttendanceWeekLoaded(this.attendance);
}

class AttendanceError extends AttendanceState {
  final String message;
  AttendanceError(this.message);
}