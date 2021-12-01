import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final Map<String, Task> _taskMap = {};

  Map<String, Task> get taskMap {
    return {..._taskMap};
  }

  Task? fetchTask(String id) {
    return _taskMap[id];
  }

  void addTask(String title, String description) {
    final id = DateTime.now().toString();
    _taskMap[id] = Task(id: id, title: title, description: description);
    notifyListeners();
  }

  void updateTask(String id, String title, String description) {
    if (_taskMap.containsKey(id)) {
      _taskMap.update(
        id,
        (_) => Task(id: id, title: title, description: description),
      );
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    if (_taskMap.containsKey(id)) {
      _taskMap.remove(id);
      notifyListeners();
    }
  }
}
