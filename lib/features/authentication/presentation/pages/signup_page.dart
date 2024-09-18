import 'dart:developer';

import 'package:cleanarchitecture/core/enums.dart';
import 'package:cleanarchitecture/core/theme/app_pallet.dart';
import 'package:cleanarchitecture/core/widgets/space_boxes.dart';
import 'package:cleanarchitecture/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:cleanarchitecture/features/authentication/presentation/widgets/auth_button.dart';
import 'package:cleanarchitecture/features/authentication/presentation/widgets/auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, authstate) {
        // TODO: implement listener
      },
      builder: (context, authstate) {
        return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
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
                        "Sign Up.",
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      SpaceBoxes.spaceH10,
                      AuthField(controller: nameController, hintText: "Name"),
                      SpaceBoxes.spaceH10,
                      AuthField(controller: emailController, hintText: "Email"),
                      SpaceBoxes.spaceH10,
                      AuthField(
                        controller: passwordController,
                        hintText: "Password",
                        isObscure: true,
                      ),
                      // SpaceBoxes.spaceH10,
                      // AuthField(
                      //   controller: confirmPasswordController,
                      //   hintText: "Confirm Password",
                      //   isObscure: true,
                      // ),
                      SpaceBoxes.spaceH20,
                      AuhtButton(
                        onPressed: () {
                          if (authstate is SighUpState &&
                              authstate.signUpState.status !=
                                  StateStatus.loading) {
                            if (formKey.currentState!.validate()) {
                              log("field validated---");
                              context.read<AuthBloc>().add(AuthSignUp(
                                  name: nameController.text.trim(),
                                  email: emailController.text,
                                  password: passwordController.text.trim()));
                            }
                          }
                        },
                        isLogin: false,
                      ),
                      SpaceBoxes.spaceH20,
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: RichText(
                          text: TextSpan(
                              text: "Already have an account? ",
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                                TextSpan(
                                    text: "Sign In",
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
            ),
          )),
        );
      },
    );
  }
}
