import 'package:auto_care/data/models/user_model.dart';

class LoginModel {
  late final String message;
  late final bool status;
  late final User data;
  LoginModel({required this.data, required this.message, required this.status});
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      message: json['message'],
      data: json['data'],
      status: json['status'],
    );
  }
}
