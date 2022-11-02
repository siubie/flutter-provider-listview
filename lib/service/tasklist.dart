import 'package:flutter/material.dart';
import 'package:provider_listview/validation/validation_item.dart';

import '../models/task.dart';
import 'database_service.dart';

class Tasklist with ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();

  List<Task> _taskList = [];
  // String _taskName = "";

  bool _isActive = true;
  get taskList => _taskList;
  get taskName => _taskName;

    get isActive => _isActive;

  ValidationItem _taskName = ValidationItem(null, null);

  // validation
  void setTaskName(String? taskName) {
    // validate if input null
    if (taskName == "") {
      _taskName = ValidationItem(null, "Task Name harus diisi");
      _isActive = false;
    } else if (taskName!.length <= 5) {
      // validate if input less than 5 char
      _taskName = ValidationItem(null, "Task Name harus lebih dari 5 karakter");
      _isActive = false;
    } else {
      // if input is correct
      _taskName = ValidationItem(taskName, null);
    }

    notifyListeners();
  }

  void onTaskNameChange(String? value) {
    if (value != "" && value!.length > 5) {
      _isActive = true;
    }
    clear();
    notifyListeners();
  }

  void clear() {
    _taskName = ValidationItem(null, null);
  }

  bool isValidated() {
    return (_taskName.value != null && _taskName.value!.length >= 5)
        ? true
        : false;
  }

  void addNewTask(String taskName) async {
    await _databaseService.insertTask(
      Task(name: taskName, status: 0),
    );
    notifyListeners();

  }

  void changeTaskName(String taskName) {
    taskName = taskName;
    taskName = taskName;
    notifyListeners();
  }

   Future<void> fetchTaskList() async {
    _taskList = await _databaseService.taskList();
    notifyListeners();
  }

  Future<void> addTask() async {
    await _databaseService.insertTask(
      Task(name: taskName, status: 0),
    );
    notifyListeners();
  }

  Future<void> updateTask(String taskName) async {
    print("Update Task ${taskName}");
    await _databaseService.updateTask(taskName);
    fetchTaskList();
    notifyListeners();
  }

  Future<void> deleteTask(Task task) async {
    print("Delete Task ${task.name}");
    await _databaseService.deleteTask(task.name);
    fetchTaskList();
    notifyListeners();
  }
}
