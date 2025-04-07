import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/color_manger/color_manger.dart';
import '../resources/style_manger.dart';

PreferredSizeWidget myAppBar({required String title,bool ?showIcon=true,}) => AppBar(
      backgroundColor: ColorManger.kPrimary,
      title: Text(
        title,
        style: getMyMediumTextStyle(color: Colors.white),
      ),
      leading: IconButton(
          onPressed: () {
            if(showIcon==true){
              Get.back();
            }

          },
          icon:  Icon(
            Icons.arrow_back_ios,
            color: showIcon==true?Colors.white:ColorManger.kPrimary,
          )),
    );
