import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 120,
        height: 120,
        child: Lottie.asset(
          'assets/json/loading_Animation.json',
          fit: BoxFit.contain,
        ),
          ),
    );
  }
}