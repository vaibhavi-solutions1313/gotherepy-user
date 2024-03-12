import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/text_styles.dart';

import '../../appWidgets/universalAppBar.dart';
import '../../app_constants/constants_appColors.dart';

class SubscriptionRelatedFaqsView extends GetView {
  const SubscriptionRelatedFaqsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var isVisible=false.obs;
    return Scaffold(
      appBar: CustomUniversalAppBar(
        title: 'Subscription Related FAQ’s',appBar: AppBar(),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
         padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 6.0),
        itemCount: 4,
        itemBuilder: (context,index){
          return Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: (){
                    isVisible.value=!isVisible.value;
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: AppColors.lightGreyTextColor.withOpacity(0.5)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text14by400(text: 'What if I miss a session?',)),
                        Icon(isVisible.value?Icons.keyboard_arrow_up_sharp:Icons.keyboard_arrow_down_sharp,
                          color: isVisible.value?AppColors.tealColor:AppColors.bluishColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isVisible.value,
                child:Container(
                  margin: EdgeInsets.symmetric(vertical:8.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: AppColors.lightGreyTextColor.withOpacity(0.2)
                  ),
                  child: Text14by400(text: 'If you miss a session without a 12 hours prior notice, you will be charged for that session. please note that our therapist earn by the hour and this fee is used to compensate them for the time that they coould have  utilized for another session.',
                  ),
                ),

              ),
            ],
          ));
        },
      ),
    );
  }
}
