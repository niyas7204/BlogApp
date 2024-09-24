import 'package:cleanarchitecture/core/cubit/cubit/app_user_cubit.dart';
import 'package:cleanarchitecture/core/secrets/supabase_secrets.dart';
import 'package:cleanarchitecture/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:cleanarchitecture/features/authentication/data/data_sources/auth_remote_implimentation.dart';
import 'package:cleanarchitecture/features/authentication/data/repositories/auth_repository_implimentation.dart';
import 'package:cleanarchitecture/features/authentication/domain/repository/auth_repository.dart';
import 'package:cleanarchitecture/features/authentication/domain/usecases/current_user.dart';
import 'package:cleanarchitecture/features/authentication/domain/usecases/user_login.dart';
import 'package:cleanarchitecture/features/authentication/domain/usecases/user_sign_up.dart';
import 'package:cleanarchitecture/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:cleanarchitecture/features/blog/data/data_sources/blog_remote_data_sources.dart';
import 'package:cleanarchitecture/features/blog/data/repositories/blog_repository_imp.dart';
import 'package:cleanarchitecture/features/blog/domain/repositories/blog_repository.dart';
import 'package:cleanarchitecture/features/blog/domain/usercases/upload_blog.dart';
import 'package:cleanarchitecture/features/blog/presentation/bloc/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocater = GetIt.asNewInstance();

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: SupabaseSecrets.supabaserUrl, anonKey: SupabaseSecrets.supabseKey);
  serviceLocater.registerLazySingleton(
    () => supabase.client,
  );
  serviceLocater.registerLazySingleton(
    () => AppUserCubit(),
  );
}

_initAuth() {
  serviceLocater.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteImplimentation(serviceLocater()),
  );
  serviceLocater.registerFactory<AuthRepository>(
      () => AuthRepositoryImplimentation(remoteDataSource: serviceLocater()));

  serviceLocater.registerFactory(
    () => UserSignUp(serviceLocater()),
  );
  serviceLocater.registerFactory(
    () => UserLogin(authRepository: serviceLocater()),
  );
  serviceLocater.registerFactory(
    () => CurrentUser(authRepository: serviceLocater()),
  );
  serviceLocater.registerLazySingleton(
    () => AuthBloc(
        appUserCubit: serviceLocater(),
        userSignUp: serviceLocater(),
        userLogin: serviceLocater(),
        currentUser: serviceLocater()),
  );
}

void _initBlog() {
  serviceLocater
    ..registerFactory<BlogRemoteDataSources>(
      () => BlogRemoteDatasourceImp(supabaseClient: serviceLocater()),
    )
    ..registerFactory<BlogRepository>(
      () =>
          BlogRepositoryImplimentation(blogRemoteDataSources: serviceLocater()),
    )
    ..registerFactory(
      () => UploadBlog(blogRepository: serviceLocater()),
    )
    ..registerFactory(() => GetAllBlog(blogRepository: serviceLocater()))
    ..registerLazySingleton(
      () => BlogBloc(serviceLocater(), serviceLocater()),
    );
}
