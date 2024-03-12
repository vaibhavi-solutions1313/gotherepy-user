import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/universalAppBar.dart';
import 'package:gotherepy/app/modules/health_assesment_page/views/quiz_type_view.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/health_assesment_page_controller.dart';
import 'health_score_page_view.dart';

class HealthAssessmentPageView extends GetView<HealthAssesmentPageController> {
  const HealthAssessmentPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HealthAssesmentPageController healthAssesmentPageController =Get.put(HealthAssesmentPageController());
    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Health Assesment',appBar: AppBar(),showBackButton: true),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.5, 1.0),
                  color: AppColors.whiteShadow,
                  spreadRadius: 0.5,
                  blurRadius: 1.0
                )
              ]
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Image.asset(AppImages().healthAssessment,height: 55,),
                    SizedBox(height: 30,),
                    GestureDetector(
                      onTap: (){
                        // Get.to(()=>const HealthScorePageView());
                        Get.to(()=>const QuizTypeView());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text14by500(text:'Take Test',fontSize: 20,color: AppColors.tealColor,),
                      ),
                    )
                ],)),
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text14by500(text:'Lifestyle Quiz',fontSize: 24,color: Colors.black,),
                      FooterTextWithCenterAligned(text: 'Take our lifestyle quiz to have deeper insight!', fontSize: 12,textAlign: TextAlign.start,)
                  ],),
                )),

              ],
            ),
          )
        ],
      ),
    );
  }
}
