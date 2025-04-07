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
import '../../shared/utils/utils.dart';
import '../../shared/widgets/my_button.dart';
import '../../shared/widgets/my_text_field.dart';
import '../login_screen/login_screen.dart';

// class UserAndCompanyDetailsScreen extends StatelessWidget {
//   final UserModel userModel;
//
//   const UserAndCompanyDetailsScreen({super.key,required this.userModel});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding:const EdgeInsetsDirectional.all(PaddingManger.kPadding),
//           child: Column(
//             children: [
//
//               CircleAvatar(
//                 radius: 40,
//                 backgroundImage: NetworkImage(userModel.profileImage??''),
//               ),
//
//
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


class UserAndCompanyDetailsScreen extends StatefulWidget {
  final UserModel userModel;
  const UserAndCompanyDetailsScreen({super.key,required this.userModel});

  @override
  State<UserAndCompanyDetailsScreen> createState() => _UserAndCompanyDetailsScreenState();
}

class _UserAndCompanyDetailsScreenState extends State<UserAndCompanyDetailsScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _majorController = TextEditingController();
  final _loginController=Get.find<LoginController>(tag: 'login_controller');

  @override
  void initState() {
    _nameController.text=widget.userModel.status==0?widget.userModel.userName??'':widget.userModel.companyName??'';

    _emailController.text=widget.userModel.email??'';

    _phoneController.text=widget.userModel.phoneNumber??'';

    _majorController.text=widget.userModel.major??'';

    _descriptionController.text=widget.userModel.description??'';
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
                          color: Colors.black, fontSize: FontSize.s20),
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
                      backgroundImage: NetworkImage(widget.userModel.profileImage??'' ),
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
                      color: ColorManger.kPrimary,
                    )),
                MyTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    enabled: false,
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: ColorManger.kPrimary,
                    )),
                MyTextField(
                    controller: _phoneController,
                    labelText: 'Phone',
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: ColorManger.kPrimary,
                    )),
                MyTextField(
                    controller: _descriptionController,
                    labelText: 'Description',
                    prefixIcon: const Icon(
                      Icons.description,
                      color: ColorManger.kPrimary,
                    )),
                MyTextField(
                    controller: _majorController,
                    labelText: 'Major',
                    prefixIcon: const Icon(
                      Icons.work,
                      color: ColorManger.kPrimary,
                    )),
                const SizedBox(
                  height: PaddingManger.kPadding,
                ),
                Row(
                  spacing: PaddingManger.kPadding / 2,
                  children: [
                    Expanded(
                        child: MyButton(
                            title: 'Back',
                            onTap: ()async{
                            Get.back();

                            },
                            btnColor: ColorManger.kPrimary,
                            textColor: Colors.white)),
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

