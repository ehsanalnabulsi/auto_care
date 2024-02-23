import 'package:auto_care/core/constant/image_asset.dart';
import 'package:auto_care/core/constant/imports.dart';

class WorkshopImageBuilder extends StatelessWidget {
  const WorkshopImageBuilder({
    super.key,
    required this.workshop,
  });

  final dynamic workshop;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: workshop['logo'] == null
            ? Image.asset(ImageAsset.defaultImage, fit: BoxFit.cover)
            : Image.network(workshop['logo'], fit: BoxFit.cover));
  }
}