import 'package:flutter/material.dart';

class ShowMessage extends StatelessWidget {
  final String message;

  const ShowMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok')),
        ]);
  }
}
