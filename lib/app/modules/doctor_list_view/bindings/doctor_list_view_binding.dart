import 'package:get/get.dart';

import '../controllers/doctor_list_view_controller.dart';

class DoctorListViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorListViewController>(
      () => DoctorListViewController(),
    );
  }
}
