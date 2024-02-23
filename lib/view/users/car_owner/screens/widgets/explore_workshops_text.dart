import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:get/get.dart';

class ExploreWorkshopsText extends StatelessWidget {
  const ExploreWorkshopsText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Explore Workshops',
              style: theme.titleLarge!.copyWith(color: AppColors.primaryColor),
            ),
          ),
          TextButton(
              onPressed: () => Get.toNamed(CarOwnerRoutes.workshops),
              child: Text(
                'View All',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: AppColors.primaryColor.withOpacity(0.85)),
              )),
        ],
      ),
    );
  }
}
