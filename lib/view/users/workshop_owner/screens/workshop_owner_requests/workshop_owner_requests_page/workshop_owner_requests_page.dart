import 'package:auto_care/view/users/car_owner/screens/car_owner_requests/car_owner_requests_page.dart';
import 'package:auto_care/view/users/workshop_owner/cubits/workshop_owner_requests_cubit/workshop_owner_requests_cubit.dart';
import 'package:auto_care/view/users/workshop_owner/screens/workshop_owner_requests/workshop_owner_requests_page/maintenance_requests_card_builder.dart';
import 'package:auto_care/view/widgets/app_progress_indicator.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkshopOwnerRequestsPage extends StatelessWidget {
  const WorkshopOwnerRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkshopOwnerRequestsCubit()..getUserRequests(),
      child:
          BlocConsumer<WorkshopOwnerRequestsCubit, WorkshopOwnerRequestsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = WorkshopOwnerRequestsCubit.get(context);
          var theme = Theme.of(context).textTheme;
          return Scaffold(
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
                      MaintenanceRequestsCardBuilder(cubit: cubit, theme: theme)
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
