import 'package:cleanarchitecture/core/state_handler.dart';
import 'package:cleanarchitecture/features/authentication/domain/entities/user.dart';
import 'package:cleanarchitecture/features/authentication/domain/usecases/user_login.dart';
import 'package:cleanarchitecture/features/authentication/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp userSignUp;
  final UserLogin userLogin;
  AuthBloc({
    required this.userSignUp,
    required this.userLogin,
  }) : super(AuthInitial()) {
    on<AuthSignUp>(
      (event, emit) async {
        emit(SighUpState(signUpState: StateHandler.loading()));
        final response = await userSignUp(
            UserSignUpParams(event.email, event.name, event.password));

        response.fold(
          (filure) => emit(
              SighUpState(signUpState: StateHandler.error(filure.message))),
          (user) => emit(SighUpState(signUpState: StateHandler.success(user))),
        );
      },
    );
    on<AuthLogin>(
      (event, emit) async {
        emit(SighUpState(signUpState: StateHandler.loading()));
        final response =
            await userLogin(UserLoginParams(event.email, event.password));

        response.fold(
          (filure) => emit(
              SighUpState(signUpState: StateHandler.error(filure.message))),
          (user) => emit(SighUpState(signUpState: StateHandler.success(user))),
        );
      },
    );
  }
}
