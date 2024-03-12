import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/text_styles.dart';
import 'package:gotherepy/app/modules/counselors_page/views/counselors_page_view.dart';
import 'package:gotherepy/app/modules/home/controllers/home_controller.dart';
import 'package:gotherepy/app/modules/journal_page/views/journal_page_view.dart';
import 'package:gotherepy/app/modules/mood_tracker_page/views/mood_page_view.dart';
import 'package:gotherepy/app/modules/schedule_calls_page/views/schedule_calls_page_view.dart';
import 'package:gotherepy/app/views/views/meditation_session_page_view.dart';
import 'package:gotherepy/app/views/views/yoga_counselors_booking_page_view.dart';

import '../../../app_constants/constants_appColors.dart';

class ActivitiesView extends GetView {
  const ActivitiesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeController controller=Get.find<HomeController>();
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IntrinsicHeight(
            child: Row(
              children: [
                VerticalDivider(
                  color: AppColors.tealColor,
                  thickness: 6,
                ),
                Text('My Activities',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700,),),
              ],
            ),
          ),
          const SizedBox(height: 12.0,),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
              itemCount: controller.activitiesList.length,
              itemBuilder: (context, index){
              return ListTile(
                onTap: (){
                  if(index==0){
                    Get.to(()=>const ScheduleCallsPageView());

                  }else if(index==1){
                    Get.to(()=>const JournalPageView());

                  }
                  // else if(index==2){
                  //   Get.to(()=>const YogaSessionView());
                  //
                  // }else if(index==3){
                  //   Get.to(()=>const MeditationSessionPageView());
                  //
                  // }
                  else if(index==2){
                    Get.to(()=>const MoodTrackerPageView());
                    // Get.to(()=>const NewMediationSession());

                  }else{
                    Fluttertoast.showToast(msg: 'This Feature is Only For Paid User',
                      gravity: ToastGravity.CENTER,
                    );
                  }
                },
                // enabled: index>0?false:true,
                enabled: true,
                textColor: AppColors.bluishColor,
                selectedTileColor: Colors.red,
                tileColor: AppColors.containerTileColor,
                // tileColor: index>0?AppColors.containerTileColor.withOpacity(0.5):AppColors.containerTileColor,
                minVerticalPadding: 6.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                leading: CircleAvatar(backgroundColor: Colors.white, child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(controller.activitiesList[index]['image'],fit: BoxFit.fitWidth,width: 28,),
                )),
                title: Text16by400( text: controller.activitiesList[index]['activityName'],color: AppColors.bluishColor),
                trailing: Image.asset(controller.activitiesList[index]['backgroundImage'],fit: BoxFit.fitHeight,width: 35,height: 35,),
              );
              },
              separatorBuilder: (context, index) {
            return SizedBox(height: 10,);
          }),
        ],
      ),
    );
  }
}
