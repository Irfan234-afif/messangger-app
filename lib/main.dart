import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:messenger/app/controllers/auth_controller.dart';
import 'package:messenger/firebase_options.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();
  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  // print('User granted permission: ${settings.authorizationStatus}');
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authcontroller = Get.put(AuthController());
    return StreamBuilder<User?>(
      stream: authcontroller.authstate,
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.active) {
        return StreamBuilder(
            stream: authcontroller.dataUser(snapshot.data?.email),
            builder: (context, snapshot2) {
              return StreamBuilder(
                  stream: authcontroller.streamChatUser(snapshot.data?.email),
                  builder: (context, snapshot) {
                    return GetMaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: "Application",
                      initialRoute:
                          // Routes.SEARCH,
                          snapshot.data != null
                              ? AppPages.INITIAL
                              : Routes.LOGIN,
                      getPages: AppPages.routes,
                    );
                  });
            });
        // }
        // return const Center(
        //   child: CircularProgressIndicator(),
        // );
      },
    );
  }
}
