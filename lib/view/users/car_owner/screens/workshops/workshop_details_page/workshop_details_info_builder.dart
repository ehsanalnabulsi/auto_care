import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/view/users/car_owner/screens/workshops/workshop_details_page/workshop_details_map_builder.dart';
import 'package:auto_care/view/widgets/primary_button.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class WorkshopInfoBuilder extends StatelessWidget {
  const WorkshopInfoBuilder({
    super.key,
    required this.workshop,
    required this.cubit,
  });
  final dynamic workshop;
  final dynamic cubit;

  @override
  Widget build(BuildContext context) {
    LatLng fakeLocation = const LatLng(35, 23);

    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Specialist: ${workshop['specialistName']}',
              style: theme.headlineSmall!.copyWith(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
          Text('Contact Number: ${workshop['contactNumber']}',
              style: theme.titleMedium),
          Text('Repair Origin: ${workshop['originName']}',
              style: theme.titleMedium),
          Text('Brands Can Repair: ${workshop['WorkShopBrands'].join(', ')}',
              style: theme.titleMedium),
          const SizedBox(height: 8.0),
          const Divider(),
          Text('Address :\n${workshop['address']}', style: theme.titleLarge),
          ConditionalBuilder(
            condition: workshop['location'] == null,
            builder: (context) => const Center(
              child: Text('No Address Provided'),
            ),
            fallback: (context) => MapBuilder(currentLocation: fakeLocation),
          ),
          CreateRequestButtonBuilder(cubit: cubit, workshop: workshop)
        ],
      ),
    );
  }
}

class CreateRequestButtonBuilder extends StatelessWidget {
  const CreateRequestButtonBuilder({
    super.key,
    required this.cubit,
    required this.workshop,
  });

  final dynamic cubit;
  final dynamic workshop;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
        onPressed: () {
          Get.toNamed(CarOwnerRoutes.createMaintenanceRequest);
        },
        textButton: 'Go To Create Request');
  }
}
