import 'package:flutter/material.dart';

class NoTaskFound extends StatelessWidget {
  const NoTaskFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Tap the add button to add new task.',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
