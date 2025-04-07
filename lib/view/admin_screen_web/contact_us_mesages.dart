import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/login_controller/login_controller.dart';
import '../../model/user_model.dart';
import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';

class ContactUsMessages extends StatefulWidget {
  const ContactUsMessages({super.key});

  @override
  State<ContactUsMessages> createState() => _ContactUsMessagesState();
}

class _ContactUsMessagesState extends State<ContactUsMessages> {
  final _loginController = Get.find<LoginController>(tag: 'login_controller');

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await _loginController.getAllContactUsMessages();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildUserList(),
      ),
    );
  }

  Widget buildContactUsList(MessageModel model) => Row(
        spacing: PaddingManger.kPadding / 2,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(model.profileImage??''),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: PaddingManger.kPadding / 2,
            children: [
              Text(model.user??'',
              style: getMyMediumTextStyle(color: Colors.black),),
              Text(model.message??'',
              style: getMyRegulerTextStyle(color: ColorManger.grey),)],
          )
        ],
      );

  Widget _buildUserList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _loginController.allContactUsMessages.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: Text(
              _loginController.allContactUsMessages[index].user ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Message: ${_loginController.allContactUsMessages[index].message}'),
            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              backgroundImage: NetworkImage(_loginController.allContactUsMessages[index].profileImage ?? ''),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        );
      },
    );
  }

}
