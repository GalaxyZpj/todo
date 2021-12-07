import 'package:flutter/material.dart';

class TaskForm extends StatefulWidget {
  final String taskTitle;
  final String taskDescription;
  final Function closeFormHandler;
  final Function saveHandler;

  const TaskForm({
    Key? key,
    required this.taskTitle,
    required this.taskDescription,
    required this.closeFormHandler,
    required this.saveHandler,
  }) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _form = GlobalKey<FormState>();
  var _isInitialized = false;
  final _taskInput = {
    'title': '',
    'description': '',
  };

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      _taskInput['title'] = widget.taskTitle;
      _taskInput['description'] = widget.taskDescription;
      _isInitialized = true;
    }
    super.didChangeDependencies();
  }

  void saveTaskHandler() {
    var isValid = _form.currentState?.validate();
    if (isValid != null && isValid) {
      _form.currentState?.save();
      widget.saveHandler(_taskInput['title'], _taskInput['description']);
      widget.closeFormHandler();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            onFieldSubmitted: (_) => saveTaskHandler(),
            initialValue: _taskInput['title'],
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
            textCapitalization: TextCapitalization.sentences,
            onSaved: (value) => _taskInput['title'] = value as String,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Provide a title for task';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: _taskInput['description'],
            textCapitalization: TextCapitalization.sentences,
            onSaved: (value) => _taskInput['description'] = value as String,
            decoration: const InputDecoration(
              label: Text('Description'),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => widget.closeFormHandler(),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 15),
              ElevatedButton(
                onPressed: saveTaskHandler,
                child: const Text('Save'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
