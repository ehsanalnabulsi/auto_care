import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/view/users/car_owner/cubits/car_owner_requests_cubit/car_owner_requests_cubit.dart';
import 'package:auto_care/view/widgets/primary_button.dart';
import 'package:auto_care/view/widgets/secondary_button.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';

class CarOwnerRequestDetailsPage extends StatelessWidget {
  const CarOwnerRequestDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map? arguments = Get.arguments;
    dynamic requestDetails;
    if (arguments != null) {
      requestDetails = arguments['requestDetails'];
    }
    return BlocProvider(
      create: (context) => CarOwnerRequestsCubit(),
      child: BlocConsumer<CarOwnerRequestsCubit, CarOwnerRequestsState>(
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
              Get.toNamed(CarOwnerRoutes.carOwnerMainPage, arguments: 2);
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
              Get.toNamed(CarOwnerRoutes.carOwnerMainPage, arguments: 2);
            }
          }
        },
        builder: (context, state) {
          var theme = Theme.of(context).textTheme;
          var cubit = CarOwnerRequestsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Request Details'),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
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
                                    Text('Car Model: ',
                                        style: theme.titleMedium),
                                    Text(
                                        '${requestDetails['car']['brandName']} - ${requestDetails['car']['modelName']}',
                                        style: theme.titleLarge!.copyWith(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold))
                                  ]))))),
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
                                    Text('Workshop Name: ',
                                        style: theme.titleMedium),
                                    Text(requestDetails['workshopName'],
                                        style: theme.titleLarge!.copyWith(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold))
                                  ]))))),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                              width: 300,
                              decoration: carOwnerContainerDecoration(),
                              child: Center(
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                    Text(
                                        'Request Description: \n${requestDetails['notes'] ?? 'null'}',
                                        style: theme.titleMedium),
                                  ]))))),
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
                                    Text('Request Status: ',
                                        style: theme.titleMedium),
                                    Text(requestDetails['statusName'],
                                        style: theme.titleLarge!.copyWith(
                                            color: AppColors.secondaryColor,
                                            fontWeight: FontWeight.bold))
                                  ]))))),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  Text(
                                    'First Visit Date: ',
                                    style: theme.titleMedium,
                                  ),
                                  Text(requestDetails['date'] ?? 'not set',
                                      style: theme.titleLarge)
                                ])))),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                              // margin: const EdgeInsets.all(12.0),
                              width: 350,
                              height: 50,
                              decoration: workshopOwnerContainerDecoration(),
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
                                    Text(requestDetails['date'] ?? '--:--   ',
                                        style: theme.titleLarge),
                                    Text(
                                      '|    Ending Time: ',
                                      style: theme.titleMedium,
                                    ),
                                    Text(requestDetails['date'] ?? '--:--',
                                        style: theme.titleLarge)
                                  ]))))),
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                              // margin: const EdgeInsets.all(12.0),
                              width: 200,
                              height: 50,
                              decoration: workshopOwnerContainerDecoration(),
                              child: Center(
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                    Text('Stage: ', style: theme.titleMedium),
                                    Text(
                                        requestDetails['transactionStatusName'],
                                        style: theme.titleMedium!.copyWith(
                                          color: AppColors.blackColor,
                                        ))
                                  ])))))
                ]),
                if (requestDetails['transactionStatusName'] == 'INITIATED' ||
                    requestDetails['transactionStatusName'] == 'PENDING')
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      'Waiting For Response',
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                  ),
                if (requestDetails['transactionStatusName'] ==
                    'SET_APPOINTMENT')
                  SetAppointmentStageButtonsBuilder(
                      cubit: cubit, requestDetails: requestDetails),
                if (requestDetails['transactionStatusName'] == 'EVALUATE')
                  EvaluateStageButtonsBuilder(
                      cubit: cubit, requestDetails: requestDetails),
                if (requestDetails['transactionStatusName'] == 'IN_PROGRESS' ||
                    requestDetails['transactionStatusName'] == 'PENDING')
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      'Waiting For Appointment',
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                  ),
                if (requestDetails['transactionStatusName'] == 'FINISHED')
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: Text('The Request is Finished Or Canceled')),
                  )
              ],
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

class EvaluateStageButtonsBuilder extends StatelessWidget {
  const EvaluateStageButtonsBuilder({
    super.key,
    required this.cubit,
    required this.requestDetails,
  });

  final CarOwnerRequestsCubit cubit;
  final dynamic requestDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: CancelRequestButton(
                  cubit: cubit, requestDetails: requestDetails)),
          Expanded(
              child: AcceptMaintenanceEvaluateButton(
                  cubit: cubit, requestDetails: requestDetails)),
        ],
      ),
    );
  }
}

class AcceptMaintenanceEvaluateButton extends StatelessWidget {
  const AcceptMaintenanceEvaluateButton({
    super.key,
    required this.cubit,
    required this.requestDetails,
  });

  final CarOwnerRequestsCubit cubit;
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

class SetAppointmentStageButtonsBuilder extends StatelessWidget {
  const SetAppointmentStageButtonsBuilder({
    super.key,
    required this.cubit,
    required this.requestDetails,
  });

  final CarOwnerRequestsCubit cubit;
  final dynamic requestDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: CancelRequestButton(
                  cubit: cubit, requestDetails: requestDetails)),
          Expanded(
              child: AcceptMaintenanceAppointmentButton(
                  cubit: cubit, requestDetails: requestDetails)),
          ResetAppointmentButton(cubit: cubit, requestDetails: requestDetails)
        ],
      ),
    );
  }
}

class AcceptMaintenanceAppointmentButton extends StatelessWidget {
  const AcceptMaintenanceAppointmentButton({
    super.key,
    required this.cubit,
    required this.requestDetails,
  });

  final CarOwnerRequestsCubit cubit;
  final dynamic requestDetails;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
        onPressed: () {
          cubit.acceptMaintenanceAppointment(requestDetails['id']);
        },
        textButton: 'Accept');
  }
}

class ResetAppointmentButton extends StatelessWidget {
  const ResetAppointmentButton({
    super.key,
    required this.cubit,
    required this.requestDetails,
  });

  final CarOwnerRequestsCubit cubit;
  final dynamic requestDetails;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: PrimaryButton(
            onPressed: () {
              cubit.cancelMaintenanceRequest(requestDetails['id']).then(
                  (value) =>
                      Get.offAllNamed(CarOwnerRoutes.createMaintenanceRequest));
            },
            textButton: 'Reset Appointment'));
  }
}

class InitiatedAndPendingRequestButtonsBuilder extends StatelessWidget {
  const InitiatedAndPendingRequestButtonsBuilder({
    super.key,
    required this.cubit,
    required this.requestDetails,
  });

  final CarOwnerRequestsCubit cubit;
  final dynamic requestDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            CancelRequestButton(cubit: cubit, requestDetails: requestDetails));
  }
}

class CancelRequestButton extends StatelessWidget {
  const CancelRequestButton({
    super.key,
    required this.cubit,
    required this.requestDetails,
  });

  final CarOwnerRequestsCubit cubit;
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
