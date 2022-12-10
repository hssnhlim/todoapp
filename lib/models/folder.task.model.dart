class FolderTask {
  String? name;
  bool? isChecked;
  FolderTask({required this.name, required this.isChecked});
  factory FolderTask.fromJson(json) {
    return FolderTask(name: json['name'], isChecked: json['isChecked']);
  }
  Map<String, dynamic> toJson() => {"name": name, "isChecked": isChecked};
}
