import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quickshif/view/intro_screen/intro_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';

class OnBoardingScreen extends StatefulWidget{
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast=false;

  var BoardingController=PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManger.kSecondry,
        appBar: AppBar(
          backgroundColor: ColorManger.kSecondry,

          actions: [
            TextButton(onPressed: (){
              Get.offAll(()=>const IntroScreen(),transition: Transition.rightToLeftWithFade,curve: Curves.linear,duration:const Duration(microseconds: 500));


            }, child: Text(
              'Skip',
              style: getMyMediumTextStyle(color: Colors.white),
            ))
          ],

        ),
        body:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              Expanded(
                child: PageView.builder(
                  onPageChanged: (index){

                  },
                  controller: BoardingController,
                  itemBuilder: (context,index)=>Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       const Spacer(),
                      Image.asset('assets/images/new_onboard.png',height: 300,),
                      const Spacer(),
                      Text(
                        'Your Next Career Awaits',
                        style: getMyRegulerTextStyle(color: Colors.black),
                      ),
                     const  SizedBox(
                        height: PaddingManger.kPadding,
                      ),
                      Text(
                        'Jobify simplifies job hunting with personalized listings, real-time alerts, and easy applications. Find your next opportunity quickly and effortlessly!',
                        textAlign: TextAlign.center,
                        style: getMyRegulerTextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: PaddingManger.kPadding,
                      ),


                    ],
                  ),
                  itemCount: 1,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:const EdgeInsetsDirectional.only(
                    bottom: 20
                ),
                child: Row(
                  children: [
                    SmoothPageIndicator(
                      controller: BoardingController,
                      count: 1,
                      effect: ExpandingDotsEffect(
                          dotColor: Colors.grey.shade200,
                          dotHeight: 10,
                          dotWidth: 10,
                          spacing: 8,
                          activeDotColor: ColorManger.kPrimary

                      ),
                    ),
                  const  Spacer(),
                    GestureDetector(
                      onTap: (){
                        Get.offAll(()=>const IntroScreen(),transition: Transition.rightToLeftWithFade,curve: Curves.linear,duration:const Duration(microseconds: 500));
                      },
                      child: Container(
                        padding:const EdgeInsetsDirectional.all(PaddingManger.kPadding/1.5),
                        decoration:const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorManger.kPrimary

                        ),
                        child: const Icon(
                          Icons.navigate_next,color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
  Widget buildPageViewItem(OnBoard board,context)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
            image: AssetImage(
                board.image
            )),
      ),
      Text(
          board.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.black
          )
      ),

    ],
  );
}

class OnBoard{
  final String image;
  final String  title;


  OnBoard({
   required this.title,
    required this.image
  });



}