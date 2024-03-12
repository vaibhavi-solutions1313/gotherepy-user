import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/modules/auth_page/bindings/auth_page_binding.dart';
import 'package:gotherepy/app/modules/auth_page/views/sign_up_view.dart';
import 'package:gotherepy/app/modules/chat_page/views/chat_page_view.dart';
import 'package:gotherepy/app/modules/counselors_page/views/counselors_page_view.dart';
import 'package:gotherepy/app/modules/counselors_page/views/live_counselor_view.dart';
import 'package:gotherepy/app/modules/doctor_list_view/views/doctor_list_view_view.dart';
import 'package:gotherepy/app/modules/home/views/home_dashboard_view.dart';
import 'package:gotherepy/app/modules/notification_page/views/notification_page_view.dart';
import 'package:gotherepy/app/modules/order_history/views/order_history_view.dart';
import 'package:gotherepy/app/modules/plan_and_pricing/views/plan_and_pricing_view.dart';
import 'package:gotherepy/main.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../../app_utils/services.dart';
import '../../auth_page/views/auth_page_view.dart';
import '../../get_report_page/views/get_report_page_view.dart';
import '../../help_desk_page/views/help_desk_page_view.dart';
import '../../journal_page/views/journal_page_view.dart';
import '../../profile_page/views/profile_page_view.dart';
import '../../profile_page/views/user_profile_view.dart';
import '../../setting/views/setting_view.dart';
import '../../wallet_page/views/wallet_page_view.dart';

class CustomAppDrawerView extends GetView {
  const CustomAppDrawerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print( userInfo.userData.value.results?.avatar.toString());
    List<Map<String, String>> drawerItems = [
      {'image': AppImages.customerChatSupport, 'itemName': 'Customer Support Chat'},
      {'image': AppImages.orderHistory, 'itemName': 'Order History'},
      {'image': AppImages.getReport, 'itemName': 'Get Report'},
      {'image': AppImages.chatWithConunsellers, 'itemName': 'Chat With Counsellors'},
      {'image': AppImages.myFollowing, 'itemName': 'My Following'},
      {'image': AppImages.signUpAsCounseller, 'itemName': 'Sign Up as Counsellor'},
      {'image': AppImages.settings, 'itemName': 'Settings'},
      {'image': AppImages.liveSession, 'itemName': 'Live Session'},
      {'image': AppImages.logOut, 'itemName': 'LOG OUT'},
    ].obs;
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  currentAccountPicture:  Stack(
                    children: [
                      Obx(() => CircleAvatar(
                        radius: 40,
                        backgroundImage:
                        NetworkImage(profilePageController.userImage.value),
                      )),
                      Positioned(
                        bottom: 1.0,
                        right: 0.0,
                        child: InkWell(
                          onTap: ()=>Get.to(()=>ProfilePageView()),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.tealColor,
                            child: Icon(
                              Icons.camera_alt_rounded,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  accountName:  Text16by400(
                      text: userInfo.userData.value.results?.username?? "User",
                      fontSize: 18,
                      maxLine: 2,
                    ),
                  accountEmail:  Text14by400(
                      text: userInfo.userData.value.results?.mobile??'+91 9999 999 1313',
                      color: AppColors.bluishColor,
                    ),

                //TODO Implementation
                // otherAccountsPictures: [
                //   InkWell(
                //   onTap:(){
                //     Get.to(()=>const WalletPageView());
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Image.asset(AppImages.wallet,color: Colors.teal,height: 22,width: 22,),
                //   ),
                // ),],
                //     child: Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Stack(
                //       children: [
                //         Obx(() => CircleAvatar(
                //           radius: 40,
                //           backgroundImage:
                //               NetworkImage(profilePageController.userImage.value),
                //         )),
                //         Positioned(
                //           bottom: 5.0,
                //           right: -0.0,
                //           child: InkWell(
                //             onTap: ()=>Get.to(()=>ProfilePageView()),
                //             child: CircleAvatar(
                //               radius: 15,
                //               backgroundColor: AppColors.tealColor,
                //               child: Icon(
                //                 Icons.edit,
                //                 size: 20,
                //                 color: Colors.white,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                //      Flexible(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text16by400(
                //             text:userInfo.userData.value.results?.firstName??"User",
                //             fontSize: 18,
                //             maxLine: 2,
                //           ),
                //           Text14by400(
                //             text: userInfo.userData.value.results?.mobile??'+91 9999 999 1313',
                //             color: AppColors.bluishColor,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // )
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    // scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: drawerItems.length,
                    itemBuilder: (context, index) {
                       if(index==8){
                        return ListTile(
                            onTap: () {
                              Get.find<Services>().box.erase().then((value) {
                                return Get.offAll(() => const AuthPageView(),binding: AuthPageBinding());
                              });
                            },
                            splashColor: AppColors.tealColor.withOpacity(0.2),
                            leading: Container(
                                height: 35,
                                width: 35,
                                padding: EdgeInsets.all(6.0),
                                child: Image.asset(drawerItems[index]['image']!)),
                            title: Text14by400(text: drawerItems[index]['itemName']!, color: Color(0xffDE0000),));
                      }else{
                        return ListTile(
                             onTap: () {
                               if(index < 3) {
                                //  if(index==0) {
                                //    Get.to(() => const PlanAndPricingView());
                                // }else
                                  if(index == 0){
                                   Get.to(() => const HelpDeskPageView());
                                 }else if(index == 1){
                                    Get.to(() => const OrderHistoryView());
                                  }else if(index == 2){
                                   Get.to(() => const GetReportPageView());
                                 }else{
                                   Get.to(() => const ChatPageView());
                                 }
                              }
                               else if(index >= 4 && index < 8) {
                                 if (index == 4) {
                                   // Get.to(() => const MyFollowingView());
                                 } else if (index == 5) {
                                   Get.to(() => const CounselorsPageView());
                                 }
                                 else if (index == 6) {
                                   Get.to(() => const SettingView());
                                 }
                                 else if (index == 7) {
                                   Get.to(() => const LiveCounselorView());
                                 }
                                 else {
                                   Get.to(() => const HomeDashboardView());
                                 }
                               }
                            },
                             splashColor: AppColors.tealColor.withOpacity(0.2),
                             leading: Container(
                                 height: 35,
                                 width: 35,
                                 padding: EdgeInsets.all(6.0),
                                 decoration: BoxDecoration(color: AppColors.containerColor, borderRadius: BorderRadius.circular(8.0)),
                                 child: Image.asset(drawerItems[index]['image']!)),
                             title: Text14by400(text: drawerItems[index]['itemName']!));
                       }
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                const Text14by400(text: 'Follow Us'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(bottom: 10.0),
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(color: Color(0xff334C8C), shape: BoxShape.circle),
                          child: Image.asset(AppImages.fbLogo,color: Colors.white)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            width: 30,
                            height: 30,
                            child: Image.asset(AppImages.instaLogo)
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(bottom: 10.0),
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(color: Color(0xff44C3D4), shape: BoxShape.circle),
                          child: Image.asset(AppImages.twitterLogo)),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
