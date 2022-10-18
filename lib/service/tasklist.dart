import 'package:flutter/material.dart';

import '../models/task.dart';
import 'database_service.dart';

class Tasklist with ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();

  List<Task> _taskList = [];
  String _taskName = "";

  get taskList => _taskList;
  get taskName => _taskName;

  void changeTaskName(String taskName) {
    _taskName = taskName;
    notifyListeners();
  }

  Future<void> fetchTaskList() async {
    _taskList = await _databaseService.taskList();
    notifyListeners();
  }

  Future<void> addTask() async {
    await _databaseService.insertTask(
      Task(name: _taskName, status: 0),
    );
    _taskList = await _databaseService.taskList();
    notifyListeners();
  }
  // final List<Task> _taskList = [];

  // get taskList => _taskList;

  // void addNewTask() {
  //   _taskList.add(
  //     Task(name: "Task Baru", status: 0),
  //   );
  //   notifyListeners();
  // }
}
