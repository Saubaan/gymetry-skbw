import 'package:gymetry_skbw_trainer/features/auth/domain/repositories/auth_repo.dart';

import '../domain/entities/app_user.dart';

class FirebaseAuthRepo implements AuthRepo {

  @override
  Future<AppUser?> loginWithEmailAndPassword(String email, String password) {
    // TODO: implement loginWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<AppUser?> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }
}