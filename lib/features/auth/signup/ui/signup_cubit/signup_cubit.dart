import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/auth/signup/controller/firebase_signup_controller.dart';
import 'package:movie_app/features/auth/signup/models/signup_user_model.dart';
import 'package:movie_app/features/auth/signup/ui/signup_cubit/signup_states.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitialState());

  Future<void> signup(String name, String email, String password) async {
    emit(SignupLoadingState());

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      emit(SignupErrorState(
     "Please fill all required fields",
      ));
      return;
    }

    final result = await FirebaseSignupController.signup(
      SignupUserModel(
        email: email.trim(),
        password: password,
        name: name.trim(),
      ),
    );

    result.fold(
      (failure) {
        emit(SignupErrorState(failure.errMessage));
      },
      (_) {
        emit(SignupSuccessState("Signup successful"));
      },
    );
  }
}
