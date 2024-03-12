import 'package:get/get.dart';

class SettingController extends GetxController {
  //TODO: Implement SettingController
var isNotificationOn=false.obs;
var isPushNotificationOn=false.obs;
var isFullscreenNotificationOn=false.obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
