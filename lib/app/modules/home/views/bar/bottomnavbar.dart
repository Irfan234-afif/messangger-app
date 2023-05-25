import 'package:flutter/material.dart'
    show
        Alignment,
        BuildContext,
        Card,
        Colors,
        Container,
        EdgeInsets,
        Icons,
        Key,
        MainAxisAlignment,
        MediaQuery,
        Row,
        StatelessWidget,
        Widget;
import 'package:flutter_feather_icons/flutter_feather_icons.dart'
    show FeatherIcons;
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';
import 'package:messenger/app/controllers/auth_controller.dart';
import 'package:messenger/app/modules/home/controllers/home_controller.dart';

import '../widget/itembottomnavbar.dart' show ItemBottomNavbar;

class BottomNavbarHome extends StatelessWidget {
  const BottomNavbarHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final size = MediaQuery.of(context).size;
    final controller = Get.find<HomeController>();
    print(MediaQuery.of(context).padding.bottom);
    return Card(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom == 0
              ? 10
              : MediaQuery.of(context).padding.bottom,
          top: 5,
        ),
        height: size.height * 0.11,
        width: size.width,
        alignment: Alignment.center,
        // color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(
              () => ItemBottomNavbar(
                icon: FeatherIcons.messageCircle,
                label: 'Chats',
                color:
                    controller.indexhome.value == 0 ? Colors.blue : Colors.grey,
                ontap: () {
                  if (controller.indexhome.value != 0) {
                    controller.indexhome.value = 0;
                  }
                },
              ),
            ),
            Obx(
              () => ItemBottomNavbar(
                icon: FeatherIcons.video,
                color:
                    controller.indexhome.value == 1 ? Colors.blue : Colors.grey,
                label: "Calls",
                ontap: () {
                  if (controller.indexhome.value != 1) {
                    controller.indexhome.value = 1;
                  }
                },
              ),
            ),
            Obx(
              () => ItemBottomNavbar(
                icon: Icons.group_rounded,
                color:
                    controller.indexhome.value == 2 ? Colors.blue : Colors.grey,
                label: "People",
                ontap: () {
                  if (controller.indexhome.value != 2) {
                    controller.indexhome.value = 2;
                  }
                },
              ),
            ),
            Obx(
              () => ItemBottomNavbar(
                icon: FeatherIcons.columns,
                size: 27,
                color:
                    controller.indexhome.value == 3 ? Colors.blue : Colors.grey,
                label: "Stories",
                ontap: () {
                  if (controller.indexhome.value != 3) {
                    controller.indexhome.value = 3;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
