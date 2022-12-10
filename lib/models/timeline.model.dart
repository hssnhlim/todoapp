class Timeline {
  String id; // I have ID here
  String? date;
  String? time;
  String? topic;
  bool? isDone = false;

  Timeline({this.id = '', this.date, this.time, this.topic, this.isDone});

  Timeline.fromSnapshot(snapshot)
      : id = snapshot.data()['id'],
        date = snapshot.data()['date'],
        time = snapshot.data()['time'],
        topic = snapshot.data()['topic'],
        isDone = snapshot.data()['isDone'];

  factory Timeline.fromJson(Map<String, dynamic> json) => Timeline(
      id: json['id'],
      date: json['date'],
      time: json['time'],
      topic: json['topic'],
      isDone: json['isDone']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'date': date, 'time': time, 'topic': topic, 'isDone': isDone};
}
