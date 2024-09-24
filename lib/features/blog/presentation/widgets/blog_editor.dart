import 'package:cleanarchitecture/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class BlogEditorField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const BlogEditorField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: null,
      decoration: InputDecoration(
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
          hintText: hintText),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is empty";
        }
        return null;
      },
    );
  }
}
