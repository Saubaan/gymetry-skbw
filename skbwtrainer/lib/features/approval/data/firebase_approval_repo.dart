import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../member/domain/entities/member.dart';
import '../domain/entities/pending_member.dart';
import '../domain/repositories/approval_repo.dart';

class FirebaseApprovalRepo implements ApprovalRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final CollectionReference membersCollection =
      FirebaseFirestore.instance.collection('members');
  final CollectionReference pendingMembersCollection =
      FirebaseFirestore.instance.collection('pendingMembers');
  final CollectionReference attendanceCollection =
      FirebaseFirestore.instance.collection('attendance');

  @override
  Future<void> createPendingMember(PendingMember pendingMember) async {
    try {
      // Add pending member document to the pendingMembers collection
      await pendingMembersCollection
          .doc(pendingMember.email)
          .set(pendingMember.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<int> getNumber() async {
    try {
      // Get the number of pending member documents from the pendingMembers collection
      QuerySnapshot pendingMembersDocs = await pendingMembersCollection.get();
      return pendingMembersDocs.size;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> approveAndCreateMember(PendingMember pendingMember) async {
    try {
      // Create a user account for member
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: pendingMember.email,
        password: pendingMember.password,
      );

      // Calculate the new expiry date
      DateTime newExpiryDate = DateTime.now().add(Duration(
          days: pendingMember.expiryDate
              .difference(pendingMember.createdAt)
              .inDays));

      // Create a member document
      Member member = Member(
        uid: userCredential.user!.uid,
        email: pendingMember.email,
        name: pendingMember.name,
        phone: pendingMember.phone,
        expiryDate: newExpiryDate,
        isPaused: false,
        pauseStartDate: DateTime.now(),
        createdAt: DateTime.now(),
        checkDate: DateTime.now(),
      );

      // Delete pending member document from the pendingMembers collection
      await pendingMembersCollection.doc(pendingMember.email).delete();

      // Add member document to the members collection
      await membersCollection.doc(member.uid).set(member.toJson());
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<PendingMember>> getPendingMembers() async {
    try {
      // Get all pending member documents from the pendingMembers collection
      QuerySnapshot pendingMembersDocs = await pendingMembersCollection.get();
      return pendingMembersDocs.docs
          .map((doc) =>
              PendingMember.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<PendingMember> getPendingMemberById(String pendingMemberId) async {
    try {
      // Get pending member document from the pendingMembers collection
      DocumentSnapshot pendingMemberDoc =
          await pendingMembersCollection.doc(pendingMemberId).get();
      if (pendingMemberDoc.exists) {
        return PendingMember.fromJson(
            pendingMemberDoc.data() as Map<String, dynamic>);
      } else {
        throw Exception('Pending member not found or is already approved');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deletePendingMember(String pendingMemberId) async {
    try {
      // Delete pending member document from the pendingMembers collection
      await pendingMembersCollection.doc(pendingMemberId).delete();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception(e);
    }
  }
}
