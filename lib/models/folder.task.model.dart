import 'package:todoapp/models/task.model.dart';

class FolderTask {
  String? name;
  List task;
  FolderTask({required this.name, required this.task});
  factory FolderTask.fromJson(json) {
    return FolderTask(name: json['name'], task: json['task']);
  }
}
