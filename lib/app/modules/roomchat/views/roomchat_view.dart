import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:messenger/app/controllers/auth_controller.dart';
import 'package:messenger/app/modules/home/views/widget/itembottomnavbar.dart';
import 'package:messenger/app/modules/roomchat/views/Widget/itembottomsheet.dart';

import '../controllers/roomchat_controller.dart';
import './bar/appbarroomchat.dart';
import './bar/bottomnavbarroomchat.dart';
import './Widget/itemchatroom.dart';

class RoomchatView extends GetView<RoomchatController> {
  const RoomchatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authcontroll = Get.find<AuthController>();
    final size = MediaQuery.of(context).size;
    final chatid = Get.arguments['chatid'];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildappbar(
        nama: Get.arguments['nama'],
        photourl: Get.arguments['photourl'],
      ),
      /*ini futurebuilder karna untuk membaca data koneksi teman, tidak perlu 
      stream karna cukup memakan internet dan membuat perubahan tiap waktu dan itu jelek*/
      body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getdatafriend(Get.arguments['email']),
          builder: (context, snapshot1) {
            if (snapshot1.connectionState == ConnectionState.done) {
              //pembuatan variable data data agaar mudah di panggil
              var dataSnap1 = snapshot1.data!.data() as Map<String, dynamic>;
              var nama = dataSnap1['nama'];
              var photourl = dataSnap1['photourl'];
              //
              //
              //menggunakan singlechildscroll karna ada width setiap widget
              //jika menggunakan listview langsung kita tidak bisa mengatur width widget
              //
              return SingleChildScrollView(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                physics: ClampingScrollPhysics(),
                controller: controller.scrollcontroll,
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100 / 2),
                        color: Colors.purple,
                      ),
                      //
                      //kondisi ini digunakan untuk menjaga jaga ketika teman kita belum
                      //mempunyai photourl
                      //
                      child: photourl == null
                          ? Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 38,
                            )
                          : Image.asset(photourl),
                    ),
                    Text(
                      nama,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                    const Text(
                      "Facebook",
                      style: TextStyle(
                        color: Color.fromARGB(255, 76, 75, 75),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                    const Text(
                      "You're not friends on Facebook\nDifferent from your Faceook friend Li Ya",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.4,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        elevation: 0,
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "VIEW PROFILE",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    //
                    // steambuilder digunakan ketika streammsg
                    //
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: controller.streammsg(Get.arguments['chatid'],
                          authcontroll.auth.currentUser!.email!),
                      builder: (context, snapshot2) {
                        //
                        // ketika connectionState telah selesai maka akan melakukan perintah di bawah
                        //
                        if (snapshot2.connectionState ==
                            ConnectionState.active) {
                          //
                          //dibawah ini digunakan agar ketika masuk ke chatroom itu langsung ke scroll paling bawah
                          //
                          Timer(Duration.zero, () {
                            controller.scrollcontroll.jumpTo(controller
                                .scrollcontroll.position.maxScrollExtent);
                          });
                          //
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            itemCount: snapshot2.data!.docs.length,
                            itemBuilder: (context, index) {
                              //
                              //datachat all dari db
                              //
                              var datachat = snapshot2.data!.docs[index].data();
                              //
                              //get message from db
                              //
                              var msg = datachat['message'];
                              //
                              //pembuatan variable yang digunakan saat di panggil grouptime
                              //
                              var getgroupTime =
                                  snapshot2.data!.docs[index].data()['time'];
                              var monthTime = DateFormat.MMMd()
                                  .format(DateTime.parse(getgroupTime));
                              //ini di pisah karena tidak ada opsi yang menggunakan hhddmm
                              var hourTime = DateFormat.Hm()
                                  .format(DateTime.parse(getgroupTime));
                              var groupTime = '$monthTime AT $hourTime';

                              //logic isSender
                              var sender = datachat['pengirim'] ==
                                  authcontroll.auth.currentUser!.email;
                              //
                              //ini pembuatan group time ketika indexawal
                              // if (index == 0) {
                              //   return Column(
                              //     children: [
                              //       Center(
                              //         child: Text(
                              //           groupTime,
                              //           style: TextStyle(
                              //             color: Colors.grey[400],
                              //             fontSize: 12,
                              //           ),
                              //         ),
                              //       ),
                              //       ItemChatRoom(
                              //         onLongPress: () {
                              //           Get.bottomSheet(Container(
                              //             height: size.height * 0.15,
                              //             width: double.infinity,
                              //             color: Colors.white,
                              //             child: Row(
                              //               children: [
                              //                 Text(
                              //                   "item 1",
                              //                 ),
                              //                 Text(
                              //                   "item 2",
                              //                 ),
                              //                 Text(
                              //                   "item 3",
                              //                 ),
                              //               ],
                              //             ),
                              //           ));
                              //         },
                              //         sender: sender,
                              //         msg: msg,
                              //       ),
                              //     ],
                              //   );
                              // } else {
                              //   //untuk logic perbedaan bulan
                              //   var checkmontime = DateFormat.MMMd().format(
                              //       DateTime.parse(snapshot2
                              //           .data!.docs[index - 1]
                              //           .data()['time']));
                              //   //pembuatan kondisi
                              //   if (monthTime != checkmontime) {
                              //     return Column(
                              //       children: [
                              //         Center(
                              //           child: Text(
                              //             groupTime,
                              //             style: TextStyle(
                              //               color: Colors.grey[400],
                              //               fontSize: 12,
                              //             ),
                              //           ),
                              //         ),
                              //         ItemChatRoom(
                              //           onLongPress: () {
                              //             Get.bottomSheet(Container(
                              //               height: size.height * 0.15,
                              //               width: double.infinity,
                              //               color: Colors.white,
                              //               child: Row(
                              //                 children: [
                              //                   Text(
                              //                     "item 1",
                              //                   ),
                              //                   Text(
                              //                     "item 2",
                              //                   ),
                              //                   Text(
                              //                     "item 3",
                              //                   ),
                              //                 ],
                              //               ),
                              //             ));
                              //           },
                              //           sender: sender,
                              //           msg: msg,
                              //         ),
                              //       ],
                              //     );
                              //   } else {
                              //     //logic untuk group time
                              //     //pembuatan variable untuk pengetahuan index ke berapa
                              //     var checkgrouptime2 = DateTime.parse(snapshot2
                              //         .data!.docs[index - 1]
                              //         .data()['time']);
                              //     var checkgrouptime1 = DateTime.parse(snapshot2
                              //         .data!.docs[index]
                              //         .data()['time']);
                              //     //untuk mengetahui seberapa jauh perbedaan menit tiap index
                              //     var daf = checkgrouptime1
                              //         .difference(checkgrouptime2);
                              //     //pembuatan kondisi
                              //     if (daf.inMinutes > 10) {
                              //       return Column(
                              //         children: [
                              //           Center(
                              //             child: Text(
                              //               groupTime,
                              //               style: TextStyle(
                              //                 color: Colors.grey[400],
                              //                 fontSize: 12,
                              //               ),
                              //             ),
                              //           ),
                              //           ItemChatRoom(
                              //             onLongPress: () {
                              //               Get.bottomSheet(Container(
                              //                 height: size.height * 0.15,
                              //                 width: double.infinity,
                              //                 color: Colors.white,
                              //                 child: Row(
                              //                   children: [
                              //                     Text(
                              //                       "item 1",
                              //                     ),
                              //                     Text(
                              //                       "item 2",
                              //                     ),
                              //                     Text(
                              //                       "item 3",
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ));
                              //             },
                              //             sender: sender,
                              //             msg: msg,
                              //           ),
                              //         ],
                              //       );
                              //     }
                              //     //ini logic untuk perbedaan jam pasti dada group time
                              //     if (checkgrouptime1.hour >
                              //         checkgrouptime2.hour) {
                              //       return Column(
                              //         children: [
                              //           Center(
                              //             child: Text(
                              //               groupTime,
                              //               style: TextStyle(
                              //                 color: Colors.grey[400],
                              //                 fontSize: 12,
                              //               ),
                              //             ),
                              //           ),
                              //           ItemChatRoom(
                              //             onLongPress: () {
                              //               Get.bottomSheet(Container(
                              //                 height: size.height * 0.15,
                              //                 width: double.infinity,
                              //                 color: Colors.white,
                              //                 child: Row(
                              //                   children: [
                              //                     Text(
                              //                       "item 1",
                              //                     ),
                              //                     Text(
                              //                       "item 2",
                              //                     ),
                              //                     Text(
                              //                       "item 3",
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ));
                              //             },
                              //             sender: sender,
                              //             msg: msg,
                              //           ),
                              //         ],
                              //       );
                              //     }
                              //   }
                              //   return ItemChatRoom(
                              //     onLongPress: () {
                              //       Get.bottomSheet(Container(
                              //         height: size.height * 0.15,
                              //         width: double.infinity,
                              //         color: Colors.white,
                              //         child: Row(
                              //           children: [
                              //             Text(
                              //               "item 1",
                              //             ),
                              //             Text(
                              //               "item 2",
                              //             ),
                              //             Text(
                              //               "item 3",
                              //             ),
                              //           ],
                              //         ),
                              //       ));
                              //     },
                              //     sender: sender,
                              //     msg: msg,
                              //   );
                              // }
                              return ItemChatRoom(
                                onLongPress: () {
                                  Get.bottomSheet(
                                      Container(
                                        height: size.height * 0.13,
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 13,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ItemBottomSheet(
                                              icon: Icons.reply_rounded,
                                              color: Colors.blue[900]!,
                                              label: "Reply",
                                              size: 35,
                                              ontap: () {},
                                            ),
                                            ItemBottomSheet(
                                              icon: Icons.copy_rounded,
                                              color: Colors.blue[900]!,
                                              label: "Copy",
                                              size: 30,
                                              ontap: () {},
                                            ),
                                            ItemBottomSheet(
                                              icon: Icons.forward_rounded,
                                              color: Colors.blue[900]!,
                                              label: "Forward",
                                              size: 32,
                                              ontap: () {},
                                            ),
                                            ItemBottomSheet(
                                              icon: Icons.delete_rounded,
                                              color: Colors.blue[900]!,
                                              label: "Delete",
                                              size: 32,
                                              ontap: () {
                                                controller.deletemessage(
                                                    chatid,
                                                    snapshot2
                                                        .data!.docs[index].id);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)));
                                },
                                sender: sender,
                                msg: msg,
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      bottomNavigationBar: BottomNavbarRoomChat(
        onPressed: () {
          controller.sendmessage(
              controller.chattext.text,
              Get.arguments['chatid'],
              Get.arguments['email'],
              authcontroll.auth.currentUser!.email!);
        },
      ),
    );
  }
}
