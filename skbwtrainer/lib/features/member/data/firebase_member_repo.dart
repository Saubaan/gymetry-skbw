import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skbwtrainer/features/member/domain/entities/attendance.dart';
import 'package:skbwtrainer/features/member/domain/entities/member.dart';
import 'package:skbwtrainer/features/member/domain/repository/member_repo.dart';

class FireBaseMemberRepo implements MemberRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final CollectionReference membersCollection =
      FirebaseFirestore.instance.collection('members');
  final CollectionReference attendanceCollection =
      FirebaseFirestore.instance.collection('attendance');

  @override
  Future<void> deleteMember(String memberId) async {
    try {
      // Delete member document from the members collection
      await membersCollection.doc(memberId).delete();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Member> getMemberById(String memberId) async {
    try {
      // Get member document from the members collection
      DocumentSnapshot memberDoc = await membersCollection.doc(memberId).get();
      if (memberDoc.exists) {
        return Member.fromJson(memberDoc.data() as Map<String, dynamic>);
      } else {
        throw Exception('Member not found');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Member>> getMembers() async {
    try {
      // Get all member documents from the members collection
      QuerySnapshot membersDocs = await membersCollection.get();

      return membersDocs.docs
          .map((doc) => Member.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Attendance>> getMemberAttendanceById(String memberId) async {
    try {
      // Get all attendance documents for the member from the attendance collection
      QuerySnapshot attendanceDocs = await attendanceCollection
          .where('memberId', isEqualTo: memberId)
          .get();
      return attendanceDocs.docs
          .map((doc) => Attendance.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Member> updateMemberById(Member member) async {
    try {
      // Update member document in the members collection
      await membersCollection.doc(member.uid).update(member.toJson());
      return member;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception(e);
    }
  }
}
