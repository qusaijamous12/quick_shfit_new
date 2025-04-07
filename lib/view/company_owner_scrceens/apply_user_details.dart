import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/user_model.dart';
import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../../shared/widgets/my_button.dart';
import '../../shared/widgets/my_text_field.dart';
import '../user_home_screen/chat_screen.dart';

class ApplyUserDetails extends StatelessWidget {
  final UserModel userModel;
  const ApplyUserDetails({super.key,required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManger.kPrimary,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon:const Icon(Icons.arrow_back_ios,color: Colors.white,)),

      ),
      body: SingleChildScrollView(
        padding:const EdgeInsetsDirectional.all(PaddingManger.kPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Align(
              alignment: AlignmentDirectional.center,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(userModel.profileImage),
              ),
            ),
            const SizedBox(
              height: PaddingManger.kPadding*2,
            ),
            MyTextField(controller: TextEditingController(text: userModel.userName), labelText: 'User Name', prefixIcon:const Icon(Icons.person,color: Colors.white,)),
           const  SizedBox(
              height: PaddingManger.kPadding,
            ),
            MyTextField(controller: TextEditingController(text: userModel.email), labelText: 'User Email', prefixIcon:const Icon(Icons.email_outlined,color: Colors.white,)),


            const  SizedBox(
              height: PaddingManger.kPadding,
            ),
            MyTextField(controller: TextEditingController(text: userModel.major), labelText: 'User Major', prefixIcon:const Icon(Icons.work,color: Colors.white,)),
            const  SizedBox(
              height: PaddingManger.kPadding,
            ),
            MyTextField(controller: TextEditingController(text: userModel.description), labelText: 'User Description', prefixIcon:const Icon(Icons.description,color: Colors.white,)),
            const  SizedBox(
              height: PaddingManger.kPadding,
            ),
            MyTextField(controller: TextEditingController(text: userModel.phoneNumber), labelText: 'User Phone Number', prefixIcon:const Icon(Icons.phone,color: Colors.white,)),
            const  SizedBox(

              height: PaddingManger.kPadding*2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: PaddingManger.kPadding*3),
              child: MyButton(title: 'Chat', onTap: (){
                Get.to(()=>ChatScreen(receiverId: userModel.uid));
              }, btnColor: Colors.white, textColor: ColorManger.kPrimary),
            )

          ],
        ),
      ),
    );
  }
}
