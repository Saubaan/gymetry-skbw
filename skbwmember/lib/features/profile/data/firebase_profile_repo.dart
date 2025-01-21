import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skbwmember/features/member/domain/entities/member.dart';
import 'package:skbwmember/features/profile/domain/repositories/profile_repo.dart';

class FirebaseProfileRepo implements ProfileRepo {
  final firestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final membersCollection = FirebaseFirestore.instance.collection('members');

  @override
  Future<Member> getProfile() async {
    try{
      User? user = firebaseAuth.currentUser;
      if(user != null){
        DocumentSnapshot memberDoc = await membersCollection.doc(user.uid).get();
        if(memberDoc.exists){
          return Member.fromJson(memberDoc.data() as Map<String, dynamic>);
        } else {
          throw Exception('Member not found');
        }
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
  Future<Member> updateProfile(Member member) async {
    try{
      User? user = firebaseAuth.currentUser;
      if(user != null){
        await membersCollection.doc(user.uid).update(member.toJson());
        return member;
      } else {
        throw Exception('Member not found');
      }
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception(e);
    }
  }
}