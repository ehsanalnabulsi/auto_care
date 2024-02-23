
import 'package:auto_care/core/constant/imports.dart';

class TowCarOwnerSettings extends StatelessWidget {
  const TowCarOwnerSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return SafeArea(
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
              color: AppColors.greyColor,
              child: Column(children: [
                Container(
                  height: 80.0,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(color: AppColors.whiteColor),
                  child: Center(
                    child: Text(
                      'Ehsan AL-Nabulsi',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.whiteColor,
                  ),
                  child: ListTile(
                    iconColor: AppColors.primaryColor,
                    title: Text('Edit My Profile',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold)),
                    onTap: () {
                      // Get.toNamed(TowCarRoutes.editProfile)
                    },
                    trailing: const Icon(Icons.arrow_right, size: 28.0),
                    leading: const Icon(Icons.person_outlined, size: 28.0),
                    textColor: AppColors.primaryColor,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.whiteColor,
                  ),
                  margin: const EdgeInsets.all(6.0),
                  child: ExpansionTile(
                    backgroundColor: AppColors.whiteColor,
                    collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide.none),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    initiallyExpanded: true,
                    iconColor: AppColors.primaryColor,
                    leading:
                        const Icon(Icons.account_circle_outlined, size: 28.0),
                    title: Text('Account Details',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold)),
                    children: [
                      ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: 24.0, right: 24.0),
                          iconColor: Colors.black54,
                          onTap: () {},
                          title: Text('My Cars', style: theme.bodyLarge),
                          trailing: const Icon(Icons.arrow_right)),
                      ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: 24.0, right: 24.0),
                          iconColor: Colors.black54,
                          onTap: () {},
                          title: Text('Requests', style: theme.bodyLarge),
                          trailing: const Icon(Icons.arrow_right)),
                      ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: 24.0, right: 24.0),
                          iconColor: Colors.black54,
                          onTap: () {},
                          title: Text('My Address', style: theme.bodyLarge),
                          trailing: const Icon(Icons.arrow_right)),
                      ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: 24.0, right: 24.0),
                          iconColor: Colors.black54,
                          onTap: () {},
                          title: Text('Favorites', style: theme.bodyLarge),
                          trailing: const Icon(Icons.arrow_right)),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.whiteColor,
                  ),
                  margin: const EdgeInsets.all(6.0),
                  child: ExpansionTile(
                    backgroundColor: AppColors.whiteColor,
                    collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide.none),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    initiallyExpanded: true,
                    iconColor: AppColors.primaryColor,
                    leading: const Icon(Icons.settings, size: 28.0),
                    title: Text('App Settings',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold)),
                    children: [
                      ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: 24.0, right: 24.0),
                          iconColor: Colors.black54,
                          onTap: () {},
                          title: Text('App Theme', style: theme.bodyLarge),
                          trailing: const Icon(Icons.arrow_right)),
                      ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: 24.0, right: 24.0),
                          iconColor: Colors.black54,
                          onTap: () {},
                          title: Text('Language', style: theme.bodyLarge),
                          trailing: const Icon(Icons.arrow_right)),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.whiteColor,
                  ),
                  child: ListTile(
                    iconColor: AppColors.primaryColor,
                    title: Text('Share App',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold)),
                    onTap: () {},
                    trailing: const Icon(Icons.arrow_right, size: 28.0),
                    leading: const Icon(Icons.share, size: 28.0),
                    textColor: AppColors.primaryColor,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.whiteColor,
                  ),
                  margin: const EdgeInsets.all(6.0),
                  child: ExpansionTile(
                    backgroundColor: AppColors.whiteColor,
                    collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide.none),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    initiallyExpanded: true,
                    iconColor: AppColors.primaryColor,
                    leading: const Icon(Icons.live_help_rounded, size: 28.0),
                    title: Text('Help Center',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold)),
                    children: [
                      ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: 24.0, right: 24.0),
                          iconColor: Colors.black54,
                          onTap: () {},
                          title: Text('Privacy Policy', style: theme.bodyLarge),
                          trailing: const Icon(Icons.arrow_right)),
                      ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: 24.0, right: 24.0),
                          iconColor: Colors.black54,
                          onTap: () {},
                          title:
                              Text('Terms Of Service', style: theme.bodyLarge),
                          trailing: const Icon(Icons.arrow_right)),
                      ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: 24.0, right: 24.0),
                          iconColor: Colors.black54,
                          onTap: () {},
                          title: Text('FAQ', style: theme.bodyLarge),
                          trailing: const Icon(Icons.arrow_right)),
                      ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: 24.0, right: 24.0),
                          iconColor: Colors.black54,
                          onTap: () {},
                          title: Text('About Us', style: theme.bodyLarge),
                          trailing: const Icon(Icons.arrow_right)),
                      ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: 24.0, right: 24.0),
                          iconColor: Colors.black54,
                          onTap: () {},
                          title: Text('Contact Us', style: theme.bodyLarge),
                          trailing: const Icon(Icons.arrow_right)),
                      ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: 24.0, right: 24.0),
                          iconColor: Colors.black54,
                          onTap: () {},
                          title: Text('Join Us', style: theme.bodyLarge),
                          trailing: const Icon(Icons.arrow_right)),
                    ],
                  ),
                ),
              ]))),
    );
  }
}
