import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../../shared/widgets/my_button.dart';
import '../email_comapny_login_screen/email_comapny_login_screen.dart';
import '../login_screen/login_screen.dart';
import '../register_screen/register_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  bool showBtn=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.kSecondry,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(PaddingManger.kPadding),
          child: Column(
            children: [
              const Spacer(),
              Image.asset('assets/images/new_onboard.png'),
              const Spacer(),
            const  Spacer(),

              Text(
                'Lets Create Account And Start Lookings for A job ',
                textAlign: TextAlign.center,
                style: getMyMediumTextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 60,
              ),

              MyButton(title: 'Login', onTap: (){
                setState(() {
                  showBtn=!showBtn;
                });
                }, btnColor: ColorManger.kPrimary, textColor: Colors.white),
              if(showBtn)...[
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: PaddingManger.kPadding/2,
                  children: [
                    Expanded(child: MyButton(title: 'Company', onTap: (){
                      Get.offAll(()=>const EmailCompanyLoginScreen());

                    }, btnColor: ColorManger.kPrimary, textColor: Colors.white)),
                    Expanded(child: MyButton(title: 'Employee', onTap: (){
                      Get.offAll(()=>const LoginScreen());

                    }, btnColor:  ColorManger.kPrimary, textColor: Colors.white)),


                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

              ]else...[
                const SizedBox(
                  height: 20,
                ),
              ],

              MyButton(title: 'Register', onTap: (){
                Get.offAll(()=>const RegisterScreen());

              }, btnColor:Colors.white, textColor: ColorManger.kPrimary),
              const Spacer(),



            ],
          ),
        ),
      ),
    );
  }
}
