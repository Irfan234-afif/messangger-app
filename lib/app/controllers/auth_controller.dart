import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:messenger/app/model/dataFriend_model.dart';
import 'package:messenger/app/model/user_model.dart';
import 'package:messenger/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  final box = GetStorage();

  //model
  var userModel = UserModel().obs;
  var friendModel = ListDataFriend().obs;

  var isLoading = false.obs;

  Stream<User?> get authstate => auth.authStateChanges();

  Stream dataUser(String? email) async* {
    if (email == null) {
      return;
    } else {
      final docUser = db.collection('users').doc(email).snapshots();
      // print(userModel.value.email == docUser.data()!['email']);
      docUser.forEach((element) {
        if (element.exists) {
          var data = element.data();

          if (!userModel.value.checkStream(data!)) {
            userModel.value = UserModel.fromJson(data);
            userModel.refresh();
            box.write('user', userModel.toJson());
          }
        }
      });
    }
  }

  Stream streamChatUser(String? email) async* {
    if (email == null) {
      return;
    } else {
      final stream = db
          .collection('users')
          .doc(email)
          .collection('chats')
          .orderBy('lastime', descending: true)
          .snapshots();
      stream.forEach((element) {
        List<Chat>? streamChat = [];
        // print(element.)
        if (element.docs.isNotEmpty) {
          for (var chat in element.docs) {
            streamChat.add(
              Chat(
                connection: chat.data()['connection'],
                lastime: chat.data()['lastime'],
                totalUnread: chat.data()['total_unread'],
                uid: chat.id,
              ),
            );
          }
          if (!userModel.value.chatbool(streamChat)) {
            userModel.value.chat = streamChat;
            userModel.refresh();
            box.write('user', userModel.toJson());
          }
        }
      });
    }
  }

  void loginemail(String email, String password) async {
    if (email.isNotEmpty || password.isNotEmpty) {
      if (password.length < 8) {
        Get.defaultDialog(
          title: 'Kesalahan',
          middleText: 'Password minimal 8 karakter',
        );
      } else if (!GetUtils.isEmail(email)) {
        Get.defaultDialog(
          title: "Kesalahan",
          middleText: 'Email tidak valid',
        );
      } else {
        try {
          isLoading.value = true;
          final credential = await auth.signInWithEmailAndPassword(
              email: email, password: password);
          CollectionReference collection = db.collection('users');
          //check account in db
          var docEmail = collection.doc(auth.currentUser!.email);
          var datainDB = await docEmail.get();
          //creating name
          var deleting = email.indexOf('@gmail.com');
          var nama = email.substring(0, deleting);
          if (auth.currentUser!.displayName == null) {
            auth.currentUser!.updateDisplayName(nama);
          }
          // if account not exist in db
          final toJson = {
            "nama": nama.capitalizeFirst,
            "email": email,
            "uid": auth.currentUser!.uid,
            "keyname": nama.substring(0, 1).capitalize,
            "photourl": auth.currentUser!.photoURL,
            "creationtime":
                credential.user!.metadata.creationTime!.toIso8601String(),
            "lastsignin":
                credential.user!.metadata.lastSignInTime!.toIso8601String(),
            "updatetime": DateTime.now().toIso8601String(),
          };

          if (datainDB.data() == null) {
            // print(userModel.toJson());
            //send to db
            await collection.doc(auth.currentUser!.email).set(
                  toJson,
                );
            userModel.value = UserModel.fromJson(toJson);
            userModel.refresh();
            box.write('user', userModel.toJson());
          } else {
            await collection.doc(email).update({
              'lastsignin':
                  credential.user!.metadata.lastSignInTime!.toIso8601String(),
              "updatetime": DateTime.now().toIso8601String(),
            });
            final docdb = await collection.doc(email).get();
            userModel.value =
                UserModel.fromJson(docdb.data() as Map<String, dynamic>);
            userModel.refresh();
            final getChatCol = await docEmail
                .collection('chats')
                .orderBy('lastime', descending: true)
                .get();
            for (var element in getChatCol.docs) {
              var data = element.data();
              var connection = data['connection'];
              var lastime = data['lastime'];
              var totalUnread = data['total_unread'];
              userModel.value.chat?.add(
                Chat(
                  connection: connection,
                  lastime: lastime,
                  totalUnread: totalUnread,
                  uid: element.id,
                ),
              );
            }

            box.write('user', userModel.toJson());
          }
          isLoading.value = false;
          Future.delayed(
            Duration(milliseconds: 900),
            () => Get.offAllNamed(Routes.HOME),
          );
        } on FirebaseAuthException catch (e) {
          isLoading.value = false;
          if (e.code == 'user-not-found') {
            Get.defaultDialog(
              title: "Kesalahan",
              middleText: "User tidak di temukan",
            );
            print('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            Get.defaultDialog(
              title: "Kesalahan",
              middleText: "Password salah",
            );
            print('Wrong password provided for that user.');
          }
        }
      }
    } else {
      Get.defaultDialog(
        title: 'Kesalahan',
        middleText: 'Email dan password harus di isi',
      );
    }
  }

  void signup(String email, String password, String confirmpassword) async {
    isLoading.value = true;
    if (email.isEmpty || password.isEmpty || confirmpassword.isEmpty) {
      isLoading.value = false;
      Get.defaultDialog(
        title: 'Kesalahan',
        middleText: 'Email, Password, dan ConfirmPassword harus di isi',
      );
    } else if (!GetUtils.isEmail(email)) {
      isLoading.value = false;

      Get.defaultDialog(
        title: 'Kesalahan',
        middleText: 'Email tidak valid',
      );
    } else if (password != confirmpassword) {
      isLoading.value = false;

      Get.defaultDialog(
        title: 'Kesalahan',
        middleText: 'Password tidak sama',
      );
    } else if (password.length < 8) {
      isLoading.value = false;

      Get.defaultDialog(
        title: 'Kesalahan',
        middleText: 'Password minimal 8 karakter',
      );
    } else {
      try {
        final credential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        CollectionReference collection = db.collection('users');
        var deleting = email.indexOf('@gmail.com');
        var nama = email.substring(0, deleting);
        if (auth.currentUser!.displayName == null) {
          auth.currentUser!.updateDisplayName(nama);
        }

        final toJson = {
          "nama": nama.capitalizeFirst,
          "email": email,
          "uid": auth.currentUser!.uid,
          "keyname": nama.substring(0, 1).capitalize,
          "photourl": auth.currentUser!.photoURL,
          "creationtime":
              credential.user!.metadata.creationTime!.toIso8601String(),
          "lastsignin":
              credential.user!.metadata.lastSignInTime!.toIso8601String(),
          "updatetime": DateTime.now().toIso8601String(),
        };
        await collection.doc(email).set(toJson);
        userModel.value = UserModel.fromJson(toJson);
        isLoading.value = false;
        Get.offAllNamed(Routes.HOME);
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;

        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        isLoading.value = false;
        print(e);
      }
    }
  }

  Future<void> initialize() async {
    final dataFromStorage = box.read('user');
    userModel.value = UserModel.fromJson(dataFromStorage);
  }

  void logout() async {
    box.remove('user');
    userModel.value = UserModel();
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
