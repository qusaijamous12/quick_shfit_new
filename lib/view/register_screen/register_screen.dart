import 'package:dropdown_button2/dropdown_button2.dart';
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
import '../login_screen/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  final _phoneController=TextEditingController();
  final _ageController=TextEditingController();
  final _nameController=TextEditingController();
  final _descriptionController=TextEditingController();
  final _majorController=TextEditingController();
  final _loginController=Get.find<LoginController>(tag: 'login_controller');

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: (){
        Utils.hideKeyboard(context);
      },
      onVerticalDragDown: (details){
        Utils.hideKeyboard(context);
      },
      child: Obx(()=>LoadingOverlay(isLoading: _loginController.isLoading, child: Scaffold(
        backgroundColor: ColorManger.kSecondry,
        body: SafeArea(
          child: SingleChildScrollView(
            padding:const EdgeInsetsDirectional.all(PaddingManger.kPadding),
            child: Column(
              children: [
                Image.asset('assets/images/new_onboard.png',height: 400,),
                Text(
                  'Register',
                  style: getMyMediumTextStyle(color: ColorManger.kPrimary,fontSize: FontSize.s20*2),
                ),
                const SizedBox(
                  height: 40,
                ),
                MyTextField(controller: _nameController, labelText: 'User Name', prefixIcon:const Icon(Icons.person,color: Colors.white,)),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(controller: _emailController, labelText: 'Email Address', prefixIcon:const Icon(Icons.email_outlined,color: Colors.white,)),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(controller: _phoneController, labelText: 'Mobile Number', prefixIcon:const Icon(Icons.phone,color: Colors.white,),keyBoardType: TextInputType.phone,),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(controller: _ageController, labelText: 'Age', prefixIcon:const Icon(Icons.numbers,color: Colors.white,),keyBoardType: TextInputType.phone,),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(controller: _passwordController, labelText: 'Password', prefixIcon:const Icon(Icons.lock_open,color: Colors.white,),isPassword: true,),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(controller: _majorController, labelText: 'Major', prefixIcon:const Icon(Icons.lock_open,color: Colors.white,)),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(controller: _descriptionController, labelText: 'Description', prefixIcon:const Icon(Icons.description,color: Colors.white,)),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(20),
                    color: ColorManger.kPrimary
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: DropdownButtonFormField2(
                    value: _loginController.selectedValue.value,
                    decoration: InputDecoration(

                        hintText: 'Select ...',
                        hintStyle: TextStyle(
                          color: Colors.white
                        ),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: ColorManger.grey.withOpacity(0.1)
                    ),
                    items:_loginController.genderItems.map((e)=>DropdownMenuItem<String>(
                      value: e,
                      child: Text(
                        e,
                        style: getMyMediumTextStyle(color: Colors.black,fontSize: FontSize.s14),
                      ),
                    )).toList(),
                    onChanged: (value) {
                      _loginController.selectedValue(value.toString());

                    },

                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8),

                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: ColorManger.kPrimary,
                      ),
                      iconSize: 24,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),

                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),

                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                MyButton(title: 'Register', onTap: ()async{
                  print('selected value is is is ${_loginController.selectedValue.value}');
                  print('selected value is is is ${_emailController.text}');
                  print('selected value is is is ${_phoneController.text}');
                  print('selected value is is is ${_nameController.text}');
                  print('selected value is is is ${_descriptionController.text}');
                  print('selected value is is is ${_passwordController.text}');
                  print('selected value is is is ${_majorController.text}');
                  print('selected value is is is ${_ageController.text}');







                  if(_emailController.text.isEmpty||_phoneController.text.isEmpty||_nameController.text.isEmpty||_descriptionController.text.isEmpty||_passwordController.text.isEmpty||_ageController.text.isEmpty||_loginController.selectedValue.value==null||_majorController.text.isEmpty){
                    Utils.myToast(title: 'Please Fill All Fields');
                  }else{
                    await _loginController.createAccount(email: _emailController.text, name: _nameController.text, password: _passwordController.text, phoneNumber: _phoneController.text, age: _ageController.text, description: _descriptionController.text, major: _majorController.text, gender: _loginController.selectedValue.value??'');
                  }

                }, btnColor: ColorManger.kPrimary, textColor: Colors.white),
                const SizedBox(
                  height: 15,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ?',
                      style: getMyMediumTextStyle(color: Colors.white),
                    ),
                    TextButton(onPressed: (){
                      Get.offAll(()=>const LoginScreen(),transition: Transition.leftToRight,curve: Curves.linear,duration:const Duration(milliseconds: 500));

                    }, child: Text(
                      'Login',
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
