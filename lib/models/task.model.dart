class Task {
  String? name;
  String? note;
  String? reminderDate;
  String? repeat;
  String dueDate;
  bool? isChecked = false;
  String? reminderTime;
  List path = [];

  Task(
      {required this.name,
      required this.note,
      required this.dueDate,
      required this.reminderDate,
      required this.repeat,
      required this.path,
      required this.reminderTime,
      this.isChecked});
  factory Task.fromJson(json) {
    return Task(
      name: json['name'],
      note: json['note'],
      dueDate: json['dueDate'],
      reminderDate: json['reminderDate'],
      reminderTime: json['reminderTime'],
      repeat: json['repeat'],
      path: json['path'],
    );
  }
}
