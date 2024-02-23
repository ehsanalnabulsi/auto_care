import 'package:auto_care/core/constant/imports.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (!scaffoldKey.currentState!.isDrawerOpen) {
            scaffoldKey.currentState?.openDrawer();
          }
        },
        icon: const Icon(Icons.search));
  }
}