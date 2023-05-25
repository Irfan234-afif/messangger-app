import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class RoomchatController extends GetxController {
  var chattextfocus = false.obs;

  late FocusNode focusnodechat;
  late TextEditingController chattext;
  late ScrollController scrollcontroll;

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getdatafriend(String friendemail) async {
    CollectionReference usersdb = db.collection('users');
    return await usersdb.doc(friendemail).get();
  }

  void deletemessage(String chatid, String id) async {
    CollectionReference chatsdb = db.collection('chats');
    Get.back();

    await chatsdb.doc(chatid).collection('chats').doc(id).delete();
  }

  Future<void> sendmessage(
      String msg, String chatid, String friendemail, String email) async {
    if (msg != "") {
      try {
        chattext.clear();
        var datenow = DateTime.now().toIso8601String();

        CollectionReference usersdb = db.collection('users');
        CollectionReference chatsdb = db.collection('chats');

        var uuidsendchat = Uuid().v4().substring(0, 13);
        await chatsdb.doc(chatid).collection('chats').doc(uuidsendchat).set({
          'time': datenow,
          'isRead': false,
          'message': msg,
          'pengirim': email,
          'penerima': friendemail,
        });
        final checkunread = await chatsdb
            .doc(chatid)
            .collection('chats')
            .where('penerima', isEqualTo: friendemail)
            .where('isRead', isEqualTo: false)
            .get();
        var totalUnread = checkunread.docs.length;
        await usersdb.doc(friendemail).collection('chats').doc(chatid).update({
          'total_unread': totalUnread,
        });

        scrollcontroll.jumpTo(scrollcontroll.position.maxScrollExtent);
      } catch (e) {
        print(e);
      }
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streammsg(
      String chatid, String email) {
    CollectionReference usersdb = db.collection('users');
    CollectionReference chatsdb = db.collection('chats');

    final unreadUser =
        usersdb.doc(email).collection('chats').doc(chatid).snapshots();

    unreadUser.forEach((element) {
      if (element.data()!['total_unread'] != 0) {
        usersdb.doc(email).collection('chats').doc(chatid).update({
          'total_unread': 0,
        });
      }
    });

    final unreadmsgchats = chatsdb
        .doc(chatid)
        .collection('chats')
        .where('isRead', isEqualTo: false)
        .where('penerima', isEqualTo: email)
        .snapshots();
    unreadmsgchats.forEach((element) {
      for (var element2 in element.docs) {
        chatsdb.doc(chatid).collection('chats').doc(element2.id).update({
          'isRead': true,
        });
      }
    });
    return chatsdb.doc(chatid).collection('chats').orderBy('time').snapshots();
  }

  @override
  void onInit() {
    focusnodechat = FocusNode();
    chattext = TextEditingController();
    scrollcontroll = ScrollController();
    super.onInit();
  }
}
