import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/color_manger/color_manger.dart';
import '../resources/padding_manger.dart';


class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget prefixIcon;
  final bool enabled;
  final TextInputType keyBoardType;
  final bool isPassword;
  const MyTextField({super.key,required this.controller,required this.labelText,required this.prefixIcon,this.enabled=true,this.keyBoardType=TextInputType.emailAddress,this.isPassword=false});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool obsecureText=false;



  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(
              PaddingManger.kPadding),
          color: ColorManger.kPrimary
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: TextFormField(
        enabled: widget.enabled,
        obscureText: obsecureText,
        maxLines: widget.isPassword==false? null:1,
        minLines: 1,
        keyboardType: widget.keyBoardType,
        controller: widget.controller,
        decoration: InputDecoration(
            labelText: widget.labelText,
            prefixIcon: widget.prefixIcon,
            labelStyle:const TextStyle(
              color: Colors.white
            ),
            border: InputBorder.none,
          suffixIcon: widget.isPassword?GestureDetector(
            onTap: (){
              setState(() {
                obsecureText=!obsecureText;
              });
            },
              child:  Icon(obsecureText? Icons.visibility_off:Icons.visibility,color: Colors.white,)):const SizedBox()


        ),
        style:const TextStyle(
          color: Colors.white
        ),
      ),
    );
  }
}
