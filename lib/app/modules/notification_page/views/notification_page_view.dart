import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/appButtons.dart';
import '../../../appWidgets/appBar.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/notification_page_controller.dart';

class NotificationPageView extends GetView<NotificationPageController> {
  const NotificationPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Notifications', appBar: AppBar(),),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text16by600(text: 'Notifications',fontSize: 20,),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 18.0),
                shrinkWrap: true,
                itemCount: 2,
                  itemBuilder: (context,index){
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text16by700(text: 'Welcome to Go Therapy',color: AppColors.bluishTextColor,),
                              Text14by400(text: 'Lorem ipsum dolor sit amet consectetur. Ultricies urna nunc maecenas vulputate sit a aliquam sit mauris. Quis porttitor dapibus nulla risus quam.',
                                fontSize: 12,color: AppColors.counsellingTextColor,),
                              SizedBox(height: 8,),
                              Text14by400(text: 'April 30, 2014 1:01 PM',fontSize: 10,color: AppColors.bluishTextColor,)
                            ],
                          ),
                        ),
                        Icon(Icons.delete,color: AppColors.appThemeColor,)
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],
                );
              }),
            ),
            CustomSolidButton(buttonText: 'Clear All', onClick: (){})
          ],
        ),
      ),
    );
  }
}
