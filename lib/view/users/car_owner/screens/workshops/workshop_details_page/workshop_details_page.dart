import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/users/car_owner/screens/workshops/workshop_details_page/workshop_details_image_builder.dart';
import 'package:auto_care/view/users/car_owner/screens/workshops/workshop_details_page/workshop_details_info_builder.dart';
import 'package:get/get.dart';

class WorkshopDetailsPage extends StatelessWidget {
  const WorkshopDetailsPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Map? arguments = Get.arguments;
    dynamic workshop;
    dynamic cubit;
    if (arguments != null) {
      workshop = arguments['workshopDetails'];
      cubit = arguments['cubit'];
    }
    return Scaffold(
      body: WorkshopDetailsPageBody(workshop: workshop, cubit: cubit),
    );
  }
}

class WorkshopDetailsPageBody extends StatelessWidget {
  const WorkshopDetailsPageBody({
    super.key,
    required this.workshop,
    required this.cubit,
  });
  final dynamic workshop;
  final dynamic cubit;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 240.0,
          floating: false,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(workshop['workshopName']),
                const Icon(Icons.favorite_border_outlined)
              ]),
          flexibleSpace: FlexibleSpaceBar(
            background: WorkshopImageBuilder(workshop: workshop),
          ),
        ),
        SliverToBoxAdapter(
          child: WorkshopInfoBuilder(workshop: workshop, cubit: cubit),
        )
      ],
    );
  }
}
