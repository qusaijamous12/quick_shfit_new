import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quickshif/view/splash_screen/splash_screen.dart';

import 'controller/login_controller/login_controller.dart';
import 'controller/map_controller/map_controller.dart';
import 'controller/user_controller/user_controller.dart';
import 'firebase_options.dart';
import 'shared/resources/color_manger/color_manger.dart';
import 'test.dart';
import 'view/admin_screen_web/login_screen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: ColorManger.kPrimary
  ));

  Get.put(LoginController(),tag: 'login_controller');
  Get.put(UserController(),tag: 'user_controller');
  Get.put(MapController(),tag: 'map_controller');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
    );
  }
}
