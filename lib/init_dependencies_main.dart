part of 'init_dependencies.dart';

final serviceLocater = GetIt.asNewInstance();

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();

  final supabase = await Supabase.initialize(
      url: SupabaseSecrets.supabaserUrl, anonKey: SupabaseSecrets.supabseKey);
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocater.registerLazySingleton(
    () => supabase.client,
  );
  serviceLocater.registerLazySingleton(
    () => Hive.box(name: "blogs"),
  );
  serviceLocater.registerLazySingleton(
    () => AppUserCubit(),
  );
  serviceLocater.registerFactory(
    () => InternetConnection(),
  );
  serviceLocater.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(internetConnection: serviceLocater()),
  );
}

_initAuth() {
  serviceLocater.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteImplimentation(serviceLocater()),
  );
  serviceLocater.registerFactory<AuthRepository>(() =>
      AuthRepositoryImplimentation(
          remoteDataSource: serviceLocater(),
          connectionChecker: serviceLocater()));

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
      () => BlogRepositoryImplimentation(
          blogRemoteDataSources: serviceLocater(),
          blogLocalDataSource: serviceLocater(),
          connectionChecker: serviceLocater()),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(box: serviceLocater()),
    )
    ..registerFactory(
      () => UploadBlog(blogRepository: serviceLocater()),
    )
    ..registerFactory(() => GetAllBlog(blogRepository: serviceLocater()))
    ..registerLazySingleton(
      () => BlogBloc(serviceLocater(), serviceLocater()),
    );
}
