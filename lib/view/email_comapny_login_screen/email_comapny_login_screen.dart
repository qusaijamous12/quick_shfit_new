import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../controller/login_controller/login_controller.dart';
import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/my_button.dart';
import '../../shared/widgets/my_text_field.dart';
import '../login_screen/login_screen.dart';

class EmailCompanyLoginScreen extends StatefulWidget {
  const EmailCompanyLoginScreen({super.key});

  @override
  State<EmailCompanyLoginScreen> createState() => _EmailCompanyLoginScreenState();
}

class _EmailCompanyLoginScreenState extends State<EmailCompanyLoginScreen> {
  final _emailController=TextEditingController();
  final _loginController=Get.find<LoginController>(tag: 'login_controller');
  @override
  Widget build(BuildContext context) {
    return Obx(()=>LoadingOverlay(isLoading: _loginController.isLoading, child: Scaffold(
      backgroundColor: ColorManger.kSecondry,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(PaddingManger.kPadding),
          child: Column(
            children: [
              const Spacer(),
              Image.asset('assets/images/new_onboard.png',height: 300,),
              const Spacer(),
              const Spacer(),

              Text(
                'Please Enter Your email',
                textAlign: TextAlign.center,
                style: getMyMediumTextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(controller: _emailController, labelText: 'Email Address', prefixIcon:const Icon(Icons.email,color: Colors.white,)),
              const SizedBox(
                height: PaddingManger.kPadding,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: PaddingManger.kPadding*2),
                child: MyButton(title: 'Submit', onTap: ()async{
                  if(_emailController.text.isEmpty){
                    Utils.myToast(title: 'Please enter your email');
                  }else{

                    final result=await _loginController.ensureCompanyAccount(email: _emailController.text);
                    if(result){
                      _emailController.clear();
                      Get.offAll(()=>const LoginScreen());

                    }else{
                      _emailController.clear();
                      Utils.myToast(title: 'You Dont have an account !');
                    }

                  }
                }, btnColor: ColorManger.kPrimary, textColor: Colors.white),
              ),
              const SizedBox(
                height: PaddingManger.kPadding,
              ),





            ],
          ),
        ),
      ),
    ),progressIndicator:const CircularProgressIndicator(color: ColorManger.kPrimary,),));
  }
}
