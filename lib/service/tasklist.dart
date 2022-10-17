import 'package:flutter/material.dart';

import '../models/task.dart';
import 'database_service.dart';

class Tasklist with ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  final List<Task> _taskList = [];

  get taskList => _taskList;

  void addNewTask() {
    _taskList.add(
      Task(name: "Task Baru", status: 0),
    );
    notifyListeners();
  }
}
