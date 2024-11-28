import 'package:flutter/material.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? leadingAsset;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leadingAsset,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      elevation: 0,
      leadingWidth: 65,
      toolbarHeight: double.infinity,
      leading: leadingAsset != null
          ? Padding(
              padding: const EdgeInsets.all(0.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  leadingAsset!,
                  fit: BoxFit.contain,
                  width: 46,
                ),
              ),
            )
          : const SizedBox.shrink(),
      title: Text(
        Utils.getTranslatedLabel(context, title),
        style: Styles.appBarThemeStyle(context),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}
