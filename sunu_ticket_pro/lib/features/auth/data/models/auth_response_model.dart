import 'user_model.dart';

class AuthResponseModel {
  final bool success;
  final String? token;
  final UserModel? user;
  final String message;

  AuthResponseModel({
    required this.success,
    this.token,
    this.user,
    required this.message,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      success: json['success'] ?? false,
      token: json['token'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'token': token,
      'user': user?.toJson(),
      'message': message,
    };
  }
}
