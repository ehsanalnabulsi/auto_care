import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/services/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/constant/end_points.dart';

part 'register_tow_car_owner_state.dart';

class RegisterTowCarOwnerCubit extends Cubit<RegisterTowCarOwnerState> {
  RegisterTowCarOwnerCubit() : super(RegisterTowCarOwnerInitial());
  static RegisterTowCarOwnerCubit get(context) => BlocProvider.of(context);

  late List origins;
  late List<String> originsNames;
  late int selectedOrigin;
  late List cities;
  late List<String> citiesNames;
  late int selectedCoverageCity;
  late List brands;
  late List<String> brandsNames;
  late int selectedBrand;
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  XFile? pickedAvatar;
  dynamic avatarPath;

  void getCities() async {
    emit(GetCitiesLoadingState());
    await DioHelper.get(citiesURL).then((value) {
      cities = value.data;

      citiesNames =
          cities.map((item) => item['name'].toString()).toSet().toList();

      emit(GetCitiesSuccessState());
    }).catchError((onError) {
      emit(GetOriginsErrorState());
    });
  }

  void getOrigins() async {
    emit(GetOriginsLoadingState());
    await DioHelper.get(towCarOrigins).then((value) {
      origins = value.data;

      originsNames =
          origins.map((item) => item['name'].toString()).toSet().toList();

      emit(GetOriginsSuccessState());
    }).catchError((onError) {
      emit(GetOriginsErrorState());
    });
  }

  void getBrandsBySelectedOrigin(value) async {
    emit(GetBrandsLoadingState());
    for (Map<String, dynamic> origin in origins) {
      if (origin['name'] == value) {
        selectedOrigin = origin['id'];
      }
    }

    await DioHelper.get(towCarBrands, query: {'origin': selectedOrigin})
        .then((value) {
      brands = value.data;

      brandsNames =
          brands.map((item) => item['name'].toString()).toSet().toList();

      emit(GetBrandsSuccessState());
    }).catchError((onError) {
      emit(GetBrandsErrorState());
    });
  }

  void updateSelectedCity(cityName) {
    emit(UpdateCityLoadingState());
    for (Map<String, dynamic> city in cities) {
      if (city['name'] == cityName) {
        selectedCoverageCity = city['id'];
      }
    }
    emit(UpdateCitySuccessState());
  }

  void updateSelectedBrand(brandName) {
    emit(UpdateBrandLoadingState());
    for (Map<String, dynamic> brand in brands) {
      if (brand['name'] == brandName) {
        selectedBrand = brand['id'];
      }
    }
    emit(UpdateBrandSuccessState());
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterPasswordVisibilityState());
  }

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

  void registerTowCarOwner({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String carYear,
    required String plateNumber,
    required String password,
    required int origin,
    required int brand,
    required int coverageCity,
  }) async {
    FormData basicInfoFormData = FormData.fromMap({
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'avatar': await MultipartFile.fromFile(pickedAvatar!.path),
      'password': password
    });
    FormData towCarInfoFormData = FormData.fromMap({
      'carOrigin': origin,
      'carBrand': brand,
      'carYear': carYear,
      'plateNumber': plateNumber,
      'coverageCity': coverageCity,
      'available': false
    });
    try {
      emit(RegisterTowCarOwnerLoadingState());

      final response = await DioHelper.postForm(registerTowCarOwnerURL,
          data: basicInfoFormData);

      if (response.statusCode == 201) {
        try {
          final response2 = await DioHelper.postForm(registerTowCarURL,
              token: 'JWT ${response.data['access']}',
              data: towCarInfoFormData);
          emit(RegisterTowCarOwnerSuccessState(response2));
        } catch (error) {
          // emit(RegisterTowCarOwnerErrorState(error.toString()));
        }
      }

      emit(RegisterTowCarOwnerSuccessState(response));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(RegisterTowCarOwnerErrorState(error.response));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(RegisterTowCarOwnerErrorState(error.response));
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            emit(RegisterTowCarOwnerErrorState(error.response));
            break;
          case 401:
            emit(RegisterTowCarOwnerErrorState(error.response));
            break;
          case 404:
            emit(RegisterTowCarOwnerErrorState(error.response));
            break;
          default:
            emit(RegisterTowCarOwnerErrorState(error.response));
        }
      } else {
        emit(RegisterTowCarOwnerErrorState(error.response));
      }
    } catch (error) {
      emit(RegisterTowCarOwnerErrorState(null));
    }
  }
}
