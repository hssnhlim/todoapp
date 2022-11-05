class Task {
  String? name;
  String? note;
  bool? reminder;
  String? dateTime;
  String? path;

  Task(
      {required this.name,
      required this.note,
      required this.reminder,
      required this.dateTime,
      required this.path});
  factory Task.fromJson(json) {
    return Task(
        name: json['name'],
        note: json['note'],
        reminder: json['reminder'],
        dateTime: json['dateTime'],
        path: json['path']);
  }
}


