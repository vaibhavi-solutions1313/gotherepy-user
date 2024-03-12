import 'package:banner_carousel/banner_carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/appBar.dart';
import 'package:gotherepy/app/appWidgets/appButtons.dart';
import 'package:gotherepy/app/appWidgets/text_styles.dart';
import 'package:gotherepy/app/modules/profile_page/views/doctor_profile_page_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../../views/views/blog_page_view.dart';
import '../../../views/views/intake_form_page_view.dart';
import '../../chat_page/views/chat_page_view.dart';
import '../../doctor_list_view/views/doctor_list_view_view.dart';
import '../../health_assesment_page/views/health_assesment_page_view.dart';
import '../../join_live_session/views/join_live_session_view.dart';
import '../../plan_and_pricing/views/my_plan_page_view.dart';
import '../../profile_page/views/profile_page_view.dart';
import '../../schedule_calls_page/views/schedule_calls_page_view.dart';
import '../controllers/home_controller.dart';
import 'activities_view.dart';
import 'custom_app_drawer_view.dart';
import 'custom_bottom_navigation_bar_view.dart';
import 'home_dashboard_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // HomeController controller = Get.put(HomeController());
    DateTime? currentBackPressTime;
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          Fluttertoast.showToast(msg: "Double tap to exit");
          return Future.value(false);
        }
        SystemNavigator.pop();
        return Future.value(true);
      },
      child: Scaffold(
        // userInfo.userData.value.results!.username??
        // appBar: CustomAppBar(title: 'Go Therapy', appBar: AppBar()),
        // drawer: const CustomAppDrawerView(),
        ///Container used for scaffold background image
        body: Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(AppImages.backgroundPngImage), repeat: ImageRepeat.repeat)),
          child: PageView(
            controller: controller.homePageController,
            onPageChanged: (val){
              controller.currentIndex.value=val;
            },
            children: [
              const HomeDashboardView(),
              DoctorListPageView(allTherapist: controller.therapists,showBackButton: false),
              const BlogPageView(),
              const ChatPageView(),
              const ProfilePageView(),
                // const ScheduleCallsPageView(),
              // DoctorListPageView(allTherapist: controller.therapists,appbarTitle: 'Chat with our experts'),
            ],
          )
        ),
        bottomNavigationBar: const CustomBottomNavigationBarView(),
      ),
    );
  }
}
