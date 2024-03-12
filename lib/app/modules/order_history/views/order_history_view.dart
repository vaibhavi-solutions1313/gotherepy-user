import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/appBar.dart';
import 'package:gotherepy/app/appWidgets/appButtons.dart';
import 'package:gotherepy/app/appWidgets/text_styles.dart';

import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/order_history_controller.dart';

class OrderHistoryView extends GetView<OrderHistoryController> {
  const OrderHistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: CustomUniversalAppBar(title: 'Order History', appBar: AppBar()),
      body: ListView(
        padding: EdgeInsets.all(14.0),
        children: [
          Text14by400(text: 'Calls With Doctors'),
          Expanded(child:
          ListView.builder(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context,index){
            return Container(
              height: 120,
              margin: EdgeInsets.symmetric(horizontal: 3.0,vertical: 8),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.scaffoldColor,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 3),
                    color: AppColors.lightGreyTextColor.withOpacity(0.5),
                    blurRadius: 1,
                    spreadRadius: 1
                  )
                ]
              ),
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(radius: 25,),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.thumb_up,color: AppColors.greenColor,size: 16,),
                              SizedBox(width: 4,),
                              Text14by400(text: '88%',color: AppColors.lightGreyTextColor,fontSize: 11,),
                            ],
                          )
                        ],
                      ),
                      SizedBox(width: 8,),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text16by600(text: 'Dr. Rahul',color: Colors.black,),
                          Text14by400(text: '14 December 2022',color: AppColors.lightGreyTextColor,fontSize: 12,),
                          Text14by400(text: 'Sessions 2',color: AppColors.lightGreyTextColor,fontSize: 12,),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle_rounded,color: AppColors.greenColor,size: 1,),
                          Text16by600(text: 'Paid',color: AppColors.greenColor,fontSize: 13,),
                        ],
                      ),
                      CustomSolidButton(buttonText: 'Download Report',fontSize: 12, onClick: (){})
                    ],
                  ),
                ],
              ),
            );
          })
          )
        ],
      ),
    );
  }
}
