import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/view/common/cubits/login/login_cubit.dart';
import 'package:auto_care/view/common/screens/authentication/login/login_page_body.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) async {
          if (state is LoginSuccessState) {
            if (state.response.statusCode == 200) {
              await CacheHelper.setString(
                      key: 'token',
                      value: state.response.data['data']['access'])
                  .then((value) {
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
                // CacheHelper.setBoolean(key: 'isLoggedIn', value: true);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
                
              });
              switch (state.response.data['data']['user_type']) {
                case 'Car Owner':
                  await CacheHelper.setString(
                      key: 'userType', value: 'carOwner');
                  Get.offAllNamed(CarOwnerRoutes.carOwnerMainPage);
                  break;
                case 'Workshop Owner':
                  await CacheHelper.setString(
                      key: 'userType', value: 'workshopOwner');
                  Get.offAllNamed(WorkshopOwnerRoutes.workshopOwnerMainPage);
                  break;
                case 'Tow Car Owner':
                  await CacheHelper.setString(
                      key: 'userType', value: 'towCarOwner');
                  Get.offAllNamed(TowCarRoutes.towCarOwnerHomePage);
                  break;
                default:
                  Get.offAllNamed(PartsSupplierRoutes.partsSupplierHomePage);
              }
            }
          } else if (state is LoginErrorState) {
            final snackBar = SnackBar(
              duration: const Duration(seconds: 3),
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Something went wrong',
                message: '${state.errorResponse!.data['detail']}',
                contentType: ContentType.failure,
              ),
            );
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Form(
                key: formKey,
                child: LoginPageBody(
                        phoneController: phoneController,
                        cubit: cubit,
                        state: state,
                        passwordController: passwordController,
                        formKey: formKey)
                    .animate(delay: 100.ms)
                    .fadeIn()
                    .scale()
                    .move(delay: 50.ms, duration: 400.ms)
                    .shimmer(delay: 150.ms),
              ),
            ),
          );
        },
      ),
    );
  }
}
