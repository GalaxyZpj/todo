import 'package:flutter/material.dart';

class NoTaskFound extends StatelessWidget {
  const NoTaskFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.delete_sweep,
            size: 90,
          ),
          Text(
            'No tasks found',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
