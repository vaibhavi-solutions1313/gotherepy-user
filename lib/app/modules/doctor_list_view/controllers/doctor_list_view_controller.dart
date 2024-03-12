import 'package:get/get.dart';

import '../../../app_model/therapists.dart';
import '../providers/all_booked_therapists_provider.dart';

class DoctorListViewController extends GetxController {
  //TODO: Implement DoctorListViewController
  AllBookedTherapistsProvider allBookedTherapistsProvider=AllBookedTherapistsProvider();

  var doctorId=''.obs;
  var showAllDoctors=false.obs;

  Future<List<Results>> getAllBookedTherapists({required String userId})async{
    return await allBookedTherapistsProvider.fetchAllBookedTherapists(userId: userId);
  }
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
