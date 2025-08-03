import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/firebase/firebase_service.dart';
import 'package:movie_app/core/router/app_routes.dart';
import 'package:movie_app/core/widget/arrow_back_icon_button.dart';
import 'package:movie_app/core/widget/custom_auth_label.dart';
import 'package:movie_app/core/widget/custom_auth_password_input_field.dart';
import 'package:movie_app/core/widget/custom_auth_text_input_field.dart';
import 'package:movie_app/core/widget/custom_auth_title.dart';
import 'package:movie_app/core/widget/custom_button.dart';
import 'package:movie_app/core/widget/routing_line.dart';
import 'package:movie_app/features/auth/signin/ui/signin_cubit/signin_cubit.dart';
import 'package:movie_app/features/auth/signin/ui/widgets/recovery_password_button.dart';
import 'package:movie_app/features/auth/signin/ui/widgets/signin_with_google_button.dart';

import '../signin_cubit/signin_states.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    void goToSignUp() {
      Navigator.of(context).pushNamed(AppRoutes.signup);
    }

    Future<void> checkEmailVerification() async {
      bool isVerified = await FirebaseService.isEmailVerified();
      if (isVerified) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.main,
          (Route<dynamic> route) => false,
        );
      } else {
        Navigator.of(context).pushNamed(AppRoutes.main);
      }
    }

    void signIn() {
      context.read<SigninCubit>().signIn(
            emailController.text.trim(),
            passwordController.text.trim(),
          );
    }

    return Scaffold(
      body: BlocConsumer<SigninCubit, SignInStates>(
        listener: (context, state) {
          if (state is SignInErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }

          if (state is SignInSuccessState) {
            checkEmailVerification();
          }
        },
        builder: (context, state) {
          if (state is SignInLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 90.h),
                ArrowBackIconButton(onPressed: () => Navigator.of(context).pop()),
                const SizedBox(height: 20),
                const CustomAuthTitle(title: 'Hello Again!'),
                const SizedBox(height: 10),
                const CustomAuthLabel(
                    label: 'Fill your details Or continue with social media'),
                const SizedBox(height: 20),
                CustomAuthTextInputField(
                  hintText: 'xyz@gmail.com',
                  label: 'Email Address',
                  controller: emailController,
                ),
                const SizedBox(height: 20),
                CustomAuthPasswordInputField(
                  hintText: '********',
                  label: 'Password',
                  controller: passwordController,
                ),
                const SizedBox(height: 20),
                const RecoveryPasswordButton(),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Sign In',
                  onPressed: signIn,
                  color: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                const SizedBox(height: 20),
                const SignInWithGoogleButton(),
                SizedBox(height: 50.h),
                RoutingLine(
                  buttonText: "New User?",
                  labelText: "Create Account",
                  onPressed: goToSignUp,
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
