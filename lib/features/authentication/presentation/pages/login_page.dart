import 'dart:ffi';

import 'package:cleanarchitecture/core/theme/app_pallet.dart';
import 'package:cleanarchitecture/core/widgets/space_boxes.dart';
import 'package:cleanarchitecture/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:cleanarchitecture/features/authentication/presentation/pages/signup_page.dart';
import 'package:cleanarchitecture/features/authentication/presentation/widgets/auth_button.dart';
import 'package:cleanarchitecture/features/authentication/presentation/widgets/auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign In.",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                SpaceBoxes.spaceH10,
                AuthField(controller: emailController, hintText: "Email"),
                SpaceBoxes.spaceH10,
                AuthField(
                  controller: passwordController,
                  hintText: "Password",
                  isObscure: true,
                ),
                SpaceBoxes.spaceH10,
                SpaceBoxes.spaceH20,
                AuhtButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(AuthLogin(
                          email: emailController.text,
                          password: passwordController.text.trim()));
                    }
                  },
                  isLogin: true,
                ),
                SpaceBoxes.spaceH20,
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ));
                  },
                  child: RichText(
                    text: TextSpan(
                        text: "Don't have an account? ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                              text: "Sign Up",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: AppPallete.gradient2,
                                      fontWeight: FontWeight.bold))
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
