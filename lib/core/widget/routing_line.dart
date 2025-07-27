import 'package:flutter/material.dart';


class RoutingLine extends StatelessWidget {
  final String? labelText;
  final String? buttonText;
  final void Function()? onPressed;
  const RoutingLine({
    super.key, this.labelText, this.buttonText, this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            labelText ?? 'Don\'t have an account?',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              buttonText ?? 'Sign Up',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ],
      );
  }
}

