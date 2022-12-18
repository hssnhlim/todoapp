import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/authentication/auth.provider.dart';

import '../models/folder.task.model.dart';

class ToDoDatabase with ChangeNotifier {
  factory ToDoDatabase() => ToDoDatabase._();
  //execute when app start running
  ToDoDatabase._() {
    loadData();
  }

  List<FolderTask> folderTask = [];
  // List<Task> task = [];

  var key = 'FOLDERLIST${AuthProvider.instance.getCurrentUID()}';
  // reference the hive box
  final myBox = Hive.box('ToDoDatabase');

  // run this method if this is the first time opening the app
  void createInitialData() {
    folderTask = [FolderTask(name: 'Buy groceries stuff', isChecked: false)];
    notifyListeners();
  }

  // load the data from local database
  void loadData() {
    var json = myBox.get(key);

    if (json != null) {
      var jsonResultList = jsonDecode(json);

      jsonResultList.forEach((element) {
        var data = FolderTask.fromJson(element);
        if (!folderTask.contains(element)) {
          folderTask.add(data);
          print(data.isChecked);
          notifyListeners();
        }
      });
    } else {
      createInitialData();
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
      print("save $folder");
    }
    try {
      var data = jsonEncode(folder);
      myBox.put(key, data);
    } catch (e) {
      print(e);
    }

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

  void setValue(bool? value, int index) {
    folderTask[index].isChecked = value!;
    notifyListeners();
    updateDatabase();
  }

  void addTask(FolderTask data) {
    folderTask.add(data);
    notifyListeners();
    updateDatabase();
  }

  void editTask(FolderTask data, int index) {
    folderTask[index] = data;
    notifyListeners();
    updateDatabase();
  }
}
