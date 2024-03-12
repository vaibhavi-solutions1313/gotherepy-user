import 'package:get/get.dart';

import '../controllers/wallet_page_controller.dart';

class WalletPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletPageController>(
      () => WalletPageController(),
    );
  }
}
