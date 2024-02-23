import 'package:auto_care/core/constant/imports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'workshop_owner_home_page_state.dart';

class WorkshopOwnerHomePageCubit extends Cubit<WorkshopOwnerHomePageState> {
  WorkshopOwnerHomePageCubit() : super(WorkshopOwnerHomePageInitialState());

  static WorkshopOwnerHomePageCubit get(context) => BlocProvider.of(context);
  void getWorkshopInfo() async {
    // final response = await DioHelper.get(url);
  }

  
}
