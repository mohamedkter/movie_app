import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/core/utils/models/MovieModel.dart';

class FirebaseService {
 static Future<void> initialize() async {
   
   
   // Initialize Firebase
   await Firebase.initializeApp();
   if (kDebugMode) {
     log("Firebase initialized successfully.");
   }
 }


static Future<List<MovieModel>> getFavorites() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return [];

  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('favorites')
      .get();

  return snapshot.docs
      .map((doc) => MovieModel.fromMap(doc.data()))
      .toList();
}

static Future<void> removeFromFavorites(int movieId) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final favRef = FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('favorites')
      .doc(movieId.toString());

  await favRef.delete();
}
 // Function to check if the user is logged in
static Future<bool> isLoggedIn() async {
   try {
     User? user = FirebaseAuth.instance.currentUser;
     if (user != null) {
       if (kDebugMode) {
         log("User is logged in: ${user.email}");
       }
       return true;
     } else {
       if (kDebugMode) {
         log("No user is logged in.");
       }
       return false;
     }
   } catch (e) {
     if (kDebugMode) {
       log("Error checking login status: $e");
     }
     return false;
   }
 }

// Function to log out the user
 static Future<void> signOut() async {
   try {
     await FirebaseAuth.instance.signOut();
     if (kDebugMode) {
       log("User signed out successfully.");
     }
   } catch (e) {
     if (kDebugMode) {
       log("Error signing out: $e");
     }
   }
 }

   
   // Function to check if the email is verified
  static Future<bool> isEmailVerified() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      
      if (user == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No user is currently signed in.',
        );
      }
      await user.reload(); 
      return user.emailVerified;
    } catch (e) {
      print('Error checking email verification status: $e');
      return false;  
    }
  }
static Future<void> addToFavorites(MovieModel movie) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final favRef = FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('favorites')
      .doc(movie.id.toString());

  try {
    await favRef.set(movie.toJson());
    debugPrint("✅ Movie added to favorites: ${movie.title}");
  } catch (e) {
    debugPrint("❌ Failed to add to favorites: $e");
  }
}
  static Future<bool> isMovieFavorite(int movieId) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return false;

  final favRef = FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('favorites')
      .doc(movieId.toString());

  final doc = await favRef.get();
  return doc.exists;
}
}

