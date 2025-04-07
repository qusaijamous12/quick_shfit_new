import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controller/login_controller/login_controller.dart';
import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/font_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../../shared/widgets/my_app_bar.dart';
import '../login_screen/login_screen.dart';
import 'add_company_owner.dart';

class MainAdminScreen extends StatefulWidget {
  const MainAdminScreen({super.key});

  @override
  State<MainAdminScreen> createState() => _MainAdminScreenState();
}

class _MainAdminScreenState extends State<MainAdminScreen> {
  Timer ?_timer;
  final _pageController=PageController();
  int _currentPage=0;

  void _onStart(){
    Future.delayed(const Duration(seconds: 4),_onFinish);
  }

  void _onFinish(){
    if(_currentPage==2){
      setState(() {
        _currentPage=0;
      });
    }else{
      setState(() {
        ++_currentPage;
      });

    }
    _pageController.animateToPage(_currentPage,duration:_currentPage==0?const Duration(milliseconds: 200):const Duration(seconds:3), curve: Curves.easeInOut);
    _onStart();

  }

  @override
  void initState() {
    _onStart();
    super.initState();
  }
  @override
  void dispose() {

    _timer?.cancel();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:Colors.white,
        actions: [
          IconButton(onPressed: (){
            Get.offAll(()=>const LoginScreen());
          }, icon:const Icon(Icons.logout,color: Colors.black,))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(PaddingManger.kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Admin ',
                style: getMySemiBoldTextStyle(color: Colors.black,fontSize: 25),
              ),
              const  SizedBox(
                height:PaddingManger.kPadding ,
              ),
              Text(
                'Please Move With The Following Steps to Add a Company Owner ',
                style: getMyMediumTextStyle(color: ColorManger.grey),
              ),
              const  SizedBox(
                height:PaddingManger.kPadding*2 ,
              ),
              SizedBox(
                height: 300,
                width: double.maxFinite,
                child: PageView(
                  onPageChanged: (index){
                    setState(() {
                      _currentPage=index;
                    });
                  },
                  controller:_pageController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image:const DecorationImage(image: NetworkImage('https://www.shutterstock.com/image-photo/male-mature-caucasian-ceo-businessman-600nw-2142010187.jpg'),fit: BoxFit.fill),
                            borderRadius: BorderRadiusDirectional.circular(10)
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 150,
                        width: double.infinity,


                        decoration: BoxDecoration(
                            image:const DecorationImage(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSblZ9YNv6gwVyunqGwUw2mrZq9G1Gu8FhRfQ&s'),fit: BoxFit.fill),
                            borderRadius: BorderRadiusDirectional.circular(10)

                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 150,
                        width: double.infinity,

                        decoration: BoxDecoration(
                            image:const DecorationImage(image: NetworkImage('https://media.istockphoto.com/id/184962061/photo/business-towers.jpg?s=612x612&w=0&k=20&c=gLQLQ9lnfW6OnJVe39r516vbZYupOoEPl7P_22Un6EM='),fit: BoxFit.fill),
                            borderRadius: BorderRadiusDirectional.circular(10)
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                      ),
                    )

                  ],
                ),
              ),
              const SizedBox(
                height:10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count:  3,
                    axisDirection: Axis.horizontal,
                    effect:  SlideEffect(
                        spacing:  8.0,
                        radius:  6.0,
                        dotWidth:  20.0,
                        dotHeight:  15.0,
                        paintStyle:  PaintingStyle.stroke,
                        strokeWidth: 2,
                        dotColor:  ColorManger.grey2,
                        activeDotColor:  ColorManger.kPrimary
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                'In the next screen, you will be prompted to enter the Company location, contact details, and other important information. Make sure the information is accurate to help users find their jobs easily.',
                textAlign: TextAlign.center,
                style: getMyRegulerTextStyle(color: ColorManger.grey),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(onPressed: (){
                    // Get.to(()=>const AddingStationOwnerScreen());
                    Get.to(()=>const AddCompanyOwner(),transition: Transition.leftToRight,curve: Curves.linear,duration:const Duration(milliseconds: 500));

                  },backgroundColor: ColorManger.kPrimary,child:const Icon(Icons.arrow_forward_ios,color: Colors.white,),)
                ],
              )






            ],
          ),
        ),
      ),
    )
    ;
  }
}
