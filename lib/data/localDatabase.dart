import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:todoapp/authentication/auth.provider.dart';

import '../models/folder.task.model.dart';
import '../models/task.model.dart';

class ToDoDatabase {
  List<FolderTask> folderTask = [];
  List<Task> task = [];

  var key = 'FOLDERLIST${AuthProvider().user!.uid}';
  // reference the hive box
  final myBox = Hive.box('ToDoDatabase');

  // run this method if this is the first time opening the app
  void createInitialData() {
    task = [];
    folderTask = [FolderTask(name: 'Personal', task: task)];
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
  }

  // update the database
  void updateDatabase() {
    List folder = [];
    folderTask.forEach((element) {
      folder.add(element.toJson());
    });
    print(folder);
    var data = jsonEncode(folder);
    myBox.put(key, data);

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
    if (folderTask.isEmpty) {
      createInitialData();
    } else {
      folderTask[index] = newTask;
    }
    updateDatabase();
  }

  void removeAt(FolderTask folder, int index) {
    if (folderTask.isEmpty) {
      createInitialData();
    }
    if (folderTask.isNotEmpty) {
      folderTask[index] = folder;
      print(folderTask[index].toJson());
    }
    updateDatabase();
  }

  void reloadData() {
    folderTask.clear();
    loadData();
  }
}
