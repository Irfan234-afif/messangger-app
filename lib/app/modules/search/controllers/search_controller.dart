import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/app/routes/app_pages.dart';
import 'package:uuid/uuid.dart';

class SearchControll extends GetxController {
  var queryAwal = [].obs;
  var tempSearch = [].obs;

  late TextEditingController searchcontrol;
  FocusNode focus = FocusNode();
  FirebaseFirestore db = FirebaseFirestore.instance;

  void search(String data, String email) async {
    if (data.isEmpty) {
      queryAwal.value = [];
      tempSearch.value = [];
    } else {
      if (queryAwal.length == 0 && data.length == 1) {
        CollectionReference usersdb = db.collection('users');
        final keyNameResult = await usersdb
            .where("keyname", isEqualTo: data.capitalizeFirst)
            .where('email', isNotEqualTo: email)
            .get();
        if (keyNameResult.docs.length > 0) {
          for (int i = 0; i < keyNameResult.docs.length; i++) {
            queryAwal.add(keyNameResult.docs[i].data() as Map<String, dynamic>);
          }
        }
      }
      String capitalized =
          data.substring(0, 1).toUpperCase() + data.substring(1);
      print(capitalized);
      if (queryAwal.isNotEmpty) {
        tempSearch.value = [];
        queryAwal.forEach((element) {
          String nama = element['nama'];
          if (nama.startsWith(capitalized)) {
            tempSearch.add(element);
          }
        });
      }
    }
    queryAwal.refresh();
    tempSearch.refresh();
  }

  void addnewConnection(String email, Map<String, dynamic> tempSearch) async {
    try {
      String? chatid;
      var friendemail = tempSearch['email'];
      var datenow = DateTime.now().toIso8601String();

      CollectionReference chatsdb = db.collection('chats');
      CollectionReference usersdb = db.collection('users');

      var newchatid = const Uuid().v4().substring(0, 16);
      final checkdoctouser = await usersdb.doc(email).collection('chats').get();
      if (checkdoctouser.docs.isNotEmpty) {
        //sudah pernah ada koneksi dengan friendemail
        final connectionWithFriend = await usersdb
            .doc(email)
            .collection('chats')
            .where('connection', isEqualTo: friendemail)
            .get();
        if (connectionWithFriend.docs.isEmpty) {
          //belum pernah ada koneksi dengan friendemail
          await usersdb.doc(email).collection('chats').doc(newchatid).set({
            'connection': friendemail,
            'lastime': datenow,
            'total_unread': 0,
          });
          //add to usersdb friendemail
          await usersdb
              .doc(friendemail)
              .collection('chats')
              .doc(newchatid)
              .set({
            'connection': email,
            'lastime': datenow,
            'total_unread': 0,
          });
          //add to chatsdb
          await chatsdb.doc(newchatid).set({
            'connection': [
              email,
              friendemail,
            ],
          });
          chatid = newchatid;
        } else {
          //sudah ada koneksi dengan friendemail
          print("data tidak di buat baru");
          final getChat =
              await chatsdb.doc(connectionWithFriend.docs[0].id).get();
          chatid = getChat.id;
        }
      } else {
        //belum pernah koneksi dengan siapapun
        await usersdb.doc(email).collection('chats').doc(newchatid).set({
          'connection': friendemail,
          'lastime': datenow,
          'total_unread': 0,
        });
        //add to usersdb friendemail
        await usersdb.doc(friendemail).collection('chats').doc(newchatid).set({
          'connection': email,
          'lastime': datenow,
          'total_unread': 0,
        });
        //add to chatsdb
        await chatsdb.doc(newchatid).set({
          'connection': [
            email,
            friendemail,
          ],
        });
      }
      Get.toNamed(Routes.ROOMCHAT, arguments: {
        'email': tempSearch['email'],
        'nama': tempSearch['nama'],
        'photourl': tempSearch['photourl'],
        'chatid': chatid,
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    searchcontrol = TextEditingController();
    super.onInit();
  }
}
