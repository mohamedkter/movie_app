import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/router/app_routes.dart';
import 'package:movie_app/core/widget/arrow_back_icon_button.dart';
import 'package:movie_app/core/widget/custom_auth_label.dart';
import 'package:movie_app/core/widget/custom_auth_password_input_field.dart';
import 'package:movie_app/core/widget/custom_auth_text_input_field.dart';
import 'package:movie_app/core/widget/custom_auth_title.dart';
import 'package:movie_app/core/widget/custom_button.dart';
import 'package:movie_app/core/widget/routing_line.dart';
import 'package:movie_app/features/auth/signin/ui/widgets/signin_with_google_button.dart';
import 'package:movie_app/features/auth/signup/models/signup_user_model.dart';
import 'package:movie_app/features/auth/signup/ui/signup_cubit/signup_cubit.dart';
import 'package:movie_app/features/auth/signup/ui/signup_cubit/signup_states.dart';


class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void goToSignIn() {
      Navigator.pop(context);
    }

    void signUp() {
      final user = SignupUserModel(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      context.read<SignupCubit>().signup(user.name, user.email, user.password);
    }

    return Scaffold(
      body: BlocConsumer<SignupCubit, SignupStates>(
        listener: (context, state) {
          if (state is SignupErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }

          if (state is SignupSuccessState) {
            Navigator.of(context).pushNamed(AppRoutes.emailVerification);
          }
        },
        builder: (context, state) {
          if (state is SignupLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 90.h),
                ArrowBackIconButton(onPressed: () => Navigator.of(context).pop()),
                const SizedBox(height: 20),
                const CustomAuthTitle(title: 'Register Account'),
                const SizedBox(height: 10),
                const CustomAuthLabel(
                  label: 'Fill your details Or continue with social media',
                ),
                const SizedBox(height: 20),
                CustomAuthTextInputField(
                  hintText: 'xxxxxxxx',
                  label: 'Your Name',
                  controller: nameController,
                ),
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
                const SizedBox(height: 40),
                CustomButton(
                  text: 'Sign Up',
                  onPressed: signUp,
                  color: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                const SizedBox(height: 20),
                const SignInWithGoogleButton(),
                SizedBox(height: 40.h),
                RoutingLine(
                  buttonText: "Log In",
                  labelText: "Already Have Account?",
                  onPressed: goToSignIn,
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