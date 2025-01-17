import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skbwmember/features/member/domain/entities/attendance.dart';
import 'package:skbwmember/features/member/domain/entities/member.dart';
import 'package:skbwmember/features/member/domain/repositories/member_repo.dart';

class FirebaseMemberRepo implements MemberRepo {
  final firestore = FirebaseFirestore.instance;
  final membersCollection = FirebaseFirestore.instance.collection('members');
  final attendanceCollection =
      FirebaseFirestore.instance.collection('attendance');

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
    } on FirebaseException catch (e) {
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
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Member> updateMember(Member member) async {
    try {
      // Update member document in the members collection
      await membersCollection.doc(member.uid).update(member.toJson());
      return member;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> getTodayAttendance(String memberId) {
    try {
      // Get today's attendance document for the member from the attendance collection
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
      return attendanceCollection
          .where('memberId', isEqualTo: memberId)
          .where(
            'date',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
            isLessThanOrEqualTo: Timestamp.fromDate(endOfDay),
          )
          .get()
          .then((value) => value.docs.isNotEmpty);
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> markAttendance(String memberId) async {
    try {
      final Attendance attendance = Attendance(
        memberId: memberId,
        date: DateTime.now(),
      );
      // check if member subscription is paused then resume it
      DocumentSnapshot memberDoc = await membersCollection.doc(memberId).get();
      if (!memberDoc.exists) {
        throw Exception('Member not found');
      } else {
        final member = Member.fromJson(memberDoc.data() as Map<String, dynamic>);
        if(member.expiryDate.isBefore(DateTime.now())) {
          throw Exception('Member subscription expired');
        } else if (member.isPaused) {
          final now = DateTime.now();
          final newExpiryDate = DateTime.now().add(member.pauseStartDate.difference(DateTime(now.year, now.month, now.day)));
          final newMember = member.copyWith(isPaused: false, expiryDate: newExpiryDate);
          await membersCollection.doc(memberId).update(newMember.toJson());
        }
      }
      // Mark attendance for the member in the attendance collection
      attendanceCollection.add(attendance.toJson());
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception(e);
    }
  }
}
