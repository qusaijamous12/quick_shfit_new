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

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({super.key});

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  final _jobNameController = TextEditingController();
  final _jobDescriptionController = TextEditingController();
  final _jobRequirements = TextEditingController();
  final _loginController=Get.find<LoginController>(tag: 'login_controller');
  final _jobID=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(()=>LoadingOverlay(
        isLoading: _loginController.isLoading,
        progressIndicator:const LoadingDialog(),
        child: GestureDetector(
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
                          'Add Job Screen',
                          style: getMyMediumTextStyle(
                              color: Colors.black, fontSize: FontSize.s20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: PaddingManger.kPadding,
                    ),
                    Text(
                      'Please Fill the following fields to add a job ',
                      style: getMyMediumTextStyle(color: ColorManger.grey),
                    ),
                    GestureDetector(
                      onTap: (){
                        _showOptionDialog(context);
                      },
                      child: Align(
                        alignment: AlignmentDirectional.center,
                        child: Container(
                          height: 160,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          padding:const EdgeInsetsDirectional.all(PaddingManger.kPadding),
                          decoration:const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorManger.kPrimary

                          ),

                          child:_loginController.adsImage==null?const Icon(Icons.camera_alt,size: 120,color: Colors.white,):Image.file(File(_loginController.adsImage!.path),fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                    MyTextField(
                        controller: _jobNameController,
                        labelText: 'Job Name',
                        prefixIcon: const Icon(Icons.drive_file_rename_outline,color: Colors.white,)),
                    MyTextField(
                        controller: _jobDescriptionController,
                        labelText: 'Job Description',
                        prefixIcon: const Icon(Icons.description,color: Colors.white)),
                    MyTextField(
                        controller: _jobRequirements,
                        labelText: 'Job Requirements',
                        prefixIcon: const Icon(Icons.description,color: Colors.white)),
                    MyTextField(
                        controller: _jobID,
                        labelText: 'Job ID',
                        prefixIcon: const Icon(Icons.numbers,color: Colors.white)),
                    const SizedBox(
                      height: PaddingManger.kPadding,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:PaddingManger.kPadding*3),
                      child: MyButton(title: 'Add Job', onTap: () async{
                        if(_jobNameController.text.isNotEmpty&&_jobDescriptionController.text.isNotEmpty&&_jobRequirements.text.isNotEmpty&&_jobID.text.isNotEmpty){
                          await   _loginController.addJob(requirements: _jobRequirements.text, description: _jobDescriptionController.text, jobName: _jobNameController.text,jobId: _jobID.text);
                          _jobNameController.clear();
                          _jobDescriptionController.clear();
                          _jobRequirements.clear();
                          _jobID.clear();

                        }else{
                          Utils.myToast(title: 'All Fileds are requierd');
                        }

                      }, btnColor: Colors.white, textColor: ColorManger.kPrimary),
                    )
                  ],
                ),
              ),
            ),
          ),
        )));
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
