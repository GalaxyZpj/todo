import 'package:flutter/material.dart';

import '../models/task.dart';
import '../widgets/task_complete_overlay.dart';
import 'task_form.dart';

class TaskCard extends StatefulWidget {
  final int itemIndex;
  final Task task;
  final Function updateTaskHandler;
  final Function deleteTaskHandler;

  const TaskCard(
      {Key? key,
      required this.itemIndex,
      required this.task,
      required this.updateTaskHandler,
      required this.deleteTaskHandler})
      : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  var _editMode = false;

  void toggleEditMode() {
    setState(() {
      _editMode = !_editMode;
    });
  }

  Widget _buildExpandedCard(Task task) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: TaskForm(
          key: ValueKey("${task.id}-form"),
          taskTitle: task.title,
          taskDescription: task.description,
          saveHandler: (String title, String description) =>
              widget.updateTaskHandler(task.id, title, description),
          closeFormHandler: toggleEditMode,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.elasticIn,
      child: _editMode
          ? _buildExpandedCard(task)
          : ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Dismissible(
                key: ValueKey(task.id),
                background: Container(
                  color: Colors.red,
                ),
                onDismissed: (_) {
                  widget.deleteTaskHandler(task.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Task deleted'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Container(
                  height: 75,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: ListTile(
                            leading: ReorderableDelayedDragStartListener(
                              index: widget.itemIndex,
                              child: const Icon(Icons.drag_indicator),
                            ),
                            title: Text(
                              task.title,
                              maxLines: 1,
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit_rounded),
                              splashRadius: 25,
                              onPressed: toggleEditMode,
                            ),
                          ),
                        ),
                        task.isComplete
                            ? const TaskCompleteOverlay()
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
