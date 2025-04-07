import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/login_controller/login_controller.dart';
import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/font_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/my_button.dart';


class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _loginController=Get.find<LoginController>(tag: 'login_controller');
  final _messageController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Utils.hideKeyboard(context);
      },
      onVerticalDragDown: (details){
        Utils.hideKeyboard(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(PaddingManger.kPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        padding:const EdgeInsetsDirectional.all(PaddingManger.kPadding/2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(PaddingManger.kPadding/2),
                            color: ColorManger.kPrimary
                        ),
                        child:const Icon(Icons.arrow_back,color: Colors.white,),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Contact Us',
                      style: getMyMediumTextStyle(color: Colors.black,fontSize: FontSize.s20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Please Fill the following field to send message to the support team...',
                  style: getMyMediumTextStyle(color: ColorManger.grey),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(20),
                      color: ColorManger.kPrimary.withOpacity(0.3)
                  ),
                  child: TextFormField(
                    minLines:1,
                    maxLines: null,
                    controller:_messageController ,
                    decoration:const InputDecoration(
                        labelText: 'Message',
                        prefixIcon: Icon(Icons.email_outlined,color: Colors.white,),
                        border: InputBorder.none
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: MyButton(title: 'Send', onTap: ()async{
                    if(_messageController.text.isEmpty){
                      Utils.myToast(title: 'Please Enter your message !');
                    }else{

                      await FirebaseFirestore.instance.collection('messages').add({
                        'message':_messageController.text,
                        'user':_loginController.userModel?.userName,
                        'email':_loginController.userModel?.email,
                        'uid':_loginController.userModel?.uid,
                        'profile_image':_loginController.userModel?.profileImage
                      }).then((value){
                        Utils.myToast(title: 'Send Success !');
                        _messageController.clear();

                      }).catchError((error){
                        Utils.myToast(title: 'Check Your Internet !');
                      });
                    }
                  }, btnColor: ColorManger.kPrimary, textColor: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

