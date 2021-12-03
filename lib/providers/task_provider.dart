import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final Map _taskMap = {};
  List<String> _taskIdList = [];
  var isInitialized = false;

  TaskProvider() {
    setup();
  }

  Future<void> setup() async {
    final _prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> state = json.decode(_prefs.getString('task') ?? '{}');
    if (state.isEmpty) {
      state = {'map': {}, 'sequence': []};
    }
    _taskMap.addAll(state['map'].map(
      (id, taskJson) => MapEntry(id as String, Task.fromJson(taskJson)),
    ));
    _taskIdList = state['sequence'].cast<String>();
    isInitialized = true;
    notifyListeners();
  }

  Map<String, Task> get taskMap {
    return {..._taskMap};
  }

  List<String> get taskIdList {
    return _taskIdList.reversed.toList();
  }

  String get _nextTaskId {
    return _taskIdList.isNotEmpty
        ? (int.parse(_taskIdList[_taskIdList.length - 1]) + 1).toString()
        : '1';
  }

  Future<void> saveState() async {
    final _prefs = await SharedPreferences.getInstance();
    final map = _taskMap.map((key, value) => MapEntry(key, value.toMap()));
    final newState = {'map': map, 'sequence': _taskIdList};
    await _prefs.setString('task', json.encode(newState));
  }

  void changeTaskIndex(int prevIndex, int newIndex) {
    // TODO: Fix implementation
    // print("PREV INDEX: $prevIndex | NEW INDEX: $newIndex");
    var removedId = _taskIdList.removeAt(_taskIdList.length - 1 - prevIndex);
    if (newIndex >= _taskIdList.length) {
      _taskIdList.add(removedId);
    } else {
      _taskIdList.insert(_taskIdList.length - newIndex - 1, removedId);
    }
    notifyListeners();
  }

  Task? fetchTask(String id) {
    return _taskMap[id];
  }

  Future<void> addTask(String title, String description) async {
    final id = _nextTaskId;
    _taskIdList.add(id);
    _taskMap[id] = Task(id: id, title: title, description: description);
    notifyListeners();
    await saveState();
  }

  Future<void> updateTask(String id, String title, String description) async {
    if (_taskMap.containsKey(id)) {
      _taskMap.update(
        id,
        (_) => Task(id: id, title: title, description: description),
      );
      notifyListeners();
      await saveState();
    }
  }

  Future<void> deleteTask(String id) async {
    if (_taskMap.containsKey(id)) {
      _taskMap.remove(id);
      _taskIdList.remove(id);
      notifyListeners();
      await saveState();
    }
  }
}
