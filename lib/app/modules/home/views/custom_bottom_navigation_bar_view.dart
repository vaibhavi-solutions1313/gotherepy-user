
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/app_constants/app_images.dart';
import 'package:gotherepy/app/modules/home/controllers/home_controller.dart';
import '../../../app_constants/constants_appColors.dart';

class CustomBottomNavigationBarView extends GetView {
  const CustomBottomNavigationBarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find<HomeController>();
    return Obx(() => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (val) {
            controller.currentIndex.value = val;
            controller.jumpToPage(val);
          },
          selectedItemColor: AppColors.bluishColor,
          unselectedItemColor: AppColors.greyTextColor,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(icon: ImageIcon(AssetImage(AppImages.bottomNavBarCallIcon,),size: 24),label: 'Call'),
            BottomNavigationBarItem(icon: ImageIcon(AssetImage(AppImages.bottomNavBarExploreIcon,),size: 24),label: 'Explore'),
            BottomNavigationBarItem(icon: ImageIcon(AssetImage(AppImages.bottomNavBarChatIcon,),size: 24),label: 'Chat'),
            BottomNavigationBarItem(icon: ImageIcon(AssetImage(AppImages.bottomNavBarAccountIcon,),size: 24),label: 'Account'),
          ],
        ));
  }
}
