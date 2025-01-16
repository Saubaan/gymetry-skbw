import 'package:skbwmember/features/member/domain/entities/attendance.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<Attendance> attendance;
  AttendanceLoaded(this.attendance);
}

class AttendanceError extends AttendanceState {
  final String message;
  AttendanceError(this.message);
}

class AttendanceTodayMarked extends AttendanceState {
  bool isMarked;
  AttendanceTodayMarked(this.isMarked);
}

class AttendanceMarked extends AttendanceState {}

