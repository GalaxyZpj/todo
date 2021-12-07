import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../widgets/task_form.dart';

class NewTaskDialog extends StatelessWidget {
  final BuildContext dialogContext;
  const NewTaskDialog(this.dialogContext, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Container(
      height: 220,
      margin: EdgeInsets.only(
        top: 30,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
      ),
      child: TaskForm(
        taskTitle: '',
        taskDescription: '',
        closeFormHandler: () => Navigator.of(dialogContext).pop(),
        saveHandler: (String title, String description) {
          taskProvider.addTask(title, description);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Task added'),
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}
