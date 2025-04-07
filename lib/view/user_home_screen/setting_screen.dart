import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/font_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../login_screen/login_screen.dart';
import 'contact_us.dart';
import 'profile_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // final _userController=Get.find<UserController>(tag: 'user_controller');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: PaddingManger.kPadding,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      padding:const EdgeInsetsDirectional.all(PaddingManger.kPadding/2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(PaddingManger.kPadding/2),
                        color: ColorManger.kPrimary
                      ),
                      child:const Icon(Icons.arrow_back,color: Colors.white,),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Setting Screen',
                    style: getMyMediumTextStyle(color: Colors.black,fontSize: FontSize.s20),
                  ),
                ],
              ),
               const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: (){
                  Get.to(()=>const ProfileScreen(),transition: Transition.rightToLeft,curve: Curves.linear,duration:const Duration(milliseconds: 500));
        
                },
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                  const  CircleAvatar(
                      radius: 30,
                      backgroundColor: ColorManger.kPrimary,
                      child: Icon(Icons.person_outline_sharp,color: Colors.white,size: 45,),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Profile',
                      style: getMyMediumTextStyle(color: Colors.black),
                    ),
                   const Spacer(),
                    const Icon(Icons.arrow_forward_ios_outlined,color: ColorManger.kPrimary,)
                  ],
                ),
              ),
              Divider(
                height: 3,
                thickness: 3,
                color: ColorManger.grey2,
              ),

              GestureDetector(
                onTap: (){
                  Get.to(()=>const ContactUsScreen());
                },
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                  const  CircleAvatar(
                      radius: 30,
                      backgroundColor: ColorManger.kPrimary,
                      child: Icon(Icons.email_outlined,color: Colors.white,size: 45,),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Contact Us',
                      style: getMyMediumTextStyle(color: Colors.black),
                    ),
                   const Spacer(),
                    const Icon(Icons.arrow_forward_ios_outlined,color: ColorManger.kPrimary,)
                  ],
                ),
              ),

              Divider(
                height: 3,
                thickness: 3,
                color: ColorManger.grey2,
              ),

              GestureDetector(
                onTap: (){
                  // Get.to(()=>const AboutUsScreen());
                },
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                  const  CircleAvatar(
                      radius: 30,
                      backgroundColor: ColorManger.kPrimary,
                      child: Icon(Icons.info_outline,color: Colors.white,size: 45,),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'About Us',
                      style: getMyMediumTextStyle(color: Colors.black),
                    ),
                  const  Spacer(),
        
                    const Icon(Icons.arrow_forward_ios_outlined,color: ColorManger.kPrimary,)
                  ],
                ),
              ),

              Divider(
                height: 3,
                thickness: 3,
                color: ColorManger.grey2,
              ),

              GestureDetector(
                onTap: ()async{
                 Get.offAll(()=>const LoginScreen());
                },
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                  const  CircleAvatar(
                      radius: 30,
                      backgroundColor: ColorManger.kPrimary,
                      child: Icon(Icons.logout,color: Colors.white,size: 45,),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'LogOut',
                      style: getMyMediumTextStyle(color: Colors.black),
                    ),
                  const  Spacer(),
        
                    const Icon(Icons.arrow_forward_ios_outlined,color: ColorManger.kPrimary,)
                  ],
                ),
              )
        
            ],
          ),
        ),
      ),
    );
  }
}

