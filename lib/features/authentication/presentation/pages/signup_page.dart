import 'dart:ffi';

import 'package:cleanarchitecture/core/theme/app_pallet.dart';
import 'package:cleanarchitecture/core/widgets/space_boxes.dart';
import 'package:cleanarchitecture/features/authentication/presentation/widgets/auth_button.dart';
import 'package:cleanarchitecture/features/authentication/presentation/widgets/auth_textfield.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLogin = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
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
                Text(
                  isLogin ? "Sign In." : "Sign Up.",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                SpaceBoxes.spaceH10,
                !isLogin
                    ? AuthField(controller: nameController, hintText: "Name")
                    : const SizedBox(),
                SpaceBoxes.spaceH10,
                AuthField(controller: emailController, hintText: "Email"),
                SpaceBoxes.spaceH10,
                AuthField(
                  controller: passwordController,
                  hintText: "Password",
                  isObscure: true,
                ),
                SpaceBoxes.spaceH10,
                !isLogin
                    ? AuthField(
                        controller: passwordController,
                        hintText: "Password",
                        isObscure: true,
                      )
                    : const SizedBox(),
                SpaceBoxes.spaceH20,
                AuhtButton(
                  isLogin: isLogin,
                ),
                SpaceBoxes.spaceH20,
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: RichText(
                    text: TextSpan(
                        text: isLogin
                            ? "Don't have an account? "
                            : "Already have an account? ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                              text: isLogin ? "Sign Up" : "Sign In",
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
