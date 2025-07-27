
import 'package:flutter/material.dart';



class RecoveryPasswordButton extends StatelessWidget {
  const RecoveryPasswordButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: (){
             // context.go(Routes.forgotPassword);
            },
            child: Text(
              'Recovery Password',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
