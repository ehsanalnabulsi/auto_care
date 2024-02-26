import 'package:auto_care/core/constant/imports.dart';

part 'workshop_owner_settings_state.dart';

class WorkshopOwnerSettingsCubit extends Cubit<WorkshopOwnerSettingsState> {
  WorkshopOwnerSettingsCubit() : super(WorkshopOwnerSettingsInitial());
  static WorkshopOwnerSettingsCubit get(context) => BlocProvider.of(context);
}
