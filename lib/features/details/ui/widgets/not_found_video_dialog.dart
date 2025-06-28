import 'package:flutter/material.dart';

class NotFoundVideoDialog extends StatelessWidget {
  const NotFoundVideoDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red[400]),
          const SizedBox(width: 8),
          const Text(
            'No Videos Found',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      content: const Text(
        'Sorry, there are no trailers or videos available for this movie.',
        style: TextStyle(color: Colors.white70, fontSize: 14),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.redAccent,
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

