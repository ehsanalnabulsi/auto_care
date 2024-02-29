import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/view/users/workshop_owner/cubits/workshop_owner_requests_cubit/workshop_owner_requests_cubit.dart';
import 'package:auto_care/view/widgets/primary_button.dart';
import 'package:auto_care/view/widgets/secondary_button.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';

class WorkshopOwnerRequestDetailsPage extends StatelessWidget {
  const WorkshopOwnerRequestDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController startTimeController = TextEditingController();
    TextEditingController endTimeController = TextEditingController();
    TextEditingController costController = TextEditingController();
    Map? arguments = Get.arguments;
    dynamic requestDetails;
    if (arguments != null) {
      requestDetails = arguments['requestDetails'];
    }
    return BlocProvider(
      create: (context) => WorkshopOwnerRequestsCubit(),
      child:
          BlocConsumer<WorkshopOwnerRequestsCubit, WorkshopOwnerRequestsState>(
        listener: (context, state) async {
          if (state is CancelMaintenanceRequestSuccessState) {
            if (state.response.statusCode == 200) {
              final snackBar = SnackBar(
                duration: const Duration(seconds: 3),
                elevation: 1,
                behavior: SnackBarBehavior.fixed,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: '${state.response.data['status']}',
                  message: '${state.response.data['message']}',
                  contentType: ContentType.success,
                ),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
              Get.toNamed(WorkshopOwnerRoutes.workshopOwnerMainPage,
                  arguments: 1);
            }
          } else if (state is CancelMaintenanceRequestErrorState) {
            final snackBar = SnackBar(
              duration: const Duration(seconds: 3),
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Something went wrong',
                message: '${state.error!.data['detail']}',
                contentType: ContentType.failure,
              ),
            );
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          } else if (state is AcceptMaintenanceAppointmentSuccessState) {
            if (state.response.statusCode == 200) {
              final snackBar = SnackBar(
                duration: const Duration(seconds: 3),
                elevation: 1,
                behavior: SnackBarBehavior.fixed,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: '${state.response.data['status']}',
                  message: '${state.response.data['message']}',
                  contentType: ContentType.success,
                ),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
              Get.toNamed(WorkshopOwnerRoutes.workshopOwnerMainPage,
                  arguments: 1);
            }
          } else if (state is SetVisitAppointmentSuccessState) {
            if (state.response.statusCode == 200) {
              final snackBar = SnackBar(
                duration: const Duration(seconds: 3),
                elevation: 1,
                behavior: SnackBarBehavior.fixed,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: '${state.response.data['status']}',
                  message: '${state.response.data['message']}',
                  contentType: ContentType.success,
                ),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
              Get.toNamed(WorkshopOwnerRoutes.workshopOwnerMainPage,
                  arguments: 1);
            }
          }
        },
        builder: (context, state) {
          var theme = Theme.of(context).textTheme;
          var cubit = WorkshopOwnerRequestsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Request Details'),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                              // margin: const EdgeInsets.all(12.0),
                              width: 300,
                              height: 50,
                              decoration: workshopOwnerContainerDecoration(),
                              child: Center(
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                    Text('Car Model: ',
                                        style: theme.titleMedium),
                                    Text(
                                        '${requestDetails['car']['brandName']} - ${requestDetails['car']['modelName']}',
                                        style: theme.titleLarge!.copyWith(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold))
                                  ])))),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                              // margin: const EdgeInsets.all(12.0),
                              width: 300,
                              height: 50,
                              decoration: carOwnerContainerDecoration(),
                              child: Center(
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                    Text('Workshop Name: ',
                                        style: theme.titleMedium),
                                    Text(requestDetails['workshopName'],
                                        style: theme.titleLarge!.copyWith(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold))
                                  ])))),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                              width: 300,
                              decoration: workshopOwnerContainerDecoration(),
                              child: Center(
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                    Text(
                                        'Request Description: \n${requestDetails['description'] ?? 'null'}',
                                        style: theme.titleMedium),
                                  ])))),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                              // margin: const EdgeInsets.all(12.0),
                              width: 300,
                              height: 50,
                              decoration: carOwnerContainerDecoration(),
                              child: Center(
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                    Text('Request Status: ',
                                        style: theme.titleMedium),
                                    Text(requestDetails['statusName'],
                                        style: theme.titleLarge!.copyWith(
                                            color: AppColors.secondaryColor,
                                            fontWeight: FontWeight.bold))
                                  ])))),
                    ),
                    if (requestDetails['date'] != null)
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                              // margin: const EdgeInsets.all(12.0),
                              width: 320,
                              height: 50,
                              decoration: carOwnerContainerDecoration(),
                              child: Center(
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                    Text(
                                      'First Visit Date: ',
                                      style: theme.titleMedium,
                                    ),
                                    Text(requestDetails['date'] ?? 'not set',
                                        style: theme.titleMedium)
                                  ]))),
                        ),
                      ),
                    if (requestDetails['startTime'] != null)
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                                // margin: const EdgeInsets.all(12.0),
                                width: 350,
                                height: 50,
                                decoration: carOwnerContainerDecoration(),
                                child: Center(
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                      Text(
                                        'Starting Time: ',
                                        style: theme.titleMedium,
                                      ),
                                      Text(requestDetails['startTime'],
                                          style: theme.titleMedium),
                                    ])))),
                      ),
                    if (requestDetails['endTime'] != null)
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                                // margin: const EdgeInsets.all(12.0),
                                width: 350,
                                height: 50,
                                decoration: carOwnerContainerDecoration(),
                                child: Center(
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                      Text(
                                        'Ending Time: ',
                                        style: theme.titleMedium,
                                      ),
                                      Text(requestDetails['endTime'],
                                          style: theme.titleMedium),
                                    ])))),
                      ),
                    if (requestDetails['cost'] != null)
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                                // margin: const EdgeInsets.all(12.0),
                                width: 200,
                                height: 50,
                                decoration: carOwnerContainerDecoration(),
                                child: Center(
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                      Text(
                                        'Cost: ',
                                        style: theme.titleMedium,
                                      ),
                                      Text(requestDetails['cost'].toString(),
                                          style: theme.titleMedium),
                                    ])))),
                      ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                                // margin: const EdgeInsets.all(12.0),
                                width: 240,
                                height: 50,
                                decoration: carOwnerContainerDecoration(),
                                child: Center(
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                      Text('Stage: ', style: theme.titleMedium),
                                      Text(
                                          requestDetails[
                                              'transactionStatusName'],
                                          style: theme.titleMedium!.copyWith(
                                            color: AppColors.blackColor,
                                          ))
                                    ])))))
                  ]),
                  if (requestDetails['transactionStatusName'] == 'INITIATED')
                    SetAppointmentRequestButtonsBuilder(
                        cubit: cubit, requestDetails: requestDetails),
                  if (requestDetails['transactionStatusName'] ==
                      'SET_APPOINTMENT')
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          'Waiting For Accept Appointment',
                          style: Theme.of(context).textTheme.titleLarge,
                        ))),
                  if (requestDetails['transactionStatusName'] == 'PENDING')
                    Form(
                      child: Column(
                        children: [
                          CustomTextFormField(
                            textInputType: TextInputType.none,
                            controller: startTimeController,
                            hintText: 'Start Time',
                            onTap: () {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(), onConfirm: (date) {
                                print(date);
                                startTimeController.text = date.toString();
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                            },
                          ),
                          CustomTextFormField(
                            textInputType: TextInputType.number,
                            controller: endTimeController,
                            hintText: 'End Time',
                            onTap: () {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(), onConfirm: (date) {
                                print(date);
                                endTimeController.text = date.toString();
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                            },
                          ),
                          CustomTextFormField(
                            textInputType: TextInputType.number,
                            controller: costController,
                            hintText: 'Cost',
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: CancelRequestButton(
                                      cubit: cubit,
                                      requestDetails: requestDetails)),
                              Expanded(
                                  child: PrimaryButton(
                                onPressed: () {
                                  cubit.evaluateMaintenanceRequest(
                                      requestDetails['id'],
                                      startTimeController.text,
                                      endTimeController.text,
                                      costController.text);
                                },
                                textButton: 'Evaluate',
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (requestDetails['transactionStatusName'] == 'IN_PROGRESS')
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: PrimaryButton(
                          onPressed: () {
                            cubit
                                .finishMaintenanceRequest(requestDetails['id']);
                          },
                          textButton: 'Finish Car Maintenance',
                        ))),
                  if (requestDetails['transactionStatusName'] == 'FINISHED')
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: Text('The Request is Finished Or Canceled')),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  BoxDecoration workshopOwnerContainerDecoration() {
    return const BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(0),
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      color: Color.fromARGB(255, 255, 240, 230),
    );
  }

  BoxDecoration carOwnerContainerDecoration() {
    return const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Color.fromARGB(255, 214, 248, 255));
  }
}

// class PendingStageButtonsBuilder extends StatelessWidget {
//   const PendingStageButtonsBuilder({
//     super.key,
//     required this.cubit,
//     required this.requestDetails,
//   });

//   final WorkshopOwnerRequestsCubit cubit;
//   final dynamic requestDetails;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           child: Column(
//             children: [
//               CustomTextFormField(textInputType: TextInputType.number, controller: controller)
//               Row(
//                 children: [
//                   Expanded(
//                       child: CancelRequestButton(
//                           cubit: cubit, requestDetails: requestDetails)),
//                   Expanded(
//                       child: AcceptMaintenanceEvaluateButton(
//                           cubit: cubit, requestDetails: requestDetails)),
//                 ],
//               ),
//             ],
//           ),
//         ));
//   }
// }

class AcceptMaintenanceEvaluateButton extends StatelessWidget {
  const AcceptMaintenanceEvaluateButton({
    super.key,
    required this.cubit,
    required this.requestDetails,
  });

  final WorkshopOwnerRequestsCubit cubit;
  final dynamic requestDetails;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
        onPressed: () {
          cubit.acceptMaintenanceEvaluate(requestDetails['id']);
        },
        textButton: 'Accept');
  }
}

class SetAppointmentRequestButtonsBuilder extends StatelessWidget {
  const SetAppointmentRequestButtonsBuilder({
    super.key,
    required this.cubit,
    required this.requestDetails,
  });

  final WorkshopOwnerRequestsCubit cubit;
  final dynamic requestDetails;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: CancelRequestButton(
                  cubit: cubit, requestDetails: requestDetails)),
        ),
        Expanded(
          flex: 2,
          child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: PrimaryButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(), onConfirm: (date) {
                    print(date);
                    cubit.setVisitAppointment(requestDetails['id'], date);
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                textButton: 'Set Appointment',
              )),
        ),
      ],
    );
  }
}

class CancelRequestButton extends StatelessWidget {
  const CancelRequestButton({
    super.key,
    required this.cubit,
    required this.requestDetails,
  });

  final WorkshopOwnerRequestsCubit cubit;
  final dynamic requestDetails;

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
        onPressed: () {
          cubit.cancelMaintenanceRequest(requestDetails['id']);
        },
        child: const Text('Reject'));
  }
}

class InProgressStageButtonsBuilder extends StatelessWidget {
  const InProgressStageButtonsBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: SecondaryButton(
                  onPressed: () {}, child: const Text('Decline'))),
          Expanded(
              child: PrimaryButton(onPressed: () {}, textButton: 'Accept')),
          Expanded(
              child: PrimaryButton(
                  onPressed: () {}, textButton: 'Reset Appointment'))
        ],
      ),
    );
  }
}

class InitiatedAndPendingStageButtonsBuilder extends StatelessWidget {
  const InitiatedAndPendingStageButtonsBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SecondaryButton(
            onPressed: () {}, child: const Text('Cancel Request')));
  }
}
