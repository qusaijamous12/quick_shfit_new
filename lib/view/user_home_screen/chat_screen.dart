import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/login_controller/login_controller.dart';
import '../../controller/user_controller/user_controller.dart';
import '../../model/chat_model.dart';
import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/font_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../../shared/utils/utils.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.receiverId});

  final String receiverId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _loginController = Get.find<LoginController>(tag: 'login_controller');

  final _messageController = TextEditingController();

  final _scrollController = ScrollController();


  @override
  void initState() {


    Future.delayed(Duration.zero, () async {
      await _loginController.getMessages(receiverId: widget.receiverId);
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: () {
        Utils.hideKeyboard(context);
      },
      onVerticalDragDown: (details) {
        Utils.hideKeyboard(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Messages'.tr,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: ColorManger.kPrimary,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              Expanded(
                child: Container(
                  padding: const EdgeInsetsDirectional.all(20),
                  decoration: BoxDecoration(
                      // color: ColorManger.kPrimary.withOpacity(0.5),
                      borderRadius: BorderRadiusDirectional.circular(20)),

                  child: SingleChildScrollView(
                    controller: _scrollController,

                    child: Column(
                      children: [
                        Container(
                          padding:const EdgeInsetsDirectional.all(PaddingManger.kPadding/2),
                          decoration:const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManger.kPrimary
                          ),
                          child:const Icon(Icons.chat,color:Colors.white,size: 100,),
                        ),
                        const SizedBox(height: 20),
                        ListView.separated(
                            shrinkWrap: true,
                            physics:const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (_loginController.listChatModel[index].senderId !=
                                  _loginController.userModel?.uid) {
                                return buildMessage(
                                    _loginController.listChatModel[index]);
                              } else {
                                return buildMyMessage(
                                    _loginController.listChatModel[index]);
                              }
                            },
                            separatorBuilder: (context, index) => const SizedBox(
                              height: 20,
                            ),
                            itemCount: _loginController.listChatModel.length),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsetsDirectional.only(start: 7),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // DoctorCubit.get(context).openGalaryToSendImage();
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.image,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _messageController,
                        decoration: InputDecoration(
                            hintText: 'Write Your Message Here'.tr,
                            border: InputBorder.none),
                      ),
                    ),
                    Container(
                      color: ColorManger.kPrimary,
                      height: 60,
                      width: 60,
                      child: IconButton(
                          onPressed: () {
                            if (_messageController.text.isNotEmpty) {
                              _loginController.sendMessage(
                                  receiverId: widget.receiverId,
                                  dateTime: DateTime.now().toString(),
                                  text: _messageController.text,
                                  profileImage: _loginController
                                      .userModel?.profileImage ??
                                      '');
                              _messageController.clear();
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            } else {
                              Utils.myToast(title: 'Message is Requierd');
                            }
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget buildMessage(ChatModel model) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Row(
      mainAxisSize: MainAxisSize.min, // Make Row shrink to fit content
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(model.profileImage ?? ''),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Container(
            padding:
            const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: ColorManger.kPrimary.withOpacity(0.1),
              borderRadius: const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.text ?? '',
                  style: const TextStyle(fontSize: 18),
                  overflow: TextOverflow.visible,
                  // Allow text to extend without clipping
                  softWrap: true, // Enable text wrapping
                ),
                Text(
                  model.dateTime?.substring(10,16) ?? '',
                  style: getMyLightTextStyle(
                      color: ColorManger.grey, fontSize: FontSize.s14),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget buildMyMessage(ChatModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Row(
      textDirection: TextDirection.rtl,
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(model.profileImage ?? ''),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          // Ensure the container takes only necessary width based on content
          child: Container(
            padding:
            const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration:const BoxDecoration(
              color: ColorManger.kPrimary,
              borderRadius: const BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.text ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  overflow: TextOverflow.visible,
                  // Allow text to extend without clipping
                  softWrap: true, // Enable text wrapping
                ),
                Text(
                  model.dateTime ?? '',
                  style: getMyLightTextStyle(
                      color: Colors.white, fontSize: FontSize.s14),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}