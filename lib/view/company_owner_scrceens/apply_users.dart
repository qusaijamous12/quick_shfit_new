import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../controller/login_controller/login_controller.dart';
import '../../model/user_model.dart';
import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/font_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../login_screen/login_screen.dart';
import 'apply_user_details.dart';

class ApplyUsers extends StatefulWidget {
  final JobModel model;
  const ApplyUsers({super.key,required this.model});

  @override
  State<ApplyUsers> createState() => _ApplyUsersState();
}

class _ApplyUsersState extends State<ApplyUsers> {
  final _loginController=Get.find<LoginController>(tag: 'login_controller');

  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      await _loginController.getAllApplyUsers(widget.model);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Obx(()=>LoadingOverlay(isLoading: _loginController.isLoading, child: Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManger.kPrimary,
        title: Text(
          'Apply Users',
          style: getMyMediumTextStyle(color: Colors.white),
        ),
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon:const Icon(Icons.arrow_back_ios,color: Colors.white,)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.all(PaddingManger.kPadding),
          child: Column(
            children: [

              ListView.separated(
                shrinkWrap: true,
                  physics:const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index)=>buildApplyUsersWidget(_loginController.allApplyUsers[index]),
                  separatorBuilder: (context,index)=>const SizedBox(
                    height: PaddingManger.kPadding/2,
                  ),
                  itemCount: _loginController.allApplyUsers.length)
            ],
          ),
        ),
      ),
    )));
  }

  Widget buildApplyUsersWidget(UserModel model) => GestureDetector(
    onTap: (){
      Get.to(()=>ApplyUserDetails(userModel: model));
    },
    behavior: HitTestBehavior.opaque,
    child: Row(
          spacing: PaddingManger.kPadding / 2,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(model.profileImage ?? ''),
              backgroundColor: Colors.red,
            ),
            Expanded(
              flex: 6,
              child: Text(
                model.userName ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: getMyMediumTextStyle(color: Colors.black),
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: Colors.black,
              size: 30,
            )
          ],
        ),
  );
}
