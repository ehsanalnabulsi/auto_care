part of 'login_cubit.dart';

class LoginState {}

class LoginInitial extends LoginState {}

class LoginPasswordVisibilityState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final Response<dynamic> response;
  LoginSuccessState(this.response);
}

class LoginErrorState extends LoginState {
  final Response? errorResponse;
  LoginErrorState(this.errorResponse);
}
