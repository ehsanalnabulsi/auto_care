import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/services/dio_helper.dart';
import 'package:dio/dio.dart';

part 'car_owner_home_page_state.dart';

class CarOwnerHomePageCubit extends Cubit<CarOwnerHomePageState> {
  CarOwnerHomePageCubit() : super(CarOwnerHomePageInitialState());
  static CarOwnerHomePageCubit get(context) => BlocProvider.of(context);
  List workshops = [];
  List partsSuppliers = [];
  bool selectedTag = false;
  List<String> sliderImages = [
    'http://10.0.2.2:8000/media/autocare/images/photo_1_2024-01-29_20-30-34.jpg',
    'http://10.0.2.2:8000/media/autocare/images/photo_2_2024-01-29_20-30-34.jpg',
    'http://10.0.2.2:8000/media/autocare/images/photo_3_2024-01-29_20-30-34.jpg',
    'http://10.0.2.2:8000/media/autocare/images/photo_4_2024-01-29_20-30-34.jpg'
  ];
  List partsSupplierProducts = [];

  void getData() async {
    emit(GetDataLoadingState());
    getSliderImages();
    getWorkshops();
    getPartsSuppliers();
    emit(GetDataSuccessState());
  }

  void getSliderImages() async {
    try {
      emit(GetSliderImagesLoadingState());
      final response = await DioHelper.get(sliderImagesURL);
      List data = response.data;
      print(data);
      for (final item in data) {
        final imageUrl = item['images'];
        sliderImages.add(imageUrl);
      }
      print(sliderImages);

      emit(GetSliderImagesSuccessState());
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(GetSliderImagesErrorState());
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(GetSliderImagesErrorState());
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            emit(GetSliderImagesErrorState());
            break;
          case 401:
            emit(GetSliderImagesErrorState());
            break;
          case 404:
            emit(GetSliderImagesErrorState());
            break;
          default:
            emit(GetSliderImagesErrorState());
        }
      } else {
        emit(GetSliderImagesErrorState());
      }
    } catch (error) {
      emit(GetSliderImagesErrorState());
    }
  }

  void getWorkshops() async {
    try {
      emit(GetWorkshopsLoadingState());
      final response = await DioHelper.get(workshopsURL);
      workshops = response.data;

      emit(GetWorkshopsSuccessState(response));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(GetWorkshopsErrorState());
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(GetWorkshopsErrorState());
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            emit(GetWorkshopsErrorState());
            break;
          case 401:
            emit(GetWorkshopsErrorState());
            break;
          case 404:
            emit(GetWorkshopsErrorState());
            break;
          default:
            emit(GetWorkshopsErrorState());
        }
      } else {
        emit(GetWorkshopsErrorState());
      }
    } catch (error) {
      emit(GetWorkshopsErrorState());
    }
  }

  void getPartsSuppliers() async {
    try {
      emit(GetPartsSuppliersLoadingState());
      final response = await DioHelper.get(partsSuppliersURL);
      partsSuppliers = response.data;

      emit(GetPartsSuppliersSuccessState(response));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(GetPartsSuppliersErrorState(error.message));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(GetPartsSuppliersErrorState(error.message));
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            emit(GetPartsSuppliersErrorState(error.message));
            break;
          case 401:
            emit(GetPartsSuppliersErrorState(error.message));
            break;
          case 404:
            emit(GetPartsSuppliersErrorState(error.message));
            break;
          default:
            emit(GetPartsSuppliersErrorState(error.message));
        }
      } else {
        emit(GetPartsSuppliersErrorState(error.message));
      }
    } catch (error) {
      emit(GetPartsSuppliersErrorState(error.toString()));
    }
  }
}
