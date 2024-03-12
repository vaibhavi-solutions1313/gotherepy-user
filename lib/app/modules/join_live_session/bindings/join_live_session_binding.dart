import 'package:get/get.dart';

import '../controllers/join_live_session_controller.dart';

class JoinLiveSessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JoinLiveSessionController>(
      () => JoinLiveSessionController(),
    );
  }
}
