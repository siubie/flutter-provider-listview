import 'package:flutter/material.dart';
import 'package:provider_listview/models/task.dart';

class Tasklist with ChangeNotifier {
  final List<Task> _taskList = [];

  get taskList => _taskList;

  void addNewTask() {
    _taskList.add(
      Task(name: "Task Baru", status: false),
    );
    notifyListeners();
  }
}
