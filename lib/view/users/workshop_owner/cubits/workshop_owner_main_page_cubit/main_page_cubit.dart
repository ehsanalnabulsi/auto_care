import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_page_state.dart';

class WorkshopOwnerMainPageCubit extends Cubit<WorkshopOwnerMainPageState> {
  WorkshopOwnerMainPageCubit() : super(WorkshopOwnerMainPageInitial());
  static WorkshopOwnerMainPageCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeNavigationBarIndex());
  }
}
