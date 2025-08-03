import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/auth/signup/models/signup_user_model.dart';


class FirebaseSignupController {
   static Future<Either<Failure, void>> signup(SignupUserModel user) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: user.email.trim(),
        password: user.password,
      );

      await userCredential.user?.updateDisplayName(user.name.trim());
      await userCredential.user?.reload();
      await userCredential.user?.sendEmailVerification();

      return const Right(null); // Success
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return Left(Failure(errMessage: 'Invalid email format.'));
        case 'email-already-in-use':
          return Left(Failure(errMessage: 'This email is already in use.'));
        case 'weak-password':
          return Left(Failure(errMessage: 'The password is too weak.'));
        case 'operation-not-allowed':
          return Left(Failure(errMessage: 'Email/password sign-in is not enabled.'));
        case 'network-request-failed':
          return Left(Failure(errMessage: 'Please check your internet connection.'));
        default:
          return Left(Failure(errMessage: 'Unexpected error: ${e.message}'));
      }
    } catch (e) {
      return Left(Failure(errMessage: 'Unexpected error: $e'));
    }
  }
  }
