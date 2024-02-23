import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/data/static.dart';
import 'package:auto_care/view/users/car_owner/cubits/requests_page_cubit/requests_page_cubit.dart';
import 'package:auto_care/view/widgets/app_progress_indicator.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:get/get.dart';

class CarOwnerRequestsPage extends StatelessWidget {
  const CarOwnerRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => RequestsPageCubit()..getUserRequests(),
      child: BlocConsumer<RequestsPageCubit, RequestsPageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Get.toNamed(CarOwnerRoutes.createMaintenanceRequest);
                },
                child: Icon(Icons.request_page),
              ),
              appBar: AppBar(
                title: const Text('Requests '),
              ),
              body: ConditionalBuilder(
                condition: state is GetUserRequestsLoadingState,
                builder: (context) => const AppProgressIndicator(),
                fallback: (context) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12),
                      child: Text(
                        'Requests',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 200,
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
                                    height: 200,
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
                          separatorBuilder: (context, index) =>
                              const SizedBox(),
                          itemCount: dummyRequests.length),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12),
                      child: Text(
                        'History',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
