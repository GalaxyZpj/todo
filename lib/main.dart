import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/task_provider.dart';
import './screens/task_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TaskProvider()),
    ],
    child: const ToDo(),
  ));
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
      home: const TaskScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
