import 'package:auto_care/core/constant/imports.dart';
import 'package:get/get.dart';

class LeadingAppBar extends StatelessWidget {
  const LeadingAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back));
  }
}
