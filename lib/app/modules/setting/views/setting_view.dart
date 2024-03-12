import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/text_styles.dart';
import 'package:gotherepy/app/app_constants/constants_appColors.dart';

import '../../../appWidgets/universalAppBar.dart';
import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SettingController settingController=Get.put(SettingController());
    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Settings', appBar: AppBar(),),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text16by600(text: 'Notifications',fontSize: 20,),
            SizedBox(height: 20,),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text14by400(text: 'Enable full screen notification',fontSize: 12,color: Colors.black,),
              trailing:  InkWell(
                borderRadius: BorderRadius.circular(20.0),
                onTap: (){
                  settingController.isNotificationOn.value=!settingController.isNotificationOn.value;
                },
                child: Obx(()=>AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.all(2.0),
                  height: 32,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: settingController.isNotificationOn.value?AppColors.greenColor:AppColors.greyTextColor,)
                  ),
                  child: Icon(Icons.circle,color: settingController.isNotificationOn.value?AppColors.greenColor:AppColors.greyTextColor,),
                  alignment: settingController.isNotificationOn.value?Alignment.centerRight:Alignment.centerLeft,

                )),
              )),
            ListTile(
                contentPadding: EdgeInsets.zero,
              title: Text14by400(text: 'Enable full screen notification',fontSize: 12,color: Colors.black,),
                trailing:  InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: (){
                    settingController.isFullscreenNotificationOn.value=!settingController.isFullscreenNotificationOn.value;
                  },
                  child: Obx(()=>AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    padding: EdgeInsets.all(2.0),
                    height: 32,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: settingController.isFullscreenNotificationOn.value?AppColors.greenColor:AppColors.greyTextColor,)
                    ),
                    child: Icon(Icons.circle,color: settingController.isFullscreenNotificationOn.value?AppColors.greenColor:AppColors.greyTextColor,),
                    alignment: settingController.isFullscreenNotificationOn.value?Alignment.centerRight:Alignment.centerLeft,

                  )),
                )),
            ListTile(
                contentPadding: EdgeInsets.zero,
              title: Text14by400(text: 'Enable push notification',fontSize: 12,color: Colors.black,),
                trailing:  InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: (){
                    settingController.isPushNotificationOn.value=!settingController.isPushNotificationOn.value;
                  },
                  child: Obx(()=>AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    padding: EdgeInsets.all(2.0),
                    height: 32,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: settingController.isPushNotificationOn.value?AppColors.greenColor:AppColors.greyTextColor,)
                    ),
                    child: Icon(Icons.circle,color: settingController.isPushNotificationOn.value?AppColors.greenColor:AppColors.greyTextColor,),
                    alignment: settingController.isPushNotificationOn.value?Alignment.centerRight:Alignment.centerLeft,

                  )),
                )),
          ],
        ),
      ),
    );
  }
}
