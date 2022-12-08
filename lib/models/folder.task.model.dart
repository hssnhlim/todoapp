class FolderTask {
  String? name;
  bool isChecked = false;
  FolderTask({required this.name, required this.isChecked});
  factory FolderTask.fromJson(json) {
    return FolderTask(
        name: json['name'], isChecked: json['isChecked'] ?? false);
  }
  Map<String, dynamic> toJson() => {"name": name, "task": isChecked};
}
