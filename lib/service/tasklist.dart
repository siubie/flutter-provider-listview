import 'package:flutter/material.dart';

import '../models/validationInput.dart';
import '../models/task.dart';
import 'database_service.dart';

class Tasklist with ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Task> _taskList = [];

  get taskList => _taskList;
  get taskName => _taskName;
  bool isActive = true;

  // String _taskName = "";
  validationInput _taskName = validationInput(null, null);

  // validasi apakah sesuai kriteria
  bool isValidated() {
    return (_taskName.value != null &&
            _taskName.value!.length >= 4 &&
            _taskName.value!.length < 100)
        ? true
        : false;
  }

  // validasi inputan berisi pesan error
  void setTaskName(String? taskName) {
    // jika inputan null
    if (taskName == "") {
      _taskName = validationInput(null, "Your task name should filled");
      isActive = false;
    } else if (taskName!.length <= 4) {
      // jika inputan kurang dari 4
      _taskName =
          validationInput(null, "Task name should be more than 4 character");
      isActive = false;
    } else if (taskName.length >= 100) {
      // jika inputan lebih dari 100
      _taskName =
          validationInput(null, "Task name should be less than 100 character");
      isActive = false;
    } else {
      // jika inputan memenuhi kriteria
      _taskName = validationInput(taskName, null);
    }
    notifyListeners();
  }

  // ketika task name nya berubah
  void whenTaskNameChange(String? value) {
    if (value != "" && value!.length >= 4 && value.length < 100) {
      isActive = true;
    }
    clear();
    notifyListeners();
  }

  void clear() {
    _taskName = validationInput(null, null);
  }

  void changeTaskName(String taskName) {
    _taskName = taskName as validationInput;
    notifyListeners();
  }

  Future<void> fetchTaskList() async {
    _taskList = await _databaseService.taskList();
    notifyListeners();
  }

  Future<void> addTask(String taskName) async {
    await _databaseService.insertTask(
      Task(
        name: taskName,
        status: 0,
      ),
    );
    notifyListeners();
  }

  Future<void> deleteTaskList(Task task) async {
    await _databaseService.deleteTask(task.name);
    fetchTaskList();
    // print("Delete Task ${task.name}");
    notifyListeners();
  }

  Future<void> updateTask(Task task, String newVal) async {
    await _databaseService.updateItem(task, newVal);
    await fetchTaskList();
    notifyListeners();
  }
}
