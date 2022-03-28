part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class Auth extends AuthState {
  @override
  List<Object?> get props => [];
}

class UnAuth extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}
