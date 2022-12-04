import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/authentication/auth.provider.dart';

import '../models/folder.task.model.dart';
import '../models/task.model.dart';

class ToDoDatabase with ChangeNotifier {
  List<FolderTask> folderTask = [];
  List<Task> task = [];

  var key = 'FOLDERLIST${AuthProvider().user!.uid}';
  // reference the hive box
  final myBox = Hive.box('ToDoDatabase');

  // run this method if this is the first time opening the app
  void createInitialData() {
    task = [];
    folderTask = [FolderTask(name: 'Personal', task: task)];
    notifyListeners();
  }

  // load the data from local database
  void loadData() {
    // myBox.delete(key);
    var json = myBox.get(key);

    if (json != null) {
      var jsonResultList = jsonDecode(json);
      jsonResultList.forEach((element) {
        var data = FolderTask.fromJson(element);
        if (!folderTask.contains(element)) {
          folderTask.add(data);
        }
      });
    }
    if (kDebugMode) {
      print(folderTask);
    }
    notifyListeners();
  }

  // update the database
  void updateDatabase() {
    List folder = [];
    for (var element in folderTask) {
      folder.add(element.toJson());
    }
    if (kDebugMode) {
      print(folder);
    }
    var data = jsonEncode(folder);
    myBox.put(key, data);

    notifyListeners();

    // for (var todoTask in task) {
    //   folderJson.add({
    //     "task": [
    //       todoTask.name,
    //       todoTask.note,
    //       todoTask.dueDate,
    //       todoTask.reminderDate,
    //       todoTask.reminderTime,
    //       todoTask.repeat,
    //       todoTask.isChecked
    //     ]
    //   });
    // }

    // var dataTask = jsonEncode(folderJson);
    // myBox.put(key, dataTask);
  }

  void setTask(int index, newTask) {
    var specificIndex = folderTask
        .indexWhere((element) => element.name == folderTask[index].name);
    if (folderTask.isEmpty) {
      createInitialData();
    } else if (specificIndex != -1) {
      folderTask[index] =
          FolderTask(name: folderTask[index].name, task: newTask);
      // folderTask[index] = newTask;

    }
    updateDatabase();
    notifyListeners();
  }

  void removeAt(FolderTask folder, int index) {
    if (folderTask.isEmpty) {
      createInitialData();
    }
    if (folderTask.isNotEmpty) {
      folderTask[index] = folder;
      if (kDebugMode) {
        print(folderTask[index].toJson());
      }
    }
    updateDatabase();
    notifyListeners();
  }

  void reloadData() {
    folderTask.clear();
    loadData();
    notifyListeners();
  }
}
