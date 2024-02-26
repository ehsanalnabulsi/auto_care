

import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/users/car_owner/cubits/car_owner_settings_cubit/car_owner_settings_cubit.dart';
import 'package:auto_care/view/users/car_owner/screens/Settings/account_details_tile.dart';
import 'package:auto_care/view/users/car_owner/screens/Settings/app_settings_tile.dart';
import 'package:auto_care/view/users/car_owner/screens/Settings/help_center_tile.dart';
import 'package:auto_care/view/users/car_owner/screens/Settings/logout_button.dart';
import 'package:auto_care/view/users/car_owner/screens/Settings/my_profile_tile.dart';
import 'package:auto_care/view/users/car_owner/screens/Settings/share_app_tile.dart';



class CarOwnerSettings extends StatelessWidget {
  const CarOwnerSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => CarOwnerSettingsCubit(),
      child: BlocConsumer<CarOwnerSettingsCubit, CarOwnerSettingsState>(
        listener: (context, state) {},
        builder: (context, state) {
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
                          const MyProfileTile(),
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
