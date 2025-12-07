class UserModel {
  final String id;
  final String phone;
  final String name;
  final String password;
  final String createdAt;
  final bool isVerified;

  UserModel({
    required this.id,
    required this.phone,
    required this.name,
    required this.password,
    required this.createdAt,
    required this.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      phone: json['phone'] ?? '',
      name: json['name'] ?? '',
      password: json['password'] ?? '',
      createdAt: json['created_at'] ?? '',
      isVerified: json['is_verified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'name': name,
      'password': password,
      'created_at': createdAt,
      'is_verified': isVerified,
    };
  }
}
