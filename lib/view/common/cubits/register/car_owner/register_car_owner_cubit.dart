import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/services/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'register_car_owner_state.dart';

class RegisterCarOwnerCubit extends Cubit<RegisterCarOwnerState> {
  RegisterCarOwnerCubit() : super(RegisterCarOwnerInitial());
  static RegisterCarOwnerCubit get(context) => BlocProvider.of(context);

  //  Control Password Visibility
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterPasswordVisibilityState());
  }

  XFile? pickedAvatar;
  dynamic avatarPath;

  Future<void> pickAvatar() async {
    emit(PickAvatarLoadingState());
    pickedAvatar = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedAvatar != null) {
      avatarPath = pickedAvatar!.path;
      emit(PickAvatarSuccessState());
    } else {
      emit(PickAvatarErrorState());
    }
  }

  void registerCarOwner({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    emit(RegisterCarOwnerLoadingState());
    FormData formData = FormData.fromMap({
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'avatar': await MultipartFile.fromFile(pickedAvatar!.path),
      'password': password,
    });

    try {
      final response = await DioHelper.postForm(
        registerCarOwnerURL,
        data: formData,
      );

      emit(RegisterCarOwnerSuccessState(response));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(RegisterCarOwnerErrorState(error.response));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(RegisterCarOwnerErrorState(error.response));
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            emit(RegisterCarOwnerErrorState(error.response));
            break;
          case 401:
            emit(RegisterCarOwnerErrorState(error.response));
            break;
          case 404:
            emit(RegisterCarOwnerErrorState(error.response));
            break;
          default:
            emit(RegisterCarOwnerErrorState(error.response));
        }
      } else {
        emit(RegisterCarOwnerErrorState(error.response));
      }
    } catch (error) {
      emit(RegisterCarOwnerErrorState(null));
    }
  }
}
