import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:messenger/app/controllers/auth_controller.dart';
import 'package:messenger/app/model/dataFriend_model.dart';
import 'package:messenger/app/model/user_model.dart';
import 'package:messenger/app/modules/home/controllers/home_controller.dart';
import 'package:messenger/app/routes/app_pages.dart';

import '../../../../utils/data.dart';
import '../widget/listilechat.dart';

class IndexChats extends StatelessWidget {
  const IndexChats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final authcontroller = Get.find<AuthController>();
    final size = MediaQuery.of(context).size;
    authcontroller.friendModel.value.listDataFriend = [];
    return ListView(
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      children: [
        Container(
          height: size.height * 0.06,
          width: size.width,
          margin: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: TextField(
            controller: controller.searchcontroll,
            onTap: () {
              Get.toNamed(Routes.SEARCH);
            },
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
        ),
        Container(
          height: 120,
          width: size.width,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) {
              return ListOnlineHorizon(
                index: index,
                urlImage: "https://randomuser.me/api/portraits/men/$index.jpg",
                name: listname[index],
              );
            },
          ),
        ),
        Obx(
          () => ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            itemCount: authcontroller.userModel.value.chat == null
                ? 0
                : authcontroller.userModel.value.chat!.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var userModel = authcontroller.userModel.value;
              var chat = userModel.chat![index];
              var friendemail = userModel.chat?[index].connection;
              if (friendemail == null) {
                return SizedBox();
              }
              return FutureBuilder<DocumentSnapshot<Object?>>(
                  future: controller.getdatafriend(friendemail),
                  builder: (context, snapshotfriend) {
                    if (snapshotfriend.connectionState ==
                        ConnectionState.done) {
                      var datafriend =
                          snapshotfriend.data!.data() as Map<String, dynamic>;
                      authcontroller.friendModel.value.listDataFriend
                          ?.add(DataFriend.fromJson(datafriend));

                      return ListTileItemChat(
                        ontap: () {
                          Get.toNamed(Routes.ROOMCHAT, arguments: {
                            'email': datafriend['email'],
                            'nama': datafriend['nama'],
                            'photourl': datafriend['photourl'],
                            'chatid': chat.uid!,
                          });
                          controller.unreadMSG(userModel.email!, chat.uid!);
                        },
                        index: index,
                        title: datafriend['nama'],
                        subtitle: "You: Halo",
                        time: "09:40 AM",
                        urlimage: datafriend['photourl'],
                        totalUnread: chat.totalUnread.toString(),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            },
          ),
        )
      ],
    );
    // }
    // return Center(
    //   child: CircularProgressIndicator(),
    // );
  }
}

class ListOnlineHorizon extends StatelessWidget {
  const ListOnlineHorizon({
    Key? key,
    required this.index,
    required this.urlImage,
    required this.name,
  }) : super(key: key);

  final int index;
  final String urlImage, name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          margin: index == 5 ? EdgeInsets.zero : EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: Color(0xFF000000).withOpacity(0.05),
            borderRadius: BorderRadius.circular(70 / 2),
            image: DecorationImage(
              image: NetworkImage(urlImage),
            ),
          ),
          child: Align(
            alignment: Alignment(0.9, 0.9),
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Color(0xFF5AD439),
                borderRadius: BorderRadius.circular(25 / 2),
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
              ),
            ),
          ),
        ),
        Text(
          name,
          style: TextStyle(
            color: Colors.black.withOpacity(0.35),
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1.9,
          ),
        ),
      ],
    );
  }
}
