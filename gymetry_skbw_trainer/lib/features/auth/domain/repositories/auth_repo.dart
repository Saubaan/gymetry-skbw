import 'package:gymetry_skbw_trainer/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailAndPassword(String email, String password);
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
}