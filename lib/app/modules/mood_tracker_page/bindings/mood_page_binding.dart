import 'package:get/get.dart';
import 'package:gotherepy/app/modules/mood_tracker_page/controllers/mood_page_controller.dart';

class MoodPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MoodPageController>(
            () => MoodPageController()
    );
  }
}