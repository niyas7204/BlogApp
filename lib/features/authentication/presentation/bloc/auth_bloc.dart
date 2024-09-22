import 'dart:developer';

import 'package:cleanarchitecture/core/cubit/cubit/app_user_cubit.dart';
import 'package:cleanarchitecture/core/state_handler.dart';
import 'package:cleanarchitecture/core/usecase/usecase.dart';
import 'package:cleanarchitecture/core/entities/user.dart';
import 'package:cleanarchitecture/features/authentication/domain/usecases/current_user.dart';
import 'package:cleanarchitecture/features/authentication/domain/usecases/user_login.dart';
import 'package:cleanarchitecture/features/authentication/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppUserCubit appUserCubit;
  final UserSignUp userSignUp;
  final UserLogin userLogin;
  final CurrentUser currentUser;
  AuthBloc({
    required this.appUserCubit,
    required this.currentUser,
    required this.userSignUp,
    required this.userLogin,
  }) : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) => emit(AuthLoading()),
    );
    on<AuthSignUp>(
      (event, emit) async {
        final response = await userSignUp(
            UserSignUpParams(event.email, event.name, event.password));

        response.fold(
            (filure) => emit(AuthFAilure(errorMessage: filure.message)),
            (user) => emitAuthSucces(user, emit));
      },
    );
    on<AuthLogin>(
      (event, emit) async {
        final response =
            await userLogin(UserLoginParams(event.email, event.password));

        response.fold(
            (filure) => emit(AuthFAilure(errorMessage: filure.message)),
            (user) => emitAuthSucces(user, emit));
      },
    );
    on<AuthIsUserSignedin>(
      (event, emit) async {
        final res = await currentUser(EmptyParams());
        res.fold((l) {
          log("error === $l");
          return emit(AuthFAilure(errorMessage: l.message));
        }, (r) {
          log("status === ${r.name}");

          return emitAuthSucces(r, emit);
        });
      },
    );
  }
  void emitAuthSucces(User user, Emitter<AuthState> emit) {
    appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
