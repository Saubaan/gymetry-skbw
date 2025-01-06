import 'package:skbwtrainer/features/member/domain/entities/attendance.dart';
import 'package:skbwtrainer/features/member/domain/entities/member.dart';

abstract class MemberRepo {

  //get list of all members
  Future<List<Member>> getMembers();

  //delete member
  Future<void> deleteMember(String memberId);

  // update member by id
  Future<Member> updateMemberById(Member member);

  // get member attendance by id
  Future<List<Attendance>> getMemberAttendanceById(String memberId);

  // get all attendance marked today
  Future<List<Attendance>> getDayAttendance(DateTime day);

  Future<List<int>> getWeekAttendancePerDay(DateTime day);

  // fetch member by id
  Future<Member> getMemberById(String memberId);
}