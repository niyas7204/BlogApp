import 'package:cleanarchitecture/core/enums.dart';
import 'package:cleanarchitecture/core/theme/app_pallet.dart';
import 'package:cleanarchitecture/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuhtButton extends StatelessWidget {
  final bool isLogin;
  final VoidCallback onPressed;
  const AuhtButton({super.key, required this.isLogin, required this.onPressed});

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
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(12.0), // Adjust the radius as needed
            ),
            fixedSize: Size(size.width - 20, 60),
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authstate) {
            return authstate is AuthLoading
                ? const CircularProgressIndicator()
                : Text(
                    isLogin ? "Sign In" : "Sign Up",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  );
          },
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
