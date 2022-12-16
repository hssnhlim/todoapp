class Users {
  String? id;
  String? name;
  String? email;
  String? phone;

  Users({
    this.id,
    this.name,
    this.email,
    this.phone,
  });

  Users.fromSnapshot(snapshot)
      : id = snapshot.data()['id'],
        name = snapshot.data()['name'],
        email = snapshot.data()['email'],
        phone = snapshot.data()['phone'];

  factory Users.fromJson(Map<String, dynamic> json) => Users(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'email': email, 'phone': phone};
}
