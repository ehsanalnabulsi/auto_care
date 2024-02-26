import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/services/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
part 'register_parts_supplier_state.dart';

// enum Status { createRequest, pending, setAppointment ,}

class RegisterPartsSupplierCubit extends Cubit<RegisterPartsSupplierState> {
  RegisterPartsSupplierCubit() : super(RegisterPartsSupplierInitial());
  static RegisterPartsSupplierCubit get(context) => BlocProvider.of(context);
  late List specialists;
  late List origins;
  late List<String> originsNames;
  late int selectedOrigin;
  DateTime date = DateTime(15, 10, 2024,12);
  late List brands;
  late List<String> brandsNames;
  late List<int> selectedBrands;
  String address = '';
  LatLng storeLocation = const LatLng(0, 0);
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  XFile? pickedAvatar;
  dynamic avatarPath;
  dynamic logoPath;
  XFile? pickedLogo;
  void updateLocation(TapPosition tapPosition, LatLng newLocation) async {
    try {
      emit(UpdateStoreLocationLocationLoadingState());

      storeLocation = newLocation;

      emit(UpdateStoreLocationLocationSuccessState());
    } catch (e) {
      emit(UpdateStoreLocationLocationErrorState());
    }
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

  void updateSelectedBrands(brandNames) {
    emit(UpdateBrandsLoadingState());
    List<int> brandIds = [];
    for (String brandName in brandNames) {
      Map<String, dynamic>? brand =
          brands.firstWhere((element) => element['name'] == brandName);
      brandIds.add(brand!['id']);
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

  void registerPartsSupplier(
      {required String fullName,
      required String phoneNumber,
      required String email,
      required String password,
      required String storeName,
      required String contactNumber,
      required int origin,
      required List<int>? brands,
      required String address}) async {
    emit(RegisterPartsSupplierLoadingState());
    FormData basicInfoFormData = FormData.fromMap({
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'storeAvatar': await MultipartFile.fromFile(pickedAvatar!.path),
      'password': password,
      'storeName': storeName,
      'contactNumber': contactNumber,
      'address': address,
      'origin': origin,
      'brands': brands,
      'logo': await MultipartFile.fromFile(pickedLogo!.path),
      'location': '${storeLocation.latitude},${storeLocation.longitude}'
    });

    try {
      emit(RegisterPartsSupplierLoadingState());

      final response = await DioHelper.postForm(registerPartsSupplierURL,
          data: basicInfoFormData);

      emit(RegisterPartsSupplierSuccessState(response));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(RegisterPartsSupplierErrorState(error.response));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(RegisterPartsSupplierErrorState(error.response));
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            emit(RegisterPartsSupplierErrorState(error.response));
            break;
          case 401:
            emit(RegisterPartsSupplierErrorState(error.response));
            break;
          case 404:
            emit(RegisterPartsSupplierErrorState(error.response));
            break;
          default:
            emit(RegisterPartsSupplierErrorState(error.response));
        }
      } else {
        emit(RegisterPartsSupplierErrorState(error.response));
      }
    } catch (error) {
      emit(RegisterPartsSupplierErrorState(null));
    }
  }
}
