import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/app/controllers/auth_controller.dart';
import 'package:messenger/app/modules/roomchat/controllers/roomchat_controller.dart';

class BottomNavbarRoomChat extends StatelessWidget {
  const BottomNavbarRoomChat({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RoomchatController>();
    final authcontroller = Get.find<AuthController>();
    return Obx(
      () => Container(
        padding: EdgeInsets.only(
          bottom: controller.chattextfocus.value
              ? 0
              : MediaQuery.of(context).padding.bottom,
        ),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Obx(
          () => Row(
            children: [
              if (!controller.chattextfocus.value)
                SizedBox(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert_rounded,
                          color: Colors.purple,
                          size: 27,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.purple,
                          size: 27,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.image_outlined,
                          color: Colors.purple,
                          size: 27,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.mic_rounded,
                          color: Colors.purple,
                          size: 27,
                        ),
                      ),
                    ],
                  ),
                )
              else
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.purple,
                    size: 25,
                  ),
                ),
              SizedBox(
                width: !controller.chattextfocus.value ? 130 : 270,
                height: 45,
                child: TextFormField(
                  focusNode: controller.focusnodechat,
                  controller: controller.chattext,
                  onTap: () {
                    Future.delayed(Duration(milliseconds: 800), () {
                      controller.chattextfocus.value = true;
                      controller.scrollcontroll.jumpTo(
                          controller.scrollcontroll.position.maxScrollExtent);
                    });
                  },
                  onEditingComplete: () {
                    controller.chattextfocus.value = false;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      top: 10,
                      left: 20,
                    ),
                    hintText: "Message",
                    filled: true,
                    fillColor: Colors.grey[300],
                    suffixIcon: Icon(
                      Icons.emoji_emotions_rounded,
                      color: Colors.purple,
                      size: 25,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.send_rounded,
                  color: Colors.purple,
                  size: 27,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
