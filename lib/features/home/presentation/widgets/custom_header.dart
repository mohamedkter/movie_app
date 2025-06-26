import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {

final String HeaderTitle;
  const CustomHeader({
    super.key, required this.HeaderTitle,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(HeaderTitle,
            style:Theme.of(context).textTheme.bodyLarge),
        Text("View more",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }
}




