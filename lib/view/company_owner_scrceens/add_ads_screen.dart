import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class AddAdsScreen extends StatefulWidget {
  const AddAdsScreen({super.key});

  @override
  State<AddAdsScreen> createState() => _AddAdsScreenState();
}

class _AddAdsScreenState extends State<AddAdsScreen> {
  final _loginController = Get.find<LoginController>(tag: 'login_controller');
  final _titleController=TextEditingController();
  final _descriptionController=TextEditingController();
  final _adIdController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Obx(() => LoadingOverlay(isLoading: _loginController.isLoading, child: GestureDetector(
      onTap: (){
        Utils.hideKeyboard(context);
      },
      onVerticalDragDown: (details){
        Utils.hideKeyboard(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.all(PaddingManger.kPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Add Ads Screen',
                      style: getMyMediumTextStyle(
                          color: Colors.black, fontSize: FontSize.s20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Select Image for your ads',
                  style: getMyMediumTextStyle(color: ColorManger.lightGrey),
                ),
                GestureDetector(
                  onTap: () {
                    _showOptionDialog(context);
                  },
                  child: Container(
                    height: 200,
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(
                            PaddingManger.kPadding),
                        color: ColorManger.grey.withOpacity(0.2)),
                    child: _loginController.adsImage == null
                        ? const Icon(
                      Icons.camera_alt,
                      size: 100,
                    )
                        : Image.file(
                      File(_loginController.adsImage?.path ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                MyTextField(controller: _titleController, labelText: 'AD Title', prefixIcon:const Icon(Icons.work,color: Colors.white,)),
                MyTextField(controller: _descriptionController, labelText: 'AD Description', prefixIcon:const Icon(Icons.description,color: Colors.white,)),

                MyTextField(controller: _adIdController, labelText: 'Ad ID', prefixIcon:const Icon(Icons.numbers,color: Colors.white,)),

                const SizedBox(
                  height: PaddingManger.kPadding,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: PaddingManger.kPadding*3),
                  child: MyButton(
                      title: 'Add Ads',
                      onTap: () async {
                        if(_loginController.adsImage==null&&_titleController.text.isEmpty||_descriptionController.text.isEmpty||_adIdController.text.isEmpty){
                          Utils.myToast(title: 'Please fill all fields !');
                        }
                        else{
                          await _loginController.addAds(title: _titleController.text,description: _descriptionController.text,addId: _adIdController.text);
                          _titleController.clear();
                          _descriptionController.clear();
                          _adIdController.clear();
                        }

                      },
                      btnColor: Colors.white,
                      textColor: ColorManger.kPrimary),
                )
              ],
            ),
          ),
        ),
      ),
    ),progressIndicator:const LoadingDialog(),));
  }

  void _showOptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select an Option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  Get.back();
                  await _loginController.uploadImage(isGallery: false);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Get.back();
                  await _loginController.uploadImage(isGallery: true);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Cancel'),
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
