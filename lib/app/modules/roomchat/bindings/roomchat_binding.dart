import 'package:get/get.dart';

import '../controllers/roomchat_controller.dart';

class RoomchatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoomchatController>(
      () => RoomchatController(),
    );
  }
}
