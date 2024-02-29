import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/view/users/car_owner/cubits/car_owner_requests_cubit/car_owner_requests_cubit.dart';
import 'package:auto_care/view/widgets/app_progress_indicator.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:get/get.dart';

class CarOwnerRequestsPage extends StatelessWidget {
  const CarOwnerRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarOwnerRequestsCubit()
        ..getUserRequests()
        ..getUserRequestsHistory(),
      child: BlocConsumer<CarOwnerRequestsCubit, CarOwnerRequestsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CarOwnerRequestsCubit.get(context);
          var theme = Theme.of(context).textTheme;
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Get.toNamed(CarOwnerRoutes.createMaintenanceRequest);
                },
                child: const Icon(Icons.request_page),
              ),
              appBar: AppBar(
                title: const Text('Requests'),
              ),
              body: ConditionalBuilder(
                condition: state is GetUserRequestsLoadingState,
                builder: (context) => const AppProgressIndicator(),
                fallback: (context) => SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RequestsTextTitle(title: 'Maintenance Requests'),
                      if (cubit.userRequests.isEmpty)
                        const Center(child: Text('There Is No Requests Yet')),
                      MaintenanceRequestsCardBuilder(
                          cubit: cubit, theme: theme),
                      const RequestsTextTitle(title: 'History Requests'),
                      if (cubit.userHistoryRequests.isEmpty)
                        const Center(
                            child: Text('There Is No Finish Requests Yet')),
                      HistoryRequestsCardBuilder(cubit: cubit, theme: theme),
                      const RequestsTextTitle(title: 'Tow Car Requests'),
                      if (cubit.userTowCarRequests.isEmpty)
                        const Center(
                            child: Text('There Is No Tow Car Requests Yet')),
                      TowCarRequestsCardBuilder(cubit: cubit, theme: theme)
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}

class HistoryRequestsCardBuilder extends StatelessWidget {
  const HistoryRequestsCardBuilder({
    super.key,
    required this.cubit,
    required this.theme,
  });

  final CarOwnerRequestsCubit cubit;
  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 160,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: cubit.userHistoryRequests.length,
        itemBuilder: (context, index) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Get.toNamed(CarOwnerRoutes.carOwnerRequestDetailsPage,
                    arguments: {
                      'requestDetails': cubit.userHistoryRequests[index]
                    });
              },
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      child: Container(
                        width: 12,
                        color: AppColors.listTileColor1,
                      )),
                  SizedBox(
                    width: 300,
                    height: 160,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 35, top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Car Model: ${cubit.userHistoryRequests[index]['car']['modelName']} - ${cubit.userHistoryRequests[index]['car']['originName']} ',
                                style: theme.titleMedium,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                              Text(
                                'Workshop: ${cubit.userHistoryRequests[index]['workshopName']} ',
                                style: theme.titleMedium,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                              Text(
                                'Appointment Date: ${cubit.userHistoryRequests[index]['date']}',
                                style: theme.titleMedium,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                              Text(
                                'Transaction Status: ${cubit.userHistoryRequests[index]['transactionStatusName']}',
                                style: theme.titleMedium,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
        separatorBuilder: (context, index) => const SizedBox(),
      ),
    );
  }
}

class MaintenanceRequestsCardBuilder extends StatelessWidget {
  const MaintenanceRequestsCardBuilder({
    super.key,
    required this.cubit,
    required this.theme,
  });

  final CarOwnerRequestsCubit cubit;
  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 160,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: cubit.userRequests.length,
        itemBuilder: (context, index) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Get.toNamed(CarOwnerRoutes.carOwnerRequestDetailsPage,
                    arguments: {'requestDetails': cubit.userRequests[index]});
              },
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      child: Container(
                        width: 12,
                        color: AppColors.listTileColor1,
                      )),
                  SizedBox(
                    width: 300,
                    height: 160,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 35, top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Car Model: ${cubit.userRequests[index]['car']['modelName']} - ${cubit.userRequests[index]['car']['originName']} ',
                                style: theme.titleMedium,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                              Text(
                                'Workshop: ${cubit.userRequests[index]['workshopName']} ',
                                style: theme.titleMedium,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                              Text(
                                'Appointment Date: ${cubit.userRequests[index]['date']}',
                                style: theme.titleMedium,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                              Text(
                                'Transaction Status: ${cubit.userRequests[index]['transactionStatusName']}',
                                style: theme.titleMedium,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
        separatorBuilder: (context, index) => const SizedBox(),
      ),
    );
  }
}

class TowCarRequestsCardBuilder extends StatelessWidget {
  const TowCarRequestsCardBuilder({
    super.key,
    required this.cubit,
    required this.theme,
  });

  final CarOwnerRequestsCubit cubit;
  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 160,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: cubit.userTowCarRequests.length,
        itemBuilder: (context, index) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Get.toNamed(CarOwnerRoutes.carOwnerRequestDetailsPage,
                    arguments: {
                      'requestDetails': cubit.userTowCarRequests[index]
                    });
              },
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      child: Container(
                        width: 12,
                        color: AppColors.listTileColor1,
                      )),
                  SizedBox(
                    width: 300,
                    height: 160,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 35, top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Car Model: ${cubit.userTowCarRequests[index]['car']['modelName']} - ${cubit.userTowCarRequests[index]['car']['originName']} ',
                                style: theme.titleMedium,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                              Text(
                                'Workshop: ${cubit.userTowCarRequests[index]['workshopName']} ',
                                style: theme.titleMedium,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                              Text(
                                'Appointment Date: ${cubit.userTowCarRequests[index]['date']}',
                                style: theme.titleMedium,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                              Text(
                                'Transaction Status: ${cubit.userTowCarRequests[index]['transactionStatusName']}',
                                style: theme.titleMedium,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
        separatorBuilder: (context, index) => const SizedBox(),
      ),
    );
  }
}

class RequestsTextTitle extends StatelessWidget {
  const RequestsTextTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
