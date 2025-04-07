import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quickshif/view/on_board_screen/on_board_screen.dart';

import '../../shared/resources/color_manger/color_manger.dart';
import '../intro_screen/intro_screen.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer ?_timers;

  void _onStart(){
    _timers=Timer(const Duration(seconds: 4), _onFinish);
  }

  void _onFinish(){
    Get.offAll(()=> OnBoardingScreen(),transition: Transition.rightToLeft,curve: Curves.linear,duration:const Duration(milliseconds: 500));
  }


  @override
  void initState() {
    _onStart();
    super.initState();
  }


  @override
  void dispose() {
    _timers?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body:Center(child:Image.asset('assets/images/new_logo.png')),


    );
  }
}