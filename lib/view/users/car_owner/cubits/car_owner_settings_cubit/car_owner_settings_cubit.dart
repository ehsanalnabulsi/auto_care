import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/core/services/dio_helper.dart';

part 'car_owner_settings_state.dart';

class CarOwnerSettingsCubit extends Cubit<CarOwnerSettingsState> {
  CarOwnerSettingsCubit() : super(CarOwnerSettingsInitial());
  static CarOwnerSettingsCubit get(context) => BlocProvider.of(context);
  Map<String, dynamic>? userInfo;
  void getUserInfo() async {
    String? token = CacheHelper.getString(key: 'token');
    print(token);
    final response = await DioHelper.get(getUserInfoURL, token: 'JWT $token');

    userInfo = response.data;
    print(userInfo);
  }
}
