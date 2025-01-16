import 'package:skbwmember/features/member/domain/entities/attendance.dart';
import 'package:skbwmember/features/member/domain/entities/member.dart';

abstract class MemberRepo {
  // update member by id
  Future<Member> updateMember(Member member);

  // get member attendance by id
  Future<List<Attendance>> getMemberAttendanceById(String memberId);

  // fetch member by id
  Future<Member> getMemberById(String memberId);

  // get bool for today's attendance
  Future<bool> getTodayAttendance(String memberId);

  // mark attendance for today
  Future<void> markAttendance(String memberId);
}