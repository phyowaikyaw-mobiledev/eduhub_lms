import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

// States
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserModel user;

  AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

// Cubit
class AuthCubit extends Cubit<AuthState> {
  final UserRepository _userRepository;

  AuthCubit(this._userRepository) : super(AuthInitial()) {
    checkAuthStatus();
  }

  void checkAuthStatus() {
    final user = _userRepository.getCurrentUser();
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      final user = await _userRepository.login(email, password);

      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError('Invalid email or password'));
      }
    } catch (e) {
      emit(AuthError('Login failed: ${e.toString()}'));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    emit(AuthLoading());

    try {
      final user = await _userRepository.register(
        name: name,
        email: email,
        password: password,
        role: role,
      );

      if (user != null) {
        await _userRepository.login(email, password);
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError('Email already exists'));
      }
    } catch (e) {
      emit(AuthError('Registration failed: ${e.toString()}'));
    }
  }

  Future<void> logout() async {
    await _userRepository.logout();
    emit(AuthUnauthenticated());
  }

  void updateUser(UserModel user) {
    _userRepository.updateUser(user);
    emit(AuthAuthenticated(user));
  }
}