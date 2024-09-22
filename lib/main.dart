import 'package:cleanarchitecture/core/cubit/cubit/app_user_cubit.dart';
import 'package:cleanarchitecture/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:cleanarchitecture/features/authentication/presentation/pages/login_page.dart';
import 'package:cleanarchitecture/features/blog/presentation/pages/blog_page.dart';
import 'package:cleanarchitecture/init_dependencies.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (context) => serviceLocater<AuthBloc>()),
      RepositoryProvider(
        create: (context) => serviceLocater<AppUserCubit>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserSignedin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return state is AuthSuccess
              ? BlocSelector<AppUserCubit, AppUserState, bool>(
                  selector: (state) {
                    return state is AppUserLogedin;
                  },
                  builder: (context, state) {
                    return state ? const BlogPage() : const LoginPage();
                  },
                )
              : Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }
}
