import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FavoriteScreen Screen'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Movie App',
         
        ),
      ),
    );
  }
}