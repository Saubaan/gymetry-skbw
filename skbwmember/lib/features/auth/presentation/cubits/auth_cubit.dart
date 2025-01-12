import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwmember/features/auth/domain/entities/pending_member.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repo.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  // check is user is authenticated
  Future<void> checkAuth() async {
    emit(AuthLoading());
    final AppUser? user = await authRepo.getCurrentUser();
    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  // get current user
  AppUser? get currentUser => _currentUser;

  // login with email and password
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final AppUser? user = await authRepo.loginWithEmailAndPassword(email, password);
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  // change password
  Future<void> changePassword(String password, String newPassword) async {
    try {
      emit(AuthLoading());
      await authRepo.changePassword(password, newPassword);
      emit(AuthSuccess('Password changed successfully'));
      emit(Authenticated(currentUser!));
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
      emit(Authenticated(currentUser!));
    }
  }

  // register pending member for approval
  Future<void> register(PendingMember member) async {
    try {
      emit(AuthLoading());
      await authRepo.registerNewMember(member);
      emit(AuthSuccess('Registration successful, please wait for approval'));
      emit(Unauthenticated());
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  // logout
  Future<void> logout() async {
    emit(AuthLoading());
    await Future.delayed(Duration(seconds: 1));
    await authRepo.logout();
    _currentUser = null;
    emit(Unauthenticated());
  }
}