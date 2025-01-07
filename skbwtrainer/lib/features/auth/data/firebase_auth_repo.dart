import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../domain/entities/app_user.dart';
import '../domain/repositories/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Future<void> changePassword(String password, String newPassword) async {
    try {
      final user = firebaseAuth.currentUser;
      if(user != null) {
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
  Future<AppUser?> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // get user data from firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('trainers').doc(userCredential.user!.uid).get();

      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: userDoc['name'],
      );

      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;

    if (firebaseUser == null) {
      return null;
    }
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('trainers').doc(firebaseUser.uid).get();

    return AppUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
      name: userDoc['name'],
    );
  }
}
