import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_google_bloc/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuth()) {
    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signIn(
            email: event.email, password: event.password);
        emit(Auth());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuth());
      }
    });
    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signUp(
          email: event.email,
          password: event.password,
        );
        await authRepository.userSetup(
          displayName: event.displayName,
        );

        emit(Auth());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuth());
      }
    });
    on<GoogleSignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signInWithGoogle();
        emit(Auth());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuth());
      }
    });
    on<SignOutRequested>((event, emit) async {
      emit(AuthLoading());
      await authRepository.signOut();
      emit(UnAuth());
    });
  }
}
