import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movie_app/core/firebase/firebase_service.dart';
import 'package:movie_app/core/utils/models/MovieModel.dart';
import 'package:movie_app/core/utils/widgets/custom_appBar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class FavoriteShareScreen extends StatelessWidget {
  const FavoriteShareScreen({super.key});

  Future<String> generateQrData() async {
    List<MovieModel> movies = await FirebaseService.getFavorites();
    List<Map<String, dynamic>> movieList = movies.map((e) => e.toJson()).toList();
    String jsonString = jsonEncode(movieList);
    String compressed = base64Encode(utf8.encode(jsonString));
    return compressed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const CustomAppBar(title: "Share Favorite Movies"),
      body: Center(
        child: FutureBuilder<String>(
          future: generateQrData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return const Text("Error generating QR code");
            }

            return QrImageView(
              backgroundColor:Colors.white,
              data: snapshot.data!,
              version: QrVersions.auto,
              size: 300.0,
            );
          },
        ),
      ),
    );
  }
}
