import 'package:skbwmember/features/member/domain/entities/attendance.dart';
import 'package:skbwmember/features/member/domain/entities/member.dart';

abstract class MemberRepo {
  // update member by id
  Future<Member> updateMember(Member member);

  // get member attendance by id
  Future<List<Attendance>> getMemberAttendanceById(String memberId);

  // get all attendance marked today
  Future<List<Attendance>> getDayAttendance(DateTime day);

  Future<List<int>> getWeekAttendancePerDay(DateTime day);

  // fetch member by id
  Future<Member> getMemberById(String memberId);
}