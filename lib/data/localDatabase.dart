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
        folderTask.add(data);
      });
    }
  }

  // update the database
  void updateDatabase() {
    List folderJson = [];
    int? index;

    for (var todo in folderTask) {
      folderJson.add({
        "name": todo.name,
        "task": [
          task[index!].name,
          task[index].note,
          task[index].dueDate,
          task[index].reminderDate,
          task[index].reminderTime,
          task[index].repeat,
          task[index].path,
          task[index].isChecked,
        ]
      });
    }

    var data = jsonEncode(folderJson);
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
}
