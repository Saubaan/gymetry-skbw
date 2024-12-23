import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwtrainer/features/auth/domain/entities/app_user.dart';
import 'package:skbwtrainer/features/auth/domain/repositories/auth_repo.dart';
import 'package:skbwtrainer/features/auth/presentation/cubits/auth_states.dart';

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
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  // logout
  Future<void> logout() async {
    emit(AuthLoading());
    await authRepo.logout();
    _currentUser = null;
    emit(Unauthenticated());
  }
}