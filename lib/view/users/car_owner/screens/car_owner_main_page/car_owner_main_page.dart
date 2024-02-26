import 'package:auto_care/core/constant/imports.dart';

import 'package:auto_care/data/static.dart';
import 'package:auto_care/view/users/car_owner/cubits/main_page_cubit/main_page_cubit.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';

class CarOwnerMainPage extends StatelessWidget {
  const CarOwnerMainPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CarOwnerMainPageCubit(),
      child: BlocConsumer<CarOwnerMainPageCubit, CarOwnerMainPageState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = CarOwnerMainPageCubit.get(context);
            return Scaffold(
                bottomNavigationBar: MyTabBar(cubit: cubit),
                body: tabsCarOwner.values.elementAt(cubit.currentIndex));
          }),
    );
  }
}

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    super.key,
    required this.cubit,
  });

  final CarOwnerMainPageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return FlashyTabBar(
      backgroundColor: AppColors.whiteColor,
      height: 55,
      animationCurve: Curves.linear,
      selectedIndex: cubit.currentIndex,
      items: [
        FlashyTabBarItem(
          activeColor: AppColors.primaryColor,
          inactiveColor: AppColors.greyColor,
          icon: const Icon(Icons.home_rounded),
          title: const Text('Home'),
        ),
        FlashyTabBarItem(
          activeColor: AppColors.primaryColor,
          inactiveColor: AppColors.greyColor,
          icon: const Icon(Icons.car_repair_rounded),
          title: const Text('My Cars'),
        ),
        FlashyTabBarItem(
          activeColor: AppColors.primaryColor,
          inactiveColor: AppColors.greyColor,
          icon: const Icon(Icons.history_outlined),
          title: const Text('Requests'),
        ),
        FlashyTabBarItem(
          activeColor: AppColors.primaryColor,
          inactiveColor: AppColors.greyColor,
          icon: const Icon(Icons.settings),
          title: const Text('Settings'),
        ),
      ],
      onItemSelected: (int value) {
        cubit.changeIndex(value);
      },
    );
  }
}
