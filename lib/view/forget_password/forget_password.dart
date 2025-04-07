import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controller/login_controller/login_controller.dart';
import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/font_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/my_button.dart';
import '../../shared/widgets/my_text_field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final _emailController=TextEditingController();
    final _loginController=Get.find<LoginController>(tag: 'login_controller');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding:const EdgeInsetsDirectional.all(PaddingManger.kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Container(
                  height: 60,
                  decoration:const BoxDecoration(
                    color: ColorManger.kPrimary,
                    shape: BoxShape.circle
                  ),
                    child: IconButton(onPressed: (){
                      Get.back();
                    }, icon: const Icon(Icons.arrow_back,color: Colors.white,),color: ColorManger.kPrimary,)),
              ),
              SvgPicture.asset('assets/images/forget_password.svg'),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  'Forget Password',
                  style: getMyMediumTextStyle(color: ColorManger.kPrimary,fontSize: FontSize.s20*1.5),
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              MyTextField(controller: _emailController, labelText: 'Email Address', prefixIcon:const Icon(Icons.email_outlined,color: ColorManger.kPrimary,)),
               const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:PaddingManger.kPadding*4),
                child: MyButton(title: 'Submit', onTap: (){
                  if(_emailController.text.isEmpty){
                    Utils.myToast(title: 'Please Enter Your Email !');
                  }else{
                    _loginController.forgetPassword(email: _emailController.text);
                  }
                }, btnColor: ColorManger.kPrimary, textColor: Colors.white),
              )

            ],
          ),
        ),
      ),

    );
  }
}
