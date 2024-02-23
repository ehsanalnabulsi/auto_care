import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/services/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginPasswordVisibilityState());
  }

  void userLogin({
    required String phoneNumber,
    required String password,
  }) async {
    emit(LoginLoadingState());
    FormData formData =
        FormData.fromMap({'phoneNumber': phoneNumber, 'password': password});
    try {
      final response = await DioHelper.postForm(
        loginURL,
        data: formData,
      );

      emit(LoginSuccessState(response));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(LoginErrorState(error.response));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(LoginErrorState(error.response));
      } else if (error.response != null) {
        if (error.response!.statusCode == 400) {
          emit(LoginErrorState(error.response));
        } else if (error.response!.statusCode == 401) {
          emit(LoginErrorState(error.response));
        } else if (error.response!.statusCode == 403) {
          emit(LoginErrorState(error.response));
        } else if (error.response!.statusCode == 404) {
          emit(LoginErrorState(error.response));
        } else {
          emit(LoginErrorState(error.response));
        }
      } else {
        emit(LoginErrorState(error.response));
      }
    } catch (error) {
      emit(LoginErrorState(null));
    }
  }
}
