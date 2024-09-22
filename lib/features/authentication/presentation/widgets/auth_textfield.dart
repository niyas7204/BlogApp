import 'package:cleanarchitecture/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscure;
  const AuthField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.isObscure = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscuringCharacter: "*",
      controller: controller,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: AppPallete.borderColor, width: 3),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppPallete.gradient2, width: 3),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: AppPallete.borderColor, width: 3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppPallete.gradient2, width: 3),
          ),
          errorStyle:
              const TextStyle(color: Color.fromARGB(255, 234, 122, 114)),
          hintText: hintText),
      obscureText: isObscure,
      validator: (value) {
        if (value!.isEmpty) {
          if (value.isEmpty) {
            return "$hintText is missing";
          }
          return null;
        }
        return null;
      },
    );
  }
}
