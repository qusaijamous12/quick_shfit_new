import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/login_controller/login_controller.dart';
import '../../controller/map_controller/map_controller.dart';
import '../../model/user_model.dart';
import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/font_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/my_app_bar.dart';
import '../../shared/widgets/my_button.dart';
import 'chat_screen.dart';

class JobDetails extends StatelessWidget {
  final JobModel model;
  const JobDetails({super.key,required this.model});

  @override
  Widget build(BuildContext context) {
    final _mapController=Get.find<MapController>(tag: 'map_controller');
    final _loginController=Get.find<LoginController>(tag: 'login_controller');
    return Scaffold(
      body: Obx(()=>LoadingOverlay(isLoading: _loginController.isLoading, child: SafeArea(
        child: Column(
          spacing: PaddingManger.kPadding,
          children: [
            Padding(
              padding: const EdgeInsets.all(PaddingManger.kPadding),
              child: Column(
                spacing: 20,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            padding: const EdgeInsetsDirectional.all(
                                PaddingManger.kPadding / 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(
                                    PaddingManger.kPadding / 2),
                                color: ColorManger.kPrimary),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>  ChatScreen(receiverId: model.uid),transition: Transition.rightToLeft,curve: Curves.linear,duration:const Duration(milliseconds: 500));

                        },
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundColor: ColorManger.kPrimary,
                          child:  Icon(Icons.message,color: Colors.white,),

                        ),
                      ),
                    ],
                  ),
                  RichText(text: TextSpan(

                    children: [
                      TextSpan(
                        text: 'Hello, Qusai Jamous the ${model.companyName} is hiring a  ',
                        style: getMyMediumTextStyle(color: ColorManger.grey)
                      ),
                      TextSpan(
                          text: '${model.jobName?.toUpperCase()??''}',
                          style: getMyMediumTextStyle(color: Colors.black)
                      ),

                    ]
                  )),


                  Container(
                    padding: const EdgeInsetsDirectional.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(
                            PaddingManger.kPadding / 2),
                        color: ColorManger.grey.withOpacity(0.1)),
                    child: Row(
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(
                                    PaddingManger.kPadding / 2)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.network(
                              model.jobImage??'',fit: BoxFit.cover,)),
                        const SizedBox(
                          width: PaddingManger.kPadding / 3,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.companyName.toUpperCase(),
                              style: getMyMediumTextStyle(color: Colors.black),
                            ),
                            Text(
                              model.jobName??'',
                              style: getMyRegulerTextStyle(
                                  color: ColorManger.grey,
                                  fontSize: FontSize.s12),
                            ),
                            Text(
                              'Company Location :',
                              style: getMyRegulerTextStyle(
                                  color: ColorManger.grey,
                                  fontSize: FontSize.s12),
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: ()async{

                              if(_mapController.myPosition!=null&&model.latitude.toString()!=''&&model.longitude.toString()!=''){
                                final url = 'https://www.google.com/maps/dir/?api=1&origin=${_mapController.myPosition?.latitude},${_mapController.myPosition?.longitude}&destination=${double.parse(model.latitude.toString())},${double.parse(model.longitude.toString())}';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                                else {
                                  throw 'Could not launch Google Maps';
                                }
                              }else{

                                Utils.myToast(title: 'Error Occurred');
                              }
                            },
                            child: const Icon(Icons.location_on_outlined,color: ColorManger.kPrimary,size: 40,))

                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius:const BorderRadiusDirectional.vertical(top: Radius.circular(PaddingManger.kPadding*2.5)),
                child: Container(
                  padding:
                  const EdgeInsetsDirectional.all(PaddingManger.kPadding),
                  decoration: BoxDecoration(
                      color: ColorManger.grey.withOpacity(0.1),
                      borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(PaddingManger.kPadding * 2.5),
                          topEnd: Radius.circular(PaddingManger.kPadding * 2.5))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: PaddingManger.kPadding,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 4,
                            decoration: BoxDecoration(
                                color: ColorManger.grey,
                                borderRadius: BorderRadiusDirectional.circular(
                                    PaddingManger.kPadding)),
                          )
                        ],
                      ),
                      Text(
                        'Job Description',
                        style: getMyBoldTextStyle(color: Colors.black),
                      ),
                      Text(
                        model.description,
                        textAlign: TextAlign.justify,
                        style: getMyRegulerTextStyle(color: Colors.black),
                      ),
                      Text(
                        'Job Requirements',
                        style: getMyBoldTextStyle(color: Colors.black),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const  SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsetsDirectional.all(PaddingManger.kPadding / 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.circular(10),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      radius: 8,
                                      backgroundColor: ColorManger.kPrimary,
                                    ),
                                    const SizedBox(
                                      width: PaddingManger.kPadding / 1.5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Job Requirements:  ${model.requirements}',
                                        style: getMyMediumTextStyle(
                                            color: Colors.black, fontSize: FontSize.s14),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              const  SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsetsDirectional.all(PaddingManger.kPadding / 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 8,
                                      backgroundColor: ColorManger.kPrimary,
                                    ),
                                    const SizedBox(
                                      width: PaddingManger.kPadding / 1.5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Company Email: ${model.email}',
                                        style: getMyMediumTextStyle(
                                            color: Colors.black, fontSize: FontSize.s14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const   SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsetsDirectional.all(PaddingManger.kPadding / 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 8,
                                      backgroundColor: ColorManger.kPrimary,
                                    ),
                                    const SizedBox(
                                      width: PaddingManger.kPadding / 1.5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Company Phone: ${model.mobileNumber}',
                                        style: getMyMediumTextStyle(
                                            color: Colors.black, fontSize: FontSize.s14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const   SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsetsDirectional.all(PaddingManger.kPadding / 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 8,
                                      backgroundColor: ColorManger.kPrimary,
                                    ),
                                    const SizedBox(
                                      width: PaddingManger.kPadding / 1.5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Company Owner Name: ${model.companyOwnerName}',
                                        style: getMyMediumTextStyle(
                                            color: Colors.black, fontSize: FontSize.s14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ))),
      bottomNavigationBar: Container(
        padding:const EdgeInsetsDirectional.only(bottom: PaddingManger.kPadding*2,start: PaddingManger.kPadding*2,end: PaddingManger.kPadding*2),
        color: ColorManger.grey.withOpacity(0.1),
        child: MyButton(title: 'Apply', onTap: ()async{
          await _loginController.applyForAJob(model: model);
        }, btnColor: ColorManger.kPrimary, textColor: Colors.white),
      ),
    );
  }

  // Widget buildJobRequirement() => Container(
  //       padding: const EdgeInsetsDirectional.all(PaddingManger.kPadding / 2),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadiusDirectional.circular(10),
  //       ),
  //       child: Row(
  //         children: [
  //           const CircleAvatar(
  //             radius: 8,
  //             backgroundColor: ColorManger.kPrimary,
  //           ),
  //           const SizedBox(
  //             width: PaddingManger.kPadding / 1.5,
  //           ),
  //           Expanded(
  //             child: Text(
  //               'Strong responsive web design experience',
  //               style: getMyMediumTextStyle(
  //                   color: Colors.black, fontSize: FontSize.s14),
  //             ),
  //           )
  //         ],
  //       ),
  //     );

}



