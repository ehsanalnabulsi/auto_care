import 'package:auto_care/core/constant/imports.dart';

class WorkshopOwnerFloatingActionButton extends StatelessWidget {
  const WorkshopOwnerFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: AppColors.secondaryColor,
      tooltip: 'Order tow car',
      clipBehavior: Clip.none,
      child: const Icon(Icons.car_crash_outlined),
    );
  }
}