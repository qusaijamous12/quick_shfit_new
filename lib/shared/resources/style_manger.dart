import 'package:flutter/material.dart';

import 'font_manger.dart';

TextStyle _getMyTextStyle({required Color color,required double fontSize,required String fontFamily,required FontWeight weight,TextDecoration ?textDecoration}){

  return TextStyle(
    fontSize: fontSize,
    fontWeight: weight,
    color: color,
    fontFamily: fontFamily,
    decoration: textDecoration
  );
}

TextStyle getMyLightTextStyle({required Color color,double fontSize=FontSize.s12}){
  return _getMyTextStyle(color: color, fontSize:fontSize , fontFamily: FontFamily.fontFamily, weight: TextFontWeight.lightWeight);
}

TextStyle getMyRegulerTextStyle({required Color color,double fontSize=FontSize.s14,TextDecoration ?textDecoration}){
  return _getMyTextStyle(color: color, fontSize:fontSize , fontFamily: FontFamily.fontFamily, weight: TextFontWeight.regulerWeight,textDecoration: textDecoration);
}

TextStyle getMyMediumTextStyle({required Color color,double fontSize=FontSize.s16}){
  return _getMyTextStyle(color: color, fontSize:fontSize , fontFamily: FontFamily.fontFamily, weight: TextFontWeight.mediumWeight);
}

TextStyle getMySemiBoldTextStyle({required Color color,double fontSize=FontSize.s16}){
  return _getMyTextStyle(color: color, fontSize:fontSize , fontFamily: FontFamily.fontFamily, weight: TextFontWeight.semiBoldWeight);
}

TextStyle getMyBoldTextStyle({required Color color,double fontSize=FontSize.s18}){
  return _getMyTextStyle(color: color, fontSize:fontSize , fontFamily: FontFamily.fontFamily, weight: TextFontWeight.boldWeight);
}