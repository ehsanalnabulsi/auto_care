import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/view/users/car_owner/cubits/car_owner_settings_cubit/car_owner_settings_cubit.dart';
import 'package:auto_care/view/users/car_owner/screens/Settings/account_details_tile.dart';
import 'package:auto_care/view/users/car_owner/screens/Settings/app_settings_tile.dart';
import 'package:auto_care/view/users/car_owner/screens/Settings/help_center_tile.dart';
import 'package:auto_care/view/users/car_owner/screens/Settings/logout_button.dart';
import 'package:auto_care/view/users/car_owner/screens/Settings/share_app_tile.dart';
import 'package:get/get.dart';

class CarOwnerSettings extends StatelessWidget {
  const CarOwnerSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => CarOwnerSettingsCubit()..getUserInfo(),
      child: BlocConsumer<CarOwnerSettingsCubit, CarOwnerSettingsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CarOwnerSettingsCubit.get(context);
          return SafeArea(
              child: Scaffold(
            appBar: AppBar(
              title: const Text('Profile & Settings'),
            ),
            body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                    color: AppColors.greyColor,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.whiteColor,
                            ),
                            child: ListTile(
                              iconColor: AppColors.primaryColor,
                              title: Text('My Profile',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold)),
                              onTap: () => Get.toNamed(
                                  CarOwnerRoutes.editProfile,
                                  arguments: cubit.userInfo),
                              trailing:
                                  const Icon(Icons.arrow_right, size: 28.0),
                              leading:
                                  const Icon(Icons.person_outlined, size: 28.0),
                              textColor: AppColors.primaryColor,
                            ),
                          ),
                          const LogoutButton(),
                          AccountDetailsTile(theme: theme),
                          AppSettingsTile(theme: theme),
                          const ShareAppTile(),
                          HelpCenterTile(theme: theme),
                        ]))),
          ));
        },
      ),
    );
  }
}
