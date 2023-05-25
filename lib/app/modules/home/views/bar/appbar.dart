import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:messenger/app/controllers/auth_controller.dart';
import 'package:messenger/app/modules/home/controllers/home_controller.dart';

AppBar buildappbarhome() {
  final authcontroller = Get.find<AuthController>();
  List<String> leadingtext = [
    'Chats',
    'Calls',
    'People',
    'Stories',
  ];
  List actionicon1 = [
    Icons.camera_alt_rounded,
    Icons.call,
    Icons.contacts_rounded,
    Icons.add_box_rounded
  ];
  List actionicon2 = [
    Icons.new_label_rounded,
    Icons.videocam_rounded,
    Icons.notifications_on_rounded,
  ];
  final controller = Get.find<HomeController>();
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ),
    title: Obx(
      () => Text(
        leadingtext[controller.indexhome.value],
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
      ),
    ),
    leadingWidth: 55,
    centerTitle: false,
    leading: Builder(builder: (context) {
      return InkWell(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        splashColor: Colors.transparent,
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: Container(
          margin: EdgeInsets.only(left: 10, bottom: 5, top: 5),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 235, 235, 235),
            borderRadius: BorderRadius.circular(80 / 2),
          ),
          child: Icon(FeatherIcons.menu, color: Colors.black),
        ),
      );
    }),
    actions: [
      Obx(
        () => controller.indexhome.value != 3
            ? Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    authcontroller.logout();
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 235, 235, 235),
                      borderRadius: BorderRadius.circular(100 / 2),
                    ),
                    child: Obx(
                      () => Icon(
                        actionicon1[controller.indexhome.value],
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox(),
      ),
      Obx(
        () => controller.indexhome.value != 3
            ? controller.indexhome.value != 2
                ? Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 235, 235, 235),
                          borderRadius: BorderRadius.circular(55 / 2),
                        ),
                        child: Obx(
                          () => Icon(
                            actionicon2[controller.indexhome.value],
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    width: 15,
                  )
            : SizedBox(),
      ),
    ],
  );
}
