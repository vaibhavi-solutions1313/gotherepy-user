import 'package:get/get.dart';

import '../controllers/get_report_page_controller.dart';

class GetReportPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetReportPageController>(
      () => GetReportPageController(),
    );
  }
}
