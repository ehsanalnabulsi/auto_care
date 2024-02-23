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
  void changeStatus() {
    isAvailable = !isAvailable;
    emit(ChangeStatusState());
  }
}
