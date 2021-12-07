import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/widgets/new_task_dialog.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import '../widgets/no_task_found.dart';
import '../widgets/task_card.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text('ToDo'),
        centerTitle: false,
      ),
      body: Consumer<TaskProvider>(
        builder: (ctx, taskProvider, _) {
          if (!taskProvider.isInitialized) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final taskMap = taskProvider.taskMap;
          final taskIdList = taskProvider.taskIdList;

          return taskIdList.isEmpty
              ? const NoTaskFound()
              : ListView.builder(
                  key: UniqueKey(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  itemBuilder: (ctx, index) {
                    final taskId = taskIdList[index];
                    final task = taskMap[taskId] as Task;
                    return TaskCard(
                      key: ValueKey(task.id),
                      itemIndex: index,
                      task: task,
                      updateTaskHandler: taskProvider.updateTask,
                      deleteTaskHandler: taskProvider.deleteTask,
                    );
                  },
                  itemCount: taskIdList.length,
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (ctx) => NewTaskDialog(ctx),
            isScrollControlled: true,
          );
        },
      ),
    );
  }
}
