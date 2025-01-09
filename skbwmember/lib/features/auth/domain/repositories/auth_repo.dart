import 'package:skbwmember/features/auth/domain/entities/app_user.dart';
import 'package:skbwmember/features/auth/domain/entities/pending_member.dart';

abstract class AuthRepo {
  // login using email and password
  Future<AppUser?> loginWithEmailAndPassword (String email, String password);

  // change password
  Future<void> changePassword(String password, String newPassword);

  // register using email and password
  Future<void> registerNewMember(PendingMember member);

  // logout
  Future<void> logout();

  // get the current user
  Future<AppUser?> getCurrentUser();
}