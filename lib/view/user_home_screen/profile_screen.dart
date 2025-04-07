import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../controller/login_controller/login_controller.dart';
import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/font_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/my_button.dart';
import '../../shared/widgets/my_text_field.dart';
import '../login_screen/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _majorController = TextEditingController();
  final _loginController=Get.find<LoginController>(tag: 'login_controller');

  @override
  void initState() {
   _nameController.text=_loginController.userModel?.userName??'';
   _emailController.text=_loginController.userModel?.email??'';
   _phoneController.text=_loginController.userModel?.phoneNumber??'';
   _majorController.text=_loginController.userModel?.major??'';
   _descriptionController.text=_loginController.userModel?.description??'';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Obx(()=>LoadingOverlay(
      isLoading: _loginController.isLoading,
      progressIndicator:const CircularProgressIndicator(color: ColorManger.kPrimary,),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.all(PaddingManger.kPadding),
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
                      'Profile screen',
                      style: getMyMediumTextStyle(
                          color: ColorManger.kPrimary, fontSize: FontSize.s20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(_loginController.userModel?.profileImage??'' ),
                    ),
                    // const  CircleAvatar(
                    //   radius: 20,
                    //   backgroundColor: ColorManger.kPrimary,
                    //   child: Icon(
                    //     Icons.edit,
                    //     color: Colors.white,
                    //   ),
                    // )
                  ],
                ),
                const SizedBox(
                  height: PaddingManger.kPadding,
                ),
                MyTextField(
                    controller: _nameController,
                    labelText: 'User Name',
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    )),
                MyTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    enabled: false,
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.white,
                    )),
                MyTextField(
                    controller: _phoneController,
                    labelText: 'Phone',
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    )),
                MyTextField(
                    controller: _descriptionController,
                    labelText: 'Description',
                    prefixIcon: const Icon(
                      Icons.description,
                      color: Colors.white,
                    )),
                MyTextField(
                    controller: _majorController,
                    labelText: 'Major',
                    prefixIcon: const Icon(
                      Icons.work,
                      color: Colors.white,
                    )),
                const SizedBox(
                  height: PaddingManger.kPadding,
                ),
                Row(
                  spacing: PaddingManger.kPadding / 2,
                  children: [
                    Expanded(
                        child: MyButton(
                            title: 'Update',
                            onTap: ()async{
                              if(_nameController.text.isNotEmpty&&_phoneController.text.isNotEmpty&&_descriptionController.text.isNotEmpty&&_majorController.text.isNotEmpty){

                                await _loginController.updateUserData(name: _nameController.text, phone: _phoneController.text, description: _descriptionController.text, major: _majorController.text);

                              }else{
                                Utils.myToast(title: 'There is filed empty !!');
                              }

                            },
                            btnColor: ColorManger.kPrimary,
                            textColor: Colors.white)),
                    Expanded(
                        child: MyButton(
                            title: 'LogOut',
                            onTap: (){
                              Get.offAll(()=>const LoginScreen());
                            },
                            btnColor: Colors.white,
                            textColor: ColorManger.kPrimary)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
