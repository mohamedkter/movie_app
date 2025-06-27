import 'package:flutter/material.dart';

class CustomHeaderWithoutAction extends StatelessWidget {
  final String HeaderTitle;
  const CustomHeaderWithoutAction({
    super.key,
    required this.HeaderTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      HeaderTitle,
      style:const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 23,
          fontFamily: "raleway"),
    );
  }
}