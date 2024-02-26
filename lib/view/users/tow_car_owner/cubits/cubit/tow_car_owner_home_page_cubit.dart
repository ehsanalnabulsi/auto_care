import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/core/services/dio_helper.dart';
import 'package:auto_care/core/services/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

part 'tow_car_owner_home_page_state.dart';

class TowCarOwnerHomePageCubit extends Cubit<TowCarOwnerHomePageState> {
  TowCarOwnerHomePageCubit() : super(TowCarOwnerHomePageInitial());
  static TowCarOwnerHomePageCubit get(context) => BlocProvider.of(context);

  Future<void>? getCurrentLocation() async {
    emit(GetCurrentLocationLoadingState());
    final LocationData locationData =
        await LocationService.getCurrentLocation();
    emit(GetCurrentLocationSuccessState(locationData));
  }

  bool isAvailable = false;
  void changeStatus() async {
    String? token = await CacheHelper.getString(key: 'token');
    isAvailable = !isAvailable;
    FormData formData = FormData.fromMap({
      'available': isAvailable,
    });
    final response = DioHelper.patch(
        url: toggleAvailabilityURL, token: 'JWT $token', formData: formData);
    print(response);
    emit(ChangeStatusState());
  }
}
