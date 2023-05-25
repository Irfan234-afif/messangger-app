import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var indexhome = 0.obs;

  late TextEditingController searchcontroll;

  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamchats(String email) {
    final snapshot = db
        .collection('users')
        .doc(email)
        .collection('chats')
        .orderBy('lastime', descending: true)
        .snapshots();
    return snapshot;
  }

  Future<DocumentSnapshot<Object?>> getdatafriend(String friendemail) async {
    CollectionReference usersdb = db.collection('users');
    return await usersdb.doc(friendemail).get();
  }

  void unreadMSG(String email, String chatid) async {
    final getdata = await db
        .collection('users')
        .doc(email)
        .collection('chats')
        .doc(chatid)
        .get();
    if (getdata.data()!['total_unread'] != 0) {
      await db
          .collection('users')
          .doc(email)
          .collection('chats')
          .doc(chatid)
          .update({
        'total_unread': 0,
      });
    } else {}

    final getchatunread = await db
        .collection('chats')
        .doc(chatid)
        .collection('chats')
        .where('penerima', isEqualTo: email)
        .where('isRead', isEqualTo: false)
        .get();
    if (getchatunread.docs.isNotEmpty) {
      getchatunread.docs.forEach((element) {
        db
            .collection('chats')
            .doc(chatid)
            .collection('chats')
            .doc(element.id)
            .update({
          'isRead': true,
        });
      });
    }
  }

  @override
  void onInit() {
    searchcontroll = TextEditingController();
    super.onInit();
  }
}
