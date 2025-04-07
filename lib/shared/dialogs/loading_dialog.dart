import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/color_manger/color_manger.dart';
import '../resources/style_manger.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: ColorManger.kPrimary,),  // Circular loading indicator
          const SizedBox(width: 20),  // Space between indicator and text
          Text('Loading...',style:getMyMediumTextStyle(color: Colors.black) ,),  // Optional text
        ],
      ),
    );
  }
}
