import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/login_controller/login_controller.dart';
import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../../shared/widgets/my_button.dart';
import '../login_screen/login_screen.dart';
import 'add_ads_screen.dart';
import 'add_job_screen.dart';
import 'my_ads_screen.dart';
import 'my_job_screen.dart';

class CompanyHomeScreen extends StatefulWidget {
  const CompanyHomeScreen({super.key});

  @override
  State<CompanyHomeScreen> createState() => _CompanyHomeScreenState();
}

class _CompanyHomeScreenState extends State<CompanyHomeScreen> {
  final _loginController=Get.find<LoginController>(tag: 'login_controller');
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManger.kPrimary,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [

                Container(
                  padding:const EdgeInsetsDirectional.all(PaddingManger.kPadding),
                  decoration:const BoxDecoration(
                    color: ColorManger.kPrimary,
                    borderRadius: BorderRadiusDirectional.only(bottomStart: Radius.circular(PaddingManger.kPadding),bottomEnd: Radius.circular(PaddingManger.kPadding))
                  ),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: PaddingManger.kPadding,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Main Screen',
                            style: getMyBoldTextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: (){
                              Get.offAll(()=> const LoginScreen());
                            },
                            child: const CircleAvatar(
                                backgroundColor:Colors.white,
                                child: Icon(
                                  Icons.logout,
                                  color: ColorManger.kPrimary,
                                )),
                          )

                        ],
                      ),
                      Row(
                        spacing: PaddingManger.kPadding/2,
                        children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:NetworkImage(_loginController.userModel?.profileImage??'') ,
                        ),
                          Expanded(
                            child: Text(
                              'Hello, ${_loginController.userModel?.companyOwnerName} Hope You Are doing well in you company ${_loginController.userModel?.companyName}',
                              style: getMyRegulerTextStyle(color: Colors.white),
                            ),
                          )


                        ],
                      ),



                    ],
                  ) ,
                ),
                const SizedBox(
                  height: PaddingManger.kPadding,
                ),
                Padding(
                  padding: const EdgeInsets.all(PaddingManger.kPadding),
                  child: Column(
                    spacing: PaddingManger.kPadding,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>const MyJobScreen(),transition: Transition.rightToLeft,duration:const Duration(milliseconds: 500),curve: Curves.linear);


                        },
                        child: Container(
                          padding:const EdgeInsetsDirectional.all(PaddingManger.kPadding),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(PaddingManger.kPadding),
                            color: Colors.white,

                          ),
                          child: Row(
                            children: [
                            const  Icon(Icons.work,color: ColorManger.kPrimary,size: 80,),
                              const SizedBox(
                                width: PaddingManger.kPadding,
                              ),
                              Text(
                                'My Jobs',
                                style: getMyMediumTextStyle(color: Colors.black,fontSize: 20),
                              ),
                             const  Spacer(),
                            const  Icon(Icons.arrow_forward_ios,color: ColorManger.kPrimary,size: 25,)
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>const MyAdsScreen(),transition: Transition.rightToLeft,duration:const Duration(milliseconds: 500),curve: Curves.linear);

                        },
                        child: Container(
                          padding:const EdgeInsetsDirectional.all(PaddingManger.kPadding),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(PaddingManger.kPadding),
                            color: Colors.white,

                          ),
                          child: Row(
                            children: [
                              const  Icon(Icons.ads_click,color: ColorManger.kPrimary,size: 80,),
                              const SizedBox(
                                width: PaddingManger.kPadding,
                              ),
                              Text(
                                'My Ads',
                                style: getMyMediumTextStyle(color: Colors.black,fontSize: 20),
                              ),
                              const  Spacer(),
                              const  Icon(Icons.arrow_forward_ios,color: ColorManger.kPrimary,size: 25,)
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>const AddJobScreen(),transition: Transition.rightToLeft,curve: Curves.linear,duration:const Duration(milliseconds: 500));
                        },
                        child: Container(
                          padding:const EdgeInsetsDirectional.all(PaddingManger.kPadding),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(PaddingManger.kPadding),
                            color: Colors.white,

                          ),
                          child: Row(
                            children: [
                              const  Icon(Icons.work_history_outlined,color: ColorManger.kPrimary,size: 80,),
                              const SizedBox(
                                width: PaddingManger.kPadding,
                              ),
                              Text(
                                'Add Job',
                                style: getMyMediumTextStyle(color: Colors.black,fontSize: 20),
                              ),
                              const  Spacer(),
                              const  Icon(Icons.arrow_forward_ios,color: ColorManger.kPrimary,size: 25,)
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>const AddAdsScreen(),transition: Transition.rightToLeft,duration:const Duration(milliseconds: 500),curve: Curves.linear);
                        },
                        child: Container(
                          padding:const EdgeInsetsDirectional.all(PaddingManger.kPadding),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(PaddingManger.kPadding),
                            color: Colors.white,

                          ),
                          child: Row(
                            children: [
                              const  Icon(Icons.add,color: ColorManger.kPrimary,size: 80,),
                              const SizedBox(
                                width: PaddingManger.kPadding,
                              ),
                              Text(
                                'Add Ads',
                                style: getMyMediumTextStyle(color: Colors.black,fontSize: 20),
                              ),
                              const  Spacer(),
                              const  Icon(Icons.arrow_forward_ios,color: ColorManger.kPrimary,size: 25,)
                            ],
                          ),
                        ),
                      ),




                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
