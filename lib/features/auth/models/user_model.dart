class UserModel {
  String userId, name, email;

  UserModel({required this.email, required this.name, required this.userId});

  // fromJson factory method
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  // toJson method (مفيدة للإضافة أو التحديث)
  Map<String, dynamic> toJson() {
    return {'id': userId, 'name': name, 'email': email};
  }
}
