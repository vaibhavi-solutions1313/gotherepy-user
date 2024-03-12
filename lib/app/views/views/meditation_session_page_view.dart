import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/appButtons.dart';
import 'package:gotherepy/app/appWidgets/text_styles.dart';
import 'package:gotherepy/app/modules/home/controllers/home_controller.dart';
import 'package:gotherepy/app/views/views/providers/common_provider.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../appWidgets/universalAppBar.dart';
import '../../app_constants/app_images.dart';
import '../../app_constants/constants_appColors.dart';

class MeditationSessionPageView extends GetView {
  const MeditationSessionPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeController activityController=Get.find<HomeController>();
    var selectedMood=true.obs;
    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Mood Tracker', appBar: AppBar(),showBackButton: true),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: true,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0)
            ),
            child: Image.asset(AppImages.meditationBanner,fit: BoxFit.contain,),
          ),
          const Text('How are you?',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.0, 2.0),
                      // spreadRadius: 0.5,
                      blurRadius: 1.5,
                      color: AppColors.greyTextColor.withOpacity(0.5)
                    )
                  ]
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month,color: Colors.grey,),
                    SizedBox(width: 8.0,),
                    Text14by400(text:  DateFormat('yMMMMd').format(DateTime.now())),
                    Icon(Icons.keyboard_arrow_down_sharp,color: AppColors.tealColor,),
                  ],
                ),
              ),
              // Spacer(),
              // Container(
              //   padding: EdgeInsets.all(8.0),
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(8.0),
              //       boxShadow: [
              //         BoxShadow(
              //             offset: Offset(0.0, 2.0),
              //             // spreadRadius: 0.5,
              //             blurRadius: 1.5,
              //             color: AppColors.greyTextColor.withOpacity(0.5)
              //         )
              //       ]
              //   ),
              //   child: Row(
              //     children: [
              //       Icon(Icons.access_time,color: Colors.grey,),
              //       SizedBox(width: 8.0,),
              //       Text14by400(text:  DateFormat('yMMMMd').format(DateTime.now())),
              //       const Icon(Icons.keyboard_arrow_down_sharp,color: AppColors.tealColor,),
              //     ],
              //   ),
              // ),
            ],
          ),
          // SizedBox(height: 20,),
          FutureBuilder(
            future: CommonProvider().moodList(),
              builder: (context, snapData){
              if(snapData.connectionState==ConnectionState.waiting){
                return const LinearProgressIndicator(
                  minHeight: 180,
                );
              }
              if(snapData.hasError){
                return const Text('Unable to load at this moment');
              }
              if(snapData.hasData){
                return SizedBox(
                  height: 220,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 18),
                      scrollDirection: Axis.horizontal,
                      // physics:ScrollPhysics(),
                      itemCount: snapData.data.length,
                      // itemCount: 6,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              activityController.selectedIndex.value=index;
                              activityController.selectedMoodID.value=snapData.data[index]['id'].toString();
                              // activityController.selectedTime.value=index;
                              // selectedMood.value=!selectedMood.value;
                              // Get.to(()=>CounsellingPageView(title: '${controller.counsellingList[index]['counsellingType']}',));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Obx(() => ClipOval(
                                  child: AnimatedContainer(
                                    height: 140,
                                    width: 90,
                                    padding: activityController.selectedIndex.value==index?EdgeInsets.all(6.0):EdgeInsets.all(26.0),
                                    duration: const Duration(seconds: 1),
                                    decoration: BoxDecoration(
                                      color: activityController.selectedIndex.value==index?Colors.blue:Colors.transparent
                                    ),
                                    child: Image.network(snapData.data[index]['icon'].toString(),
                                        scale: activityController.selectedIndex.value==index?2:1,),
                                  ),
                                )),
                                Text14by400(text:snapData.data[index]['mood_type'].toString(),color: AppColors.greyColor676464, ),
                                const SizedBox(height: 8,),
                                //FooterTextWithCenterAligned(text: '${controller.counsellingList[index]['counsellingType']}'.replaceAll(' ', '\n'), fontSize: 12,),
                                //CustomSolidButton(buttonText: 'Book Now', onClick: (){},vPadding: 10,)
                                // Text16by400(text: '${controller.counsellingList[index]['counsellingType']}'.replaceAll(' ', '\n'),fontSize: 11,)
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }
              else {
                return const Text('No Data');
              }
          }),

          SfDateRangePicker(
            view: DateRangePickerView.month,
            monthViewSettings: const DateRangePickerMonthViewSettings(
              firstDayOfWeek: 7,
              weekNumberStyle: DateRangePickerWeekNumberStyle(textStyle: TextStyle(color: Colors.red)),
            ),
            selectionMode: DateRangePickerSelectionMode.multiRange,
          ),
          CustomSolidButton(buttonText: 'Submit', onClick: (){
            // CommonProvider().userMoodHistory();
            context.loaderOverlay.show();
            CommonProvider().updateUserMood(moodId: activityController.selectedMoodID.value, date:DateFormat('yMMMMd').format(DateTime.now()), time: '').then((val) async{
              context.loaderOverlay.hide();
              var decoded=jsonDecode(await val.stream.bytesToString());
               Fluttertoast.showToast(msg: 'Mood Updated',backgroundColor: Colors.black,textColor: Colors.white,gravity: ToastGravity.CENTER);
            });
          })
        ],
      ),
    );
  }

}
