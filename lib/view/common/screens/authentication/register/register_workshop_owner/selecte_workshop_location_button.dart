import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/core/services/location.dart';
import 'package:get/get.dart';

class SelectWorkshopLocationButton extends StatelessWidget {
  const SelectWorkshopLocationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          textStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      onPressed: () async {
        await LocationService.getCurrentLocation().then(
          (value) => Get.toNamed(SharedRoutes.addWorkshopLocation, arguments: value),
        );
      },
      child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Press To Pin Your Workshop Location'),
        Icon(
          Icons.pin_drop,
          size: 24,
        )
      ]),
    );
  }
}
