import 'package:flutter/material.dart';

class TaskCompleteOverlay extends StatelessWidget {
  const TaskCompleteOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.05),
      ),
      child: const Center(
        child: Divider(
          thickness: 2,
        ),
      ),
    );
  }
}
