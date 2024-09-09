import 'package:cleanarchitecture/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class AuhtButton extends StatelessWidget {
  final bool isLogin;
  const AuhtButton({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                AppPallete.gradient1,
                AppPallete.gradient2,
              ]),
          borderRadius: BorderRadius.circular(12),
          color: AppPallete.gradient2),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(12.0), // Adjust the radius as needed
            ),
            fixedSize: Size(size.width - 20, 60),
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent),
        child: Text(
          isLogin ? "Sign In" : "Sign Up",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
    // Container(
    //   height: 50,
    //   width: double.infinity,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(12), color: AppPallete.gradient2),
    //   child: Center(
    //     child:
    //   ),
    // );
  }
}
