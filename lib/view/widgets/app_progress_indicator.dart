import 'package:auto_care/core/constant/imports.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      heightFactor: 2,
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
      ),
    );
  }
}
