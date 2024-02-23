import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/core/services/dio_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:image_picker/image_picker.dart';

part 'add_new_car_state.dart';

class AddNewCarCubit extends Cubit<AddNewCarState> {
  AddNewCarCubit() : super(AddNewCarInitial());
  static AddNewCarCubit get(context) => BlocProvider.of(context);
  late List origins;
  late List brands;
  late List carsModels;
  late List<String> originsNames;
  late List<String> brandsNames;
  late List<String> modelsNames;
  late int selectedOrigin;
  late int selectedBrand;
  late int selectedCarModel;

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

  void getCarModelBySelectedBrand(value) async {
    emit(GetCarModelsLoadingState());
    for (Map<String, dynamic> brand in brands) {
      if (brand['name'] == value) {
        selectedBrand = brand['id'];
      }
    }

    await DioHelper.get(carModelsURL, query: {'brand': selectedBrand})
        .then((value) {
      carsModels = value.data;

      modelsNames =
          carsModels.map((item) => item['name'].toString()).toSet().toList();

      emit(GetCarModelsSuccessState());
    }).catchError((onError) {
      emit(GetCarModelsErrorState());
    });
  }

  void updateSelectedCarModel(value) {
    for (Map<String, dynamic> carModel in carsModels) {
      if (carModel['name'] == value) {
        selectedCarModel = carModel['id'];
      }
    }
  }

  Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  void sendMobileToken() async {
    emit(SendMobileTokenLoadingState());
    String? mobileToken = await getToken();
    print('mobile token : $mobileToken');
    String? token = CacheHelper.getString(key: 'token');
    FormData formData = FormData.fromMap({'mobileToken': mobileToken});
    print('JWT $token');
    final response = await DioHelper.postForm(sendMobileTokenURL,
        token: 'JWT $token', data: formData);
    print(response);
    if (response.statusCode == 201) {
      emit(SendMobileTokenSuccessState());
    } else if (response.statusCode == 500) {
      emit(SendMobileTokenErrorState());
    }
  }

  void addNewCar({
    required String plateNumber,
    required String carColor,
    required String carYear,
    required int origin,
    required int brand,
    required int model,
  }) async {
    FormData addCarFormData = FormData.fromMap({
      'plateNumber': plateNumber,
      'carBrand': brand,
      'carModel': model,
      'carOrigin': origin,
      'carYear': carYear,
      'carColor': carColor,
      'avatar': await MultipartFile.fromFile(pickedAvatar!.path),
    });
    String? token = CacheHelper.getString(key: 'token');
    try {
      emit(AddNewCarLoadingState());
      final response = await DioHelper.postForm(addNewCarURL,
          data: addCarFormData, token: 'JWT $token');

      emit(AddNewCarSuccessState(response));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(AddNewCarErrorState(error.message));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(AddNewCarErrorState(error.message));
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            emit(AddNewCarErrorState(error.message));
            break;
          case 401:
            emit(AddNewCarErrorState(error.message));
            break;
          case 404:
            emit(AddNewCarErrorState(error.message));
            break;
          default:
            emit(AddNewCarErrorState(error.message));
        }
      } else {
        emit(AddNewCarErrorState(error.message));
      }
    } catch (error) {
      emit(AddNewCarErrorState(error.toString()));
    }
  }
}

// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNjMxMjU1NiwiaWF0IjoxNzA3NjcyNTU2LCJqdGkiOiI5YzM4MDU3NjhhOTA0MmE2ODEyNjg2NjE1ZDY5MzJmOSIsInVzZXJfaWQiOjQyfQ.IcG0fAjU3ib5FGQgRDS9gb8QcOiJ9VQdDk8XJfzJiiY