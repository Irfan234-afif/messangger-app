import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:messenger/app/routes/app_pages.dart';

import './bar/appbar.dart';
import '../controllers/home_controller.dart';
import './bar/bottomnavbar.dart';
import './homeindex/indexchats.dart';
import './homeindex/indexcalls.dart';
import './homeindex/indexpeople.dart';
import './homeindex/indexstories.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<Widget> listwidget = [
      IndexChats(),
      IndexCalls(),
      IndexPeople(),
      IndexStories(),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildappbarhome(),
      drawer: Drawer(),
      body: Obx(
        () => AnimatedSwitcher(
          duration: Duration(milliseconds: 180),
          child: listwidget[controller.indexhome.value],
        ),
      ),
      floatingActionButton: Obx(() => controller.indexhome.value == 0
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => {Get.toNamed(Routes.SEARCH)},
            )
          : SizedBox()),
      bottomNavigationBar: const BottomNavbarHome(),
    );
  }
}
