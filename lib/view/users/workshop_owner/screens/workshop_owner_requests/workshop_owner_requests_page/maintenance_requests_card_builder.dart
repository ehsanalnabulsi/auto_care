import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/view/users/workshop_owner/cubits/workshop_owner_requests_cubit/workshop_owner_requests_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaintenanceRequestsCardBuilder extends StatelessWidget {
  const MaintenanceRequestsCardBuilder({
    super.key,
    required this.cubit,
    required this.theme,
  });

  final WorkshopOwnerRequestsCubit cubit;
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
                Get.toNamed(WorkshopOwnerRoutes.workshopOwnerRequestDetailsPage,
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

class HistoryRequestsCardBuilder extends StatelessWidget {
  const HistoryRequestsCardBuilder({
    super.key,
    required this.cubit,
    required this.theme,
  });

  final WorkshopOwnerRequestsCubit cubit;
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
                Get.toNamed(WorkshopOwnerRoutes.workshopOwnerRequestDetailsPage,
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
