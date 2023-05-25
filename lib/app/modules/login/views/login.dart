import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../controllers/login_controller.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.find<LoginController>();
    final authcontroller = Get.find<AuthController>();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        children: [
          Spacer(
            flex: 4,
          ),
          Image.asset('assets/icons/logo.png'),
          Spacer(
            flex: 4,
          ),
          TextField(
            controller: controller.emaillogin,
            keyboardType: TextInputType.emailAddress,
            focusNode: controller.focusemail,
            decoration: InputDecoration(
              hintText: "Phone number or email",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
          Divider(
            thickness: 3,
          ),
          Obx(
            () => TextField(
              controller: controller.passwordlogin,
              keyboardType: TextInputType.visiblePassword,
              obscureText: controller.obscureText.value,
              focusNode: controller.focuspasword,
              decoration: InputDecoration(
                hintText: "Password",
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.obscureText.toggle();
                  },
                  icon: Icon(
                    Icons.remove_red_eye_sharp,
                    color: controller.obscureText.value
                        ? Colors.grey
                        : Color(0xFF006AFF),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              authcontroller.loginemail(
                controller.emaillogin.text,
                controller.passwordlogin.text,
              );
              controller.focuspasword.unfocus();
              controller.focusemail.unfocus();
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(size.width, size.height * 0.07),
              backgroundColor: Color(0xFF006AFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Obx(
              () => !authcontroller.isLoading.value
                  ? Text(
                      "LOG IN",
                    )
                  : CircularProgressIndicator(),
            ),
          ),
          TextButton(
            onPressed: () {
              controller.controllerpage.animateToPage(
                1,
                duration: Duration(milliseconds: 180),
                curve: Curves.fastOutSlowIn,
              );
            },
            child: Text(
              "Create Account",
              style: TextStyle(
                color: Color(0xFF006AFF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
