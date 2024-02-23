
import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/common/cubits/register/workshop_owner/register_workshop_owner_cubit.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class SelectMultiBrandField extends StatelessWidget {
  const SelectMultiBrandField({
    super.key,
    required this.cubit,
  });

  final RegisterWorkshopOwnerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return MultiSelectBottomSheetField(
      validator: (value) {
        if (value == null) {
          return 'Selecting Brands Is required';
        }
        return null;
      },
      buttonText: Text(
        'Select Brands',
        style: Theme.of(context).textTheme.labelLarge,
      ),
      selectedItemsTextStyle: const TextStyle(color: AppColors.whiteColor),
      searchable: true,
      isDismissible: true,
      chipDisplay: MultiSelectChipDisplay(
        textStyle: const TextStyle(color: AppColors.whiteColor),
        chipColor: AppColors.secondaryColor,
      ),
      buttonIcon: const Icon(Icons.arrow_drop_down),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: AppColors.greyColor,
        ),
      ),
      title: Text(
        'Brands',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      listType: MultiSelectListType.CHIP,
      selectedColor: AppColors.primaryColor,
      items: cubit.brandsNames
          .map((type) => MultiSelectItem<String>(type, type))
          .toList(),
      initialValue: const [],
      onConfirm: (onConfirm) {
        cubit.updateSelectedBrands(onConfirm);
      },
    );
  }
}
