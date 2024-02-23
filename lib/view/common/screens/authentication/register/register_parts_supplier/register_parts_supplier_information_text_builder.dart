import 'package:auto_care/core/constant/imports.dart';

class StoreInformationText extends StatelessWidget {
  const StoreInformationText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Store Information',
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
