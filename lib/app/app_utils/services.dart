import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../app_constants/constants_appColors.dart';

class Services extends GetxService {
  final box = GetStorage();

  SnackbarController getSnackMessage({String title='Message', String message="Something went wrong"}) {
    return Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14),
      ),
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 12),
      ),
      backgroundColor: Colors.blueAccent,
      backgroundGradient: LinearGradient(colors: [AppColors.bluishColor, AppColors.tealColor]),
      duration: Duration(seconds: 8),
      padding: EdgeInsets.all(16.0),
      borderRadius: 4.0,
      margin: EdgeInsets.zero,
      snackPosition: SnackPosition.TOP,
    );
  }
}
