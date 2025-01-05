import '../entities/pending_member.dart';

abstract class ApprovalRepo {
  Future<void> createPendingMember(PendingMember pendingMember);

  Future<int> getNumber();
  //approve and create member
  Future<void> approveAndCreateMember(PendingMember pendingMember);

  //get list of all pending members
  Future<List<PendingMember>> getPendingMembers();

  // fetch pending member by id
  Future<PendingMember> getPendingMemberById(String pendingMemberId);

  //delete pending member
  Future<void> deletePendingMember(String pendingMemberId);
}