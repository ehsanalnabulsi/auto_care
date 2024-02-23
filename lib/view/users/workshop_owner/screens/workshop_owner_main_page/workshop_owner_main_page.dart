import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/data/static.dart';
import 'package:auto_care/view/users/workshop_owner/cubits/workshop_owner_main_page_cubit/main_page_cubit.dart';
import 'package:auto_care/view/users/workshop_owner/screens/workshop_owner_main_page/workshop_owner_main_page_tab_bar.dart';



class WorkshopOwnerMainPage extends StatelessWidget {
  const WorkshopOwnerMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => WorkshopOwnerMainPageCubit(),
      child:
          BlocConsumer<WorkshopOwnerMainPageCubit, WorkshopOwnerMainPageState>(
              listener: (context, state) {},
              builder: (context, state) {
                var cubit = WorkshopOwnerMainPageCubit.get(context);
                return Scaffold(
                    bottomNavigationBar: WorkshopOwnerMainPageTabBar(cubit: cubit),
                    body:
                        tabsWorkshopOwner.values.elementAt(cubit.currentIndex));
              }),
    );
  }
}



