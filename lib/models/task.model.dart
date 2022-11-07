class Task {
  String? name;
  String? note;
  bool? reminder;
  String? dateTime;
  String? path;
  bool? isChecked = false;

  Task(
      {required this.name,
      required this.note,
      required this.reminder,
      required this.dateTime,
      required this.path,
      this.isChecked});
  factory Task.fromJson(json) {
    return Task(
      name: json['name'],
      note: json['note'],
      reminder: json['reminder'],
      dateTime: json['dateTime'],
      path: json['path'],
    );
  }
}
