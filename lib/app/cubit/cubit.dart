import 'package:auto_care/app/cubit/states.dart';

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
}
