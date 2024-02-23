import 'package:auto_care/app/cubit/states.dart';
import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/core/services/dio_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode() {
    isDark = !isDark;
    // CatchHelper.setData(key: 'isDark', value: isDark)
    //     .then((value) => emit(AppChangeModeState()));
  }

  Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  void sendMobileToken() async {
    emit(SendMobileTokenLoadingState());
    String? mobileToken = await getToken();
    String? token = CacheHelper.getString(key: 'token');
    final response = await DioHelper.post(sendMobileTokenURL,
        token: 'JWT $token', data: {'mobileToken': mobileToken});
    print(response);
    if (response.statusCode == 200) {
      emit(SendMobileTokenSuccessState());
    } else {
      emit(SendMobileTokenErrorState());
    }
  }
}
