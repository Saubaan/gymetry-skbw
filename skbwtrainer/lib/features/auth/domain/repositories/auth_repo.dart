import '../entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailAndPassword(String email, String password);
  Future<void> changePassword(String password, String newPassword);
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
}