import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/app_constants/constants_appColors.dart';
import 'package:gotherepy/app/modules/mood_tracker_page/controllers/calendar_controller.dart';
import 'package:gotherepy/app/modules/mood_tracker_page/controllers/mood_page_controller.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/app_images.dart';

class MoodTrackerPageView extends GetView<MoodPageController> {
  const MoodTrackerPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var moodController = Get.put(MoodPageController());
    var calendarController = Get.put(CalendarController());
    return Scaffold(
        appBar: CustomUniversalAppBar(
          title:'Mood Tracker',
          appBar: AppBar(),),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: Get.width,
                child: Image.asset(
                  AppImages.moodBanner,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'How Are You?',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.blackishTextColor
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.all(15.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greyColor676464,
                          blurRadius: 5.0,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 24,
                          color: AppColors.greyIcon,
                        ),
                        SizedBox(width: 8,),
                        Text('Today, 3 Sep', style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.blackish5E5E5E
                        )),
                        SizedBox(width: 3,),
                        InkWell(
                          onTap: (){
                            //TODO implement on Tap
                          },
                          child: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            size: 24,
                            color: AppColors.bluishColor,
                            weight: 5.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greyColor676464,
                          blurRadius: 5.0,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 24,
                          color: AppColors.greyIcon,
                        ),
                        SizedBox(width: 8,),
                        Text('12:00 PM', style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.blackish5E5E5E
                        )),
                        SizedBox(width: 3,),
                        InkWell(
                          onTap: (){
                            //TODO implement on Tap
                          },
                          child: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            size: 24,
                            color: AppColors.bluishColor,
                            weight: 5.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: moodController.mood_list.length,
                  itemBuilder: (context, index){
                    final item = moodController.mood_list[index];
                    return Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage(item['image']),
                          ),
                          SizedBox(height: 8,),
                          Image(
                            image: AssetImage(item['mood_name']),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: calendarController.goToPreviousMonth,
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.bluishColor,
                          )
                      ),
                      Obx(() => Text(
                          calendarController.formatMonthYear(
                              calendarController.selectedDate))
                      ),
                      IconButton(
                          onPressed: calendarController.goToNextMonth,
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.bluishColor,
                          )
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: calendarController.dayInitials.map(
                            (day) => Text(day)).toList(),
                  ),
                  Flexible(
                    child: Obx(() => GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      ),
                      itemBuilder: (context, index){
                        final day = calendarController.calendarDays[index ~/ 7][index % 7];
                        if(day == 0){
                          return Container();
                        }
                        final isToday = day == calendarController.selectedDate.day;
                        return InkWell(
                          onTap: () =>
                              calendarController.setSelectedDate(
                                DateTime(calendarController.selectedDate.year,
                                    calendarController.selectedDate.month,
                                    day),
                              ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isToday ? Colors.blueAccent : Colors.transparent,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Center(
                              child: Text(
                                day.toString(),
                                style: TextStyle(
                                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: calendarController.calendarDays.length * 7,
                    )),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}