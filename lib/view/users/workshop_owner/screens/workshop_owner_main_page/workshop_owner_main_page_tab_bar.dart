import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/users/workshop_owner/cubits/workshop_owner_main_page_cubit/main_page_cubit.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';

class WorkshopOwnerMainPageTabBar extends StatelessWidget {
  const WorkshopOwnerMainPageTabBar({
    super.key,
    required this.cubit,
  });

  final WorkshopOwnerMainPageCubit cubit;

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
          icon: const Icon(Icons.request_page),
          title: const Text('Requests'),
        ),
        FlashyTabBarItem(
          activeColor: AppColors.primaryColor,
          inactiveColor: AppColors.greyColor,
          icon: const Icon(Icons.car_crash_sharp),
          title: const Text('Cars'),
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
