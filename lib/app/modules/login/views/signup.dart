import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:messenger/app/controllers/auth_controller.dart';
import 'package:messenger/app/modules/login/controllers/login_controller.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    final authcontroller = Get.find<AuthController>();
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        children: [
          const Spacer(
            flex: 4,
          ),
          Image.asset('assets/icons/logo.png'),
          const Spacer(
            flex: 4,
          ),
          TextField(
            controller: controller.emailsignup,
            keyboardType: TextInputType.emailAddress,
            focusNode: controller.focusemail,
            decoration: const InputDecoration(
              hintText: "Phone number or email",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const Divider(
            thickness: 3,
          ),
          Obx(
            () => TextField(
              controller: controller.passwordsignup,
              keyboardType: TextInputType.visiblePassword,
              obscureText: controller.obscureText1.value,
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
                    controller.obscureText1.toggle();
                  },
                  icon: Icon(
                    Icons.remove_red_eye_sharp,
                    color: controller.obscureText.value
                        ? Colors.grey
                        : const Color(0xFF006AFF),
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => TextField(
              controller: controller.confirmpasswordsignup,
              keyboardType: TextInputType.visiblePassword,
              obscureText: controller.obscureText2.value,
              focusNode: controller.focuspasword,
              decoration: InputDecoration(
                hintText: "Confirm Password",
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.obscureText2.toggle();
                  },
                  icon: Icon(
                    Icons.remove_red_eye_sharp,
                    color: controller.obscureText.value
                        ? Colors.grey
                        : const Color(0xFF006AFF),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              authcontroller.signup(
                controller.emailsignup.text,
                controller.passwordsignup.text,
                controller.confirmpasswordsignup.text,
              );
              controller.focuspasword.unfocus();
              controller.focusemail.unfocus();
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(size.width, size.height * 0.07),
              backgroundColor: const Color(0xFF006AFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Obx(
              () => !authcontroller.isLoading.value
                  ? const Text(
                      "Sign In",
                    )
                  : const CircularProgressIndicator(),
            ),
          ),
          TextButton(
            onPressed: () {
              controller.controllerpage.animateToPage(
                0,
                duration: const Duration(milliseconds: 180),
                curve: Curves.fastOutSlowIn,
              );
            },
            child: const Text(
              "Log In",
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
