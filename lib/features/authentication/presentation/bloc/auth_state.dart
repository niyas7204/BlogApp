part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  AuthState();
}

final class AuthInitial extends AuthState {}

class SighUpState extends AuthState {
  final StateHandler<User> signUpState;

  SighUpState({required this.signUpState});
}
