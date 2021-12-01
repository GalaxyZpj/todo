import 'package:flutter/material.dart';

import './screens/task_list.dart';

void main() {
  runApp(const ToDo());
}

class ToDo extends StatelessWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const TaskList(),
      debugShowCheckedModeBanner: false,
    );
  }
}
