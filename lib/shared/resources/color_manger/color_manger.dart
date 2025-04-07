import 'dart:ui';

class ColorManger{

  static const Color kPrimary=Color(0xff212b46);
  static const Color kSecondry=Color(0xff7984a4);
  static final Color grey1=HexColor.fromHex('#707070');
  static final Color grey2=HexColor.fromHex('#d797979');
  static final Color grey=HexColor.fromHex('#737477');
  static final Color lightGrey=HexColor.fromHex('#9E9E9E');

}


extension HexColor on Color{
  static Color fromHex(String hexColor){
    hexColor=hexColor.replaceAll('#', '');
    if(hexColor.length==6){
      hexColor='FF$hexColor';
    }
    return Color(int.parse(hexColor.toUpperCase(),radix: 16));
  }
}