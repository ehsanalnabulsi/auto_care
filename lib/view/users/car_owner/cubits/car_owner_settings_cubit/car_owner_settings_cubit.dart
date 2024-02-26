import 'package:auto_care/core/constant/imports.dart';

part 'car_owner_settings_state.dart';

class CarOwnerSettingsCubit extends Cubit<CarOwnerSettingsState> {
  CarOwnerSettingsCubit() : super(CarOwnerSettingsInitial());
  static CarOwnerSettingsCubit get(context) => BlocProvider.of(context);
}
