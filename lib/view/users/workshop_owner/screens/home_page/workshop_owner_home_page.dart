import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/data/static.dart';
import 'package:auto_care/view/users/workshop_owner/cubits/workshop_owner_home_page_cubit/workshop_owner_home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkshopOwnerHomePage extends StatelessWidget {
  const WorkshopOwnerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => WorkshopOwnerHomePageCubit(),
      child:
          BlocConsumer<WorkshopOwnerHomePageCubit, WorkshopOwnerHomePageState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Home Page')),
            body: Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   const  Row(
                     children: [],
                   ),
                  DisplayAllRequestsText(theme: theme),
                  SizedBox(
                    height: 160,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: () {
                                  // Handle onTap event
                                },
                                child: SizedBox(
                                  width: 300,
                                  height: 180,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Status : ${dummyRequests[index].status} ',
                                              style: theme.titleLarge,
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                            ),
                                            Text(
                                              'Car  : ${dummyRequests[index].carModel} ',
                                              style: theme.titleLarge,
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                            ),
                                            Text(
                                              'Appointment Date: ${dummyRequests[index].appointmentDate}',
                                              style: theme.titleMedium,
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                        TextButton(
                                            style: ButtonStyle(
                                              overlayColor: MaterialStateColor
                                                  .resolveWith((states) =>
                                                      AppColors.whiteColor
                                                          .withOpacity(0.2)),
                                            ),
                                            onPressed: () {},
                                            child: const Text(
                                              'See More...',
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        separatorBuilder: (context, index) => const SizedBox(),
                        itemCount: dummyRequests.length),
                  ),
                  DisplayAllRequestsText(theme: theme),
                  SizedBox(
                    height: 180,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: () {
                                  // Handle onTap event
                                },
                                child: SizedBox(
                                  width: 300,
                                  height: 180,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Status : ${dummyRequests[index].status} ',
                                              style: theme.titleLarge,
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                            ),
                                            Text(
                                              'Car  : ${dummyRequests[index].carModel} ',
                                              style: theme.titleLarge,
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                            ),
                                            Text(
                                              'Appointment Date: ${dummyRequests[index].appointmentDate}',
                                              style: theme.titleMedium,
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                        TextButton(
                                            style: ButtonStyle(
                                              overlayColor: MaterialStateColor
                                                  .resolveWith((states) =>
                                                      AppColors.whiteColor
                                                          .withOpacity(0.2)),
                                            ),
                                            onPressed: () {},
                                            child: const Text(
                                              'See More...',
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        separatorBuilder: (context, index) => const SizedBox(),
                        itemCount: dummyRequests.length),
                  ),
                  DisplayAllRequestsText(theme: theme),
                  SizedBox(
                    height: 180,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: () {
                                  // Handle onTap event
                                },
                                child: SizedBox(
                                  width: 300,
                                  height: 180,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Status : ${dummyRequests[index].status} ',
                                              style: theme.titleLarge,
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                            ),
                                            Text(
                                              'Car  : ${dummyRequests[index].carModel} ',
                                              style: theme.titleLarge,
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                            ),
                                            Text(
                                              'Appointment Date: ${dummyRequests[index].appointmentDate}',
                                              style: theme.titleMedium,
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                        TextButton(
                                            style: ButtonStyle(
                                              overlayColor: MaterialStateColor
                                                  .resolveWith((states) =>
                                                      AppColors.whiteColor
                                                          .withOpacity(0.2)),
                                            ),
                                            onPressed: () {},
                                            child: const Text(
                                              'See More...',
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        separatorBuilder: (context, index) => const SizedBox(),
                        itemCount: dummyRequests.length),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DisplayAllRequestsText extends StatelessWidget {
  const DisplayAllRequestsText({
    super.key,
    required this.theme,
  });

  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Pending Requests',
              style: theme.titleLarge!.copyWith(color: AppColors.primaryColor),
            ),
          ),
          TextButton(
              onPressed: () {},
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
