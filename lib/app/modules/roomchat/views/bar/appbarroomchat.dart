import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:messenger/app/modules/roomchat/controllers/roomchat_controller.dart';

AppBar buildappbar({
  required String nama,
  String? photourl,
}) {
  final controller = Get.find<RoomchatController>();
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ),
    elevation: 0.3,
    backgroundColor: Colors.white,
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      splashRadius: 20,
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: Colors.purple,
      ),
    ),
    leadingWidth: 40,
    title: Row(
      children: [
        CircleAvatar(
          foregroundColor: Colors.purple,
          backgroundColor: Colors.purple,
          child: photourl == null
              ? Icon(
                  Icons.person,
                  color: Colors.white,
                )
              : Image.asset(photourl),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nama,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            Text(
              "Activate 13 min.....",
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 2,
              ),
            ),
          ],
        ),
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {},
        splashRadius: 10,
        icon: Icon(
          Icons.call,
          color: Colors.purple,
          size: 25,
        ),
      ),
      IconButton(
        onPressed: () {},
        splashRadius: 10,
        icon: Icon(
          Icons.videocam_rounded,
          color: Colors.purple,
          size: 32,
        ),
      ),
      IconButton(
        onPressed: () {
          controller.chattextfocus.value = false;
          controller.focusnodechat.unfocus();
        },
        splashRadius: 10,
        icon: Icon(
          Icons.info_rounded,
          color: Colors.purple,
          size: 30,
        ),
      ),
    ],
  );
}
