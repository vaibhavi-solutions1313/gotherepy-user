import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/modules/counselors_page/views/counselor_profile_view.dart';
import 'package:gotherepy/app/modules/counselors_page/views/live_counselor_view.dart';
import 'package:gotherepy/app/modules/counselors_page/views/slots_booking_page_view.dart';
import 'package:gotherepy/app/modules/wallet_page/views/wallet_page_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/counselors_page_controller.dart';

class CounselorsPageView extends GetView<CounselorsPageController> {
  const CounselorsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final CounselorsPageController counselorsTabController =Get.put(CounselorsPageController());
    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Our Live Counsillors', appBar: AppBar(),),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context,index){
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(1, 1),
                        blurRadius: 2,
                        spreadRadius: 3,
                        color: AppColors.lightGreyTextColor.withOpacity(0.5)
                    )
                  ]
              ),
              child: Column(
                children: [
                  Padding(
                     padding: EdgeInsets.only(left: 18.0,top: 18.0,right: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: CircularPercentIndicator(
                                    radius: 35.0,
                                    animation: true,
                                    animationDuration: 1200,
                                    linearGradient: const LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color(0xFF44C3D4),
                                        Color(0xFF44C3D4),
                                      ],
                                    ),
                                    lineWidth: 2.0,
                                    percent: 0.6,
                                    center:  InkWell(
                                      onTap: (){
                                        Get.to(()=>CounselorProfileView());
                                      },
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.red,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(140.0),
                                              child: Image.asset(AppImages.yogaImage))),
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    startAngle: 150,
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text14by400(text: 'Dr. Mira Desai'),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                                      child: IntrinsicHeight(
                                       child:
                                          Row(
                                            children: [
                                              Text16by400(text: 'Dentist',fontSize: 12,color: AppColors.lightGreyTextColor,),
                                              VerticalDivider(color: Colors.black,indent: 2.0,endIndent: 2.0),
                                              Text16by400(text: 'Dentist',fontSize: 12,color: AppColors.lightGreyTextColor,)

                                            ],
                                          ),

                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 6.0),
                                          child: Icon(Icons.thumb_up,color: AppColors.greenColor,size: 14,),
                                        ),
                                        Text('88%',style: TextStyle(color: AppColors.greyTextColor,fontSize: 12,fontWeight: FontWeight.w500),)
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          InkWell(
                            onTap: (){
                              Get.defaultDialog(
                                titlePadding: EdgeInsets.zero,
                                contentPadding: EdgeInsets.zero,
                                title: '',
                                middleText: '',
                                content: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                                  child: Column(
                                    children: [
                                      Icon(Icons.warning_amber_rounded,size: 56,color: AppColors.greyTextColor,),
                                      SizedBox(height: 10,),
                                      Text16by600(text: 'Alert',fontSize: 20,),
                                      SizedBox(height: 15,),
                                      FooterTextWithCenterAligned(text: 'You don’t have sufficient balance Minimum balance should for 15 min chat.', fontSize: 16,),
                                      SizedBox(height: 10,),
                                      CustomSolidButton(buttonText: 'Top Up', onClick: (){
                                        Get.to(()=>const WalletPageView());
                                      },fontSize: 16,)

                                    ],
                                  ),
                                )
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
                              decoration: BoxDecoration(
                                color: AppColors.bluishColor,
                                borderRadius: BorderRadius.circular(6.0)
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6.0),
                                    child: Icon(Icons.circle,color: AppColors.greenColor,size: 13,),
                                  ),
                                  Text('Live',style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.w600),)
                                ],
                              ),
                            ),
                          )
                          ],
                        ),

                        // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 6.0),
                    padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 4.0),
                    decoration: ShapeDecoration(shape: StadiumBorder(),
                        color: AppColors.containerColor
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text14by400(text: 'Min 30 min / ',color: AppColors.lightGreyTextColor),
                        Text14by400(text: 'Max 45 min',color: AppColors.lightGreyTextColor),
                      ],
                    ),
                  ),
                  ToggleSwitch(
                    radiusStyle: false,
                  dividerColor: Colors.white,
                    dividerMargin: 0.0,
                     minWidth: 190.0,
                    initialLabelIndex: 1,
                    cornerRadius: 16.0,
                    activeFgColor: Colors.white,
                    inactiveBgColor: AppColors.tealColor,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 4,
                    labels: const ['Book Slots', 'Chat Now', 'Go Live', 'Call Now'],
                    icons: const [Icons.video_camera_back_outlined, Icons.mark_unread_chat_alt_rounded,Icons.live_tv_sharp,Icons.wifi_calling_3_rounded,],
                    activeBgColors: const [[ AppColors.tealColor],[ AppColors.tealColor],[ AppColors.tealColor],[ AppColors.tealColor]],
                    onToggle: (index) {
                      if(index==0) {
                        // Get.to(()=>IntakeFormPageView(therapist: therapist,));
                        // Get.to(() => const SlotsBookingPageView());
                      }else if(index==1) {
                        // Get.to(() => const ChatPageView());
                      }else if(index==2) {
                        Get.to(() => const LiveCounselorView());
                      }else {
                        Get.to(() => LiveCounselorView());
                      }
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }
}
