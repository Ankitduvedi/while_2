class Class {
  Class({
    required this.about,
    required this.name,
    required this.createdAt,
    required this.id,
    required this.email,
    required this.type,
    required this.noOfUsers,
    required this.clas,
    required this.admin,
  });
  late String about;
  late String name;
  late String createdAt;
  late String id;
  late String email;
  late String type;
  late int noOfUsers;
  late String clas;
  late String admin;

  Class.fromJson(Map<String, dynamic> json) {
    about = json['about'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    id = json['id'] ?? '';
    email = json['email'] ?? '';
    type = json['type'] ?? '';
    noOfUsers = json['noOfUsers'] ?? '';
    clas = json['clas'] ?? '';
    admin = json['admin'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['about'] = about;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['email'] = email;
    data['type'] = type;
    data['noOfUsers'] = noOfUsers;
    data['clas'] = clas;
    data['admin'] = admin;

    return data;
  }
}
