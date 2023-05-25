import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  var obscureText = true.obs;
  var obscureText1 = true.obs;
  var obscureText2 = true.obs;
  var indexwidget = 0.obs;

  late TextEditingController emaillogin;
  late TextEditingController emailsignup;
  late TextEditingController passwordlogin;
  late TextEditingController passwordsignup;
  late TextEditingController confirmpasswordsignup;
  late FocusNode focusemail;
  late FocusNode focuspasword;
  late PageController controllerpage;

  @override
  void onInit() {
    emaillogin = TextEditingController();
    emailsignup = TextEditingController();
    passwordlogin = TextEditingController();
    passwordsignup = TextEditingController();
    confirmpasswordsignup = TextEditingController();
    focusemail = FocusNode();
    focuspasword = FocusNode();
    controllerpage = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    emaillogin.dispose();
    passwordlogin.dispose();
    super.onClose();
  }
}
