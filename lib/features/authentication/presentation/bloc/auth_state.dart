part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess({required this.user});
}

class AuthFAilure extends AuthState {
  final String errorMessage;

  const AuthFAilure({required this.errorMessage});
}

final class AuthLoading extends AuthState {}
