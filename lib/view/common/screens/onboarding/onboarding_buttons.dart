import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/view/widgets/primary_button.dart';
import 'package:auto_care/view/widgets/secondary_button.dart';
import 'package:get/get.dart';

class GoToRegisterPageButton extends StatelessWidget {
  const GoToRegisterPageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
        onPressed: () {
          // submit();
          CacheHelper.setBoolean(key: 'onBoardingSkipped', value: true)
              .then((value) {

            Get.offNamed(SharedRoutes.registerMainPage);
          });
        },
        child: const Text("Register"));
  }
}

class GoToLoginPageButton extends StatelessWidget {
  const GoToLoginPageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        // submit();
        CacheHelper.setBoolean(key: 'onBoardingSkipped', value: true)
            .then((value) {
          Get.offNamed(SharedRoutes.login);
        });
      },
      textButton: 'Log In',
    );
  }
}
