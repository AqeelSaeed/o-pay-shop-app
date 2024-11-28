import 'package:flutter/material.dart';

import '../../utils/assets_constants.dart';

class MyBackButton extends StatelessWidget {
  final BuildContext context;
  const MyBackButton({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // Utils.navigateBack(context);
      },
      child: Image.asset(Assets.backButton, height: 65,),
    );
  }
}
