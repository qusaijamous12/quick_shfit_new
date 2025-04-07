import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../controller/login_controller/login_controller.dart';
import '../../shared/dialogs/loading_dialog.dart';
import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/font_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/my_button.dart';
import '../../shared/widgets/my_text_field.dart';
import '../forget_password/forget_password.dart';
import '../register_screen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginController=Get.find<LoginController>(tag: 'login_controller');
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Utils.hideKeyboard(context);
      },
      onVerticalDragDown: (details){
        Utils.hideKeyboard(context);
      },
      child:Obx(()=> LoadingOverlay(isLoading: _loginController.isLoading, child: Scaffold(
        backgroundColor: ColorManger.kSecondry,
        body: SafeArea(
          child: SingleChildScrollView(
            padding:const EdgeInsetsDirectional.all(20),
            child: Column(
              children: [
                Image.asset('assets/images/new_onboard.png',height: 400,),
                Text(
                  'Login',
                  style: getMyMediumTextStyle(color: ColorManger.kPrimary,fontSize: FontSize.s20*2),
                ),
                const SizedBox(
                  height: 40,
                ),
                MyTextField(controller: _emailController, labelText: 'Email Address', prefixIcon:const Icon(Icons.email_outlined,color: Colors.white,)),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(controller: _passwordController, labelText: 'Password', prefixIcon:const Icon(Icons.lock_open,color: Colors.white,),isPassword: true,),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: TextButton(onPressed: (){
                    Get.to(()=>const ForgetPassword());
                  }, child: Text(
                    'Forget Password?',
                    style: getMyMediumTextStyle(color: ColorManger.kPrimary),
                  )),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(title: 'LOGIN', onTap: ()async{
                  if(_emailController.text.isEmpty||_passwordController.text.isEmpty){
                    Utils.myToast(title: 'Please Enter Your Email And Password');
                  }else{
                  await  _loginController.login(email: _emailController.text, password: _passwordController.text);
                  }


                }, btnColor: ColorManger.kPrimary, textColor: Colors.white),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account ?',
                      style: getMyMediumTextStyle(color: Colors.white),
                    ),
                    TextButton(onPressed: (){
                      Get.offAll(()=>const RegisterScreen(),transition: Transition.rightToLeft,curve: Curves.linear,duration:const Duration(milliseconds: 500));

                    }, child: Text(
                      'Register',
                      style: getMyMediumTextStyle(color: ColorManger.kPrimary),
                    ))
                  ],
                )




              ],
            ),
          ),
        ),
      ),progressIndicator:const LoadingDialog(),)),
    );
  }
}
