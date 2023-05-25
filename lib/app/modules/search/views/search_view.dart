import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:messenger/app/controllers/auth_controller.dart';
import 'package:messenger/app/modules/search/controllers/search_controller.dart';

class SearchView extends GetView<SearchControll> {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authcontrol = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: TextField(
          controller: controller.searchcontrol,
          onChanged: (value) {
            controller.search(value, authcontrol.auth.currentUser!.email!);
            Future.delayed(Duration(milliseconds: 700), () {});
          },
          focusNode: controller.focus,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(),
            filled: true,
            fillColor: Color(0xFF000000).withOpacity(0.05),
            prefixIcon: Icon(Icons.search),
            hintText: "Search",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.tempSearch.isNotEmpty
            ? ListView.builder(
                itemCount: controller.tempSearch.length,
                itemBuilder: (context, index) {
                  print(controller.tempSearch);
                  print(index);
                  return ListTile(
                    onTap: () {
                      controller.addnewConnection(
                          authcontrol.auth.currentUser!.email!,
                          controller.tempSearch[index]);
                    },
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Color.fromARGB(66, 99, 98, 98),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: controller.tempSearch[index]["photourl"] ??
                            Icon(
                              Icons.person_outline_rounded,
                              size: 40,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                      ),
                    ),
                    title: Text(
                      controller.tempSearch[index]['nama'],
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      controller.tempSearch[index]['uid'],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  );
                },
              )
            : SizedBox(),
      ),
    );
  }
}
