import 'package:cleanarchitecture/core/secrets/supabase_secrets.dart';
import 'package:cleanarchitecture/features/authentication/data/data_sources/auth_remote_implimentation.dart';
import 'package:cleanarchitecture/features/authentication/data/repositories/auth_repository_implimentation.dart';
import 'package:cleanarchitecture/features/authentication/domain/usecases/user_sign_up.dart';
import 'package:cleanarchitecture/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:cleanarchitecture/features/authentication/presentation/pages/login_page.dart';
import 'package:cleanarchitecture/init_dependencies.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (context) => serviceLocater<AuthBloc>()),
      // RepositoryProvider(
      //   create: (context) => SubjectRepository(),
      // ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const LoginPage(),
    );
  }
}
