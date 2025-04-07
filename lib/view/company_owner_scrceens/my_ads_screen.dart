import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../controller/login_controller/login_controller.dart';
import '../../model/user_model.dart';
import '../../shared/dialogs/loading_dialog.dart';
import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/font_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  final _loginController=Get.find<LoginController>(tag: 'login_controller');

  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      await _loginController.getMyAds();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=>LoadingOverlay(isLoading: _loginController.isLoading, child: Scaffold(
      body: SafeArea(
        child: Padding(

          padding: const EdgeInsets.all(PaddingManger.kPadding),
          child: Column(
            spacing: PaddingManger.kPadding,
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
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'My Job Screen',
                    style: getMyMediumTextStyle(
                        color: Colors.black, fontSize: FontSize.s20),
                  ),
                ],
              ),
              const SizedBox(
                height: PaddingManger.kPadding,
              ),

              if(_loginController.allMyAds.isNotEmpty)...[
                Expanded(
                  child: ListView.separated(

                      itemBuilder: (context,index)=>buildMyJob(_loginController.allMyAds[index]),
                      separatorBuilder: (context,index)=>const SizedBox(height: PaddingManger.kPadding/2,),
                      itemCount: _loginController.allMyAds.length),
                )
              ]else...[
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: PaddingManger.kPadding/2,
                      children: [
                        Text(
                          'There is No Ads For Your Company !',
                          textAlign: TextAlign.center,
                          style: getMyBoldTextStyle(color: ColorManger.grey,fontSize: FontSize.s20),
                        ),

                        const  Icon(Icons.work,color: ColorManger.kPrimary,size: 150,)

                      ],
                    ),
                  ),
                ),

              ]

            ],
          ),
        ),
      ),
    ),progressIndicator:const LoadingDialog(),));
  }


  Widget buildMyJob(JobModel model) => Slidable(
    key: Key(model.uid.toString()),
    startActionPane: ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (context) async{

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${model.description} deleted')),
            );
          },
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ],
    ),
    child: Container(
      padding: const EdgeInsetsDirectional.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(PaddingManger.kPadding / 2),
          color: ColorManger.grey.withOpacity(0.1)),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(PaddingManger.kPadding / 2)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.network(model.adsImage ?? '',fit: BoxFit.cover,),
          ),
          const SizedBox(
            width: PaddingManger.kPadding / 3,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.description,
                  style: getMyMediumTextStyle(color: Colors.black),
                ),
                Text(
                  model.companyName,
                  style: getMyRegulerTextStyle(
                      color: ColorManger.grey, fontSize: FontSize.s12),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

}
