import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skbwmember/features/auth/domain/entities/app_user.dart';
import 'package:skbwmember/features/auth/domain/entities/pending_member.dart';
import 'package:skbwmember/features/auth/domain/repositories/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AppUser?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // get user data from firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('members')
          .doc(userCredential.user!.uid)
          .get();

      DocumentSnapshot trainerDoc = await FirebaseFirestore.instance
          .collection('trainers')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        AppUser user = AppUser(
          uid: userCredential.user!.uid,
          email: email,
          name: userDoc['name'],
        );
        return user;
      } else if (trainerDoc.exists) {
        await firebaseAuth.signOut();
        throw Exception('Member not found');
      } else {
        await firebaseAuth.currentUser?.delete();
        throw Exception('Member not found');
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> changePassword(String password, String newPassword) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        await user.reauthenticateWithCredential(
          EmailAuthProvider.credential(email: user.email!, password: password),
        );
        await user.updatePassword(newPassword);
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;

    if (firebaseUser == null) {
      return null;
    }
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('members')
        .doc(firebaseUser.uid)
        .get();

    if (userDoc.exists) {
      return AppUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email!,
        name: userDoc['name'],
      );
    } else {
      firebaseAuth.signOut();
      return null;
    }
  }

  @override
  Future<void> registerNewMember(PendingMember member) async {
    try {
      await FirebaseFirestore.instance
          .collection('pendingMembers')
          .doc(member.email)
          .set(member.toJson());
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}
