import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/services/cache.dart';
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
    'http://192.168.100.246:8000/media/autocare/images/photo_1_2024-01-29_20-30-34.jpg',
    'http://192.168.100.246:8000/media/autocare/images/photo_2_2024-01-29_20-30-34.jpg',
    'http://192.168.100.246:8000/media/autocare/images/photo_3_2024-01-29_20-30-34.jpg',
    'http://192.168.100.246:8000/media/autocare/images/photo_4_2024-01-29_20-30-34.jpg'
  ];

  void getData() async {
    emit(GetDataLoadingState());

    getWorkshops();
    getPartsSuppliers();
    emit(GetDataSuccessState());
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
      final response = await DioHelper.get(carOwnerPartsSupplier);
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
