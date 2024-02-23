import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/services/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

part 'register_workshop_owner_state.dart';

class RegisterWorkshopOwnerCubit extends Cubit<RegisterWorkshopOwnerState> {
  RegisterWorkshopOwnerCubit() : super(RegisterWorkshopOwnerInitial());
  static RegisterWorkshopOwnerCubit get(context) => BlocProvider.of(context);
  late List specialists;

  List<String> specialistsNames = [];
  late int selectedSpecialist;
  late List origins;
  late List<String> originsNames;
  late int selectedOrigin;
  late List brands;
  late List<String> brandsNames;
  late List<int> selectedBrands;
  String address = '';
  LatLng workshopLocation = const LatLng(0, 0);
  String? encodedWorkshopLocation;
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  XFile? pickedAvatar;
  dynamic avatarPath;
  dynamic logoPath;
  XFile? pickedLogo;

  void updateLocation(TapPosition tapPosition, LatLng newLocation) async {
    try {
      emit(UpdateWorkshopLocationLocationLoadingState());

      workshopLocation = newLocation;

      emit(UpdateWorkshopLocationLocationSuccessState());
    } catch (e) {
      emit(UpdateWorkshopLocationLocationErrorState());
    }
  }

  void getSpecialists() async {
    emit(GetSpecialistsLoadingState());
    await DioHelper.get(specialistsURL).then((value) {
      specialists = value.data;

      specialistsNames =
          specialists.map((item) => item['name'].toString()).toList();
      emit(GetSpecialistsSuccessState());
    }).catchError((onError) {
      emit(GetSpecialistsErrorState());
    });
  }

  void getOrigins() async {
    emit(GetOriginsLoadingState());
    await DioHelper.get(originsURL).then((value) {
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

    await DioHelper.get(brandsURL, query: {'origin': selectedOrigin})
        .then((value) {
      brands = value.data;

      brandsNames =
          brands.map((item) => item['name'].toString()).toSet().toList();

      emit(GetBrandsSuccessState());
    }).catchError((onError) {
      emit(GetBrandsErrorState());
    });
  }

  void updateSelectedSpecialist(specialistName) {
    emit(UpdateSpecialistLoadingState());
    for (Map<String, dynamic> item in specialists) {
      if (item['name'] == specialistName) {
        selectedSpecialist = item['id'];
      }
    }

    emit(UpdateSpecialistSuccessState());
  }

  void updateSelectedBrands(brandNames) {
    emit(UpdateBrandsLoadingState());
    List<int> brandIds = [];
    for (String brandName in brandNames) {
      Map<String, dynamic>? brand =
          brands.firstWhere((element) => element['name'] == brandName);
      brandIds.add(brand?['id']);
    }
    selectedBrands = brandIds;
    emit(UpdateBrandsSuccessState());
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

  Future<void> pickLogo() async {
    emit(PickLogoLoadingState());
    pickedLogo = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedLogo != null) {
      logoPath = pickedLogo!.path;
      emit(PickLogoSuccessState());
      // emit(UpdateValueSuccessState());
    } else {
      emit(PickLogoErrorState());
    }
  }

  void registerWorkshopOwner(
      {required String fullName,
      required String phoneNumber,
      required String email,
      required String password,
      required String workshopName,
      required String contactNumber,
      required String address,
      required int specialist,
      required int origin,
      required List<int>? brands}) async {
    FormData basicInfoFormData = FormData.fromMap({
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'avatar': await MultipartFile.fromFile(pickedAvatar!.path),
      'password': password
    });
    FormData workshopInfoFormData = FormData.fromMap({
      'workshopName': workshopName,
      'contactNumber': contactNumber,
      'origin': origin,
      'brands': brands,
      'location': '${workshopLocation.latitude},${workshopLocation.longitude}',
      'specialist': specialist,
      'logo': await MultipartFile.fromFile(pickedLogo!.path),
      'address': address,
      'currentCars': 1,
    });
    try {
      emit(RegisterWorkshopOwnerLoadingState());

      final response = await DioHelper.postForm(registerWorkshopOwnerURL,
          data: basicInfoFormData);
      late Response responseApi2;
      if (response.statusCode == 201) {
        try {
          final response2 = await DioHelper.postForm(registerWorkshopURL,
              token: 'JWT ${response.data['token']}',
              data: workshopInfoFormData);
          responseApi2 = response2;
        } catch (error) {
          '';
        }
      }

      emit(RegisterWorkshopOwnerSuccessState(responseApi2));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(RegisterWorkshopOwnerErrorState(error.response));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(RegisterWorkshopOwnerErrorState(error.response));
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            emit(RegisterWorkshopOwnerErrorState(error.response));
            break;
          case 401:
            emit(RegisterWorkshopOwnerErrorState(error.response));
            break;
          case 404:
            emit(RegisterWorkshopOwnerErrorState(error.response));
            break;
          default:
            emit(RegisterWorkshopOwnerErrorState(error.response));
        }
      } else {
        emit(RegisterWorkshopOwnerErrorState(error.response));
      }
    } catch (error) {
      emit(RegisterWorkshopOwnerErrorState(null));
    }
  }
}
