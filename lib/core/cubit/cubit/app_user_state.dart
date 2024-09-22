part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLogedin extends AppUserState {
  final User user;

  AppUserLogedin({required this.user});
}
