import 'package:flutter/material.dart';
import 'dart:math'as math;
import 'package:get/get.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/get_report_page_controller.dart';

class GetReportPageView extends GetView<GetReportPageController> {
  const GetReportPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GetReportPageController reportController=Get.put(GetReportPageController());
    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Get Report', appBar: AppBar(), showBackButton:true,),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TabBar(
                controller: reportController.reportTabController,
                tabs: [Text('MY Mood Report'),Text('My Sleep Report')]),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TabBarView(
                    controller: reportController.reportTabController,
                    children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text16by400(text: 'Your Report for Anxity andDepression.'),
                      SizedBox(height: 8.0,),
                      Text14by400(text: 'Dr. Sushant Shah, General Physician', color: AppColors.counsellingTextColor,),
                      Text14by400(text: 'Session on Fri, 12 march', color: AppColors.counsellingTextColor,),

                      CustomPaint(
                        child: Container(child: const Text("Hello World!"),),
                        painter: Arc(),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text16by400(text: 'Your Report for Anxity andDepression.'),
                      SizedBox(height: 8.0,),
                      Text14by400(text: 'Dr. Sushant Shah, General Physician', color: AppColors.counsellingTextColor,),
                      Text14by400(text: 'Session on Fri, 12 march', color: AppColors.counsellingTextColor,),

                      CustomPaint(
                        child: Container(child: const Text("Hello World!"),),
                        painter: Arc(),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Arc extends CustomPainter {

  double _degreeToRadians(num degree) {
    return (degree * math.pi) / 180.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTRB(0, 0, size.width, size.height * 2);
    double startAngle = _degreeToRadians(0);
    double sweepAngle = _degreeToRadians(180);
    const useCenter = false;
    Paint paint = Paint();
    paint.color = Colors.yellow;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}