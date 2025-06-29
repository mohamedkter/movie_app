import 'package:flutter/material.dart';


class CustomHeader extends StatelessWidget {

final String headerTitle;
final VoidCallback onViewMoreTab;
  const CustomHeader({
    super.key, required this.headerTitle, required this.onViewMoreTab,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(headerTitle,
            style:Theme.of(context).textTheme.bodyLarge),
        GestureDetector(
          onTap:onViewMoreTab,
          child: Text("View more",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              )),
        ),
      ],
    );
  }
}




