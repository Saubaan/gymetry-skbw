import 'package:skbwtrainer/features/member/domain/entities/attendance.dart';
import 'package:skbwtrainer/features/member/domain/entities/member.dart';
import 'package:skbwtrainer/features/member/domain/entities/pending_member.dart';

abstract class MemberRepo {
  //approve and create member
  Future<void> approveAndCreateMember(PendingMember pendingMember);

  //get list of all pending members
  Future<List<PendingMember>> getPendingMembers();

  //delete pending member
  Future<void> deletePendingMember(String pendingMemberId);

  //get list of all members
  Future<List<Member>> getMembers();

  //delete member
  Future<void> deleteMember(String memberId);

  // fetch pending member by id
  Future<PendingMember> getPendingMemberById(String pendingMemberId);

  // update member by id
  Future<void> updateMemberById(Member member);

  // get member attendance by id
  Future<List<Attendance>> getMemberAttendanceById(String memberId);

  // fetch member by id
  Future<Member> getMemberById(String memberId);
}