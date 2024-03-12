import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/modules/wallet_page/controllers/wallet_page_controller.dart';
import 'package:gotherepy/app/modules/wallet_page/providers/wallet_provider.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../appWidgets/appButtons.dart';
import '../../appWidgets/text_styles.dart';
import '../../appWidgets/universalAppBar.dart';
import '../../app_constants/app_images.dart';
import '../../app_constants/constants_appColors.dart';
import '../../modules/counselors_page/views/counselor_profile_view.dart';
import '../../modules/counselors_page/views/live_counselor_view.dart';
import '../../modules/wallet_page/views/wallet_page_view.dart';

class YogaCounselorsBookingPageView extends GetView {
  const YogaCounselorsBookingPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Book a Yoga Counsillor',appBar: AppBar(),),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
              // padding: EdgeInsets.only(left: 18.0,top: 18.0,right: 18.0),
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
                                              child: Image.asset(AppImages.marriage))),
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    startAngle: 150,
                                    backgroundColor: Colors.transparent,
                                    footer: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 6.0),
                                          child: Icon(Icons.thumb_up,color: AppColors.greenColor,size: 14,),
                                        ),
                                        Text('88%',style: TextStyle(color: AppColors.greyTextColor,fontSize: 12,fontWeight: FontWeight.w500),)
                                      ],
                                    ),
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                                      child: Text16by400(text: '₹ 30 /mins',fontSize: 12,color: AppColors.lightGreyTextColor,),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: 6.0),
                                          padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 4.0),
                                          decoration: ShapeDecoration(shape: StadiumBorder(),
                                              color: AppColors.containerColor
                                          ),
                                          child: Row(
                                            children: [
                                              Text14by400(text: 'Min 30 min / ',color: AppColors.lightGreyTextColor),
                                              Text14by400(text: 'Max 45 min',color: AppColors.lightGreyTextColor),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor

                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      context.loaderOverlay.show();
                      WalletProvider().fetchWalletBalance().then((value)async {
                        context.loaderOverlay.hide();
                        var decodedData = jsonDecode(await value.stream.bytesToString());
                        if (decodedData['wallet_details'] != null) {
                        var walletBalance = num.parse(decodedData['wallet_details'][0]['amount'].toString());
                        if(walletBalance<(30*300)){
                          Get.defaultDialog(
                              titlePadding: EdgeInsets.zero,
                              contentPadding: EdgeInsets.zero,
                              title: '',
                              middleText: '',
                              content: Container(
                                padding: EdgeInsets.symmetric(horizontal: 18.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,size: 56,color: AppColors.greyTextColor,),
                                    SizedBox(height: 10,),
                                    Text16by600(text: 'Alert',fontSize: 20,),
                                    SizedBox(height: 15,),
                                    FooterTextWithCenterAligned(text: 'You don’t have sufficient balance Minimum balance should for 15 min chat.', fontSize: 16,),
                                    SizedBox(height: 10,),
                                    CustomSolidButton(buttonText: 'Top Up Wallet', onClick: (){
                                      Get.off(()=>const WalletPageView());
                                    },fontSize: 16,)
                                  ],
                                ),
                              )
                          );
                        }else{
                          Get.to(()=>const LiveCounselorView());
                        }
                        }else{
                          Get.defaultDialog(
                              titlePadding: EdgeInsets.zero,
                              contentPadding: EdgeInsets.zero,
                              title: '',
                              middleText: '',
                              content: Container(
                                padding: EdgeInsets.symmetric(horizontal: 18.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,size: 56,color: AppColors.greyTextColor,),
                                    SizedBox(height: 10,),
                                    Text16by600(text: 'Alert',fontSize: 20,),
                                    SizedBox(height: 15,),
                                    const FooterTextWithCenterAligned(text: 'You don’t have sufficient balance Minimum balance of Rs${30 * 300} should for 15 min chat.', fontSize: 16,),
                                    SizedBox(height: 10,),
                                    CustomSolidButton(buttonText: 'Top Up Wallet', onClick: (){
                                      Get.off(()=>const WalletPageView());
                                    },fontSize: 16,)
                                  ],
                                ),
                              )
                          );
                        }
                      });

                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
                      decoration: BoxDecoration(
                          color: AppColors.tealColor,
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0))
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: Icon(Icons.video_camera_back_outlined,size: 13,),
                          ),
                          Text('Video Call',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}


