import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:messenger/app/controllers/auth_controller.dart';
import 'package:messenger/app/modules/login/views/login.dart';
import 'package:messenger/app/modules/login/views/signup.dart';
import 'package:messenger/app/routes/app_pages.dart';
import 'package:messenger/app/utils/default.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authcotroller = Get.find<AuthController>();
    final List<Widget> indexwidget = [
      LoginWidget(),
      SignUp(),
    ];
    var size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: backgroundcolordefault,
      body: PageView(
        controller: controller.controllerpage,
        children: [
          LoginWidget(),
          SignUp(),
        ],
      ),
    );
  }
}
