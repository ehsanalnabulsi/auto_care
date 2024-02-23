import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/core/services/dio_helper.dart';

part 'cars_page_state.dart';

class CarsPageCubit extends Cubit<CarsPageState> {
  CarsPageCubit() : super(CarsPageInitial());
  static CarsPageCubit get(context) => BlocProvider.of(context);
  late List userCars;
  late int selectedCarBrand;
  late List workshops;
  void getUserCars() async {
    String? token = CacheHelper.getString(key: 'token');
    try {
      emit(GetUserCarsLoadingState());
      final response = await DioHelper.get(userCarsURL, token: 'JWT $token');
      userCars = response.data;
      
      emit(GetUserCarsSuccessState());
    } catch (error) {
      emit(GetUserCarsErrorState());
    }
  }

  void updateSelectedCar(int id) {
    selectedCarBrand = id;
  }

  void getWorkshopsByBrandId(int id) async {
    emit(GetWorkshopsByBrandIdLoadingState());
    final response = await DioHelper.get(workshopsURL, query: {'brand': id});
    workshops = response.data;
    emit(GetWorkshopsByBrandIdSuccessState());
  }
}
