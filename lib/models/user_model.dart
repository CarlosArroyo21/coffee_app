class UserModel {
  final int? id;
  final String? username;

  UserModel({this.id, this.username});

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
    );
  }
}