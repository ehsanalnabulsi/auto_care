import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/services/dio_helper.dart';

part 'car_owner_home_page_state.dart';

class CarOwnerHomePageCubit extends Cubit<CarOwnerHomePageState> {
  CarOwnerHomePageCubit() : super(CarOwnerHomePageInitialState());
  static CarOwnerHomePageCubit get(context) => BlocProvider.of(context);
  List workshops = [];
  List partsSuppliers = [];
  bool selectedTag = false;
  late List sliderImages;

  void getData() async {
    emit(GetDataLoadingState());

    getWorkshops();
    getPartsSuppliers();
    emit(GetDataSuccessState());
  }

  void getSliderImages() async {
    try {
      emit(GetSliderImagesLoadingState());
      final response = await DioHelper.get(sliderImagesURL);
      sliderImages = response.data;

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
