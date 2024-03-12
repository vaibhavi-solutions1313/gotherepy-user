import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:gotherepy/app/modules/health_assesment_page/model/question_and_answer_option_model.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/health_assesment_page_controller.dart';
import '../model/quiz_type_model.dart';
import 'health_score_page_view.dart';

class QuizTypeView extends GetView<HealthAssesmentPageController> {
  const QuizTypeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomUniversalAppBar(title: "Take Test", appBar: AppBar(),showBackButton: true),
      body: FutureBuilder<QuizType>(
          future: controller.getQuizes(),
          builder: (context,snapData){
            print(snapData);
            if(snapData.connectionState==ConnectionState.waiting){
              return SizedBox(
                  height: Get.height-100,
                  child: const Center(child: CircularProgressIndicator(),));
            }
            if(snapData.hasError){
              return const Center(child: Text('Something error'),);
            }
            if(snapData.hasData){
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapData.data!.results!.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  InkWell(
                        borderRadius: BorderRadius.circular(20.0),
                        onTap: (){
                          context.loaderOverlay.show();
                          controller.getQuestions(questionsId: snapData.data!.results![index].id.toString()).then((value){
                            context.loaderOverlay.hide();
                            num totalOption=0;
                            if(value['results'].isNotEmpty) {
                              for(var x in value['results']){
                                totalOption =totalOption+x['answers'].length;
                              }
                              print(totalOption.toString());
                              Get.to(() =>   HealthScorePageView(questionsWithOptions: QuestionAndAnswerOptionModel.fromJson(value), quizType: snapData.data!.results![index].name!, totalScore: totalOption,));
                            }else{
                              Fluttertoast.showToast(msg: value['msg'].toString().capitalize.toString());
                            }
                          });
                        },
                        child: Ink(
                          // margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: controller.isPressed.value? Colors.white54:Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                controller.isPressed.value?
                                BoxShadow(
                                    offset:Offset(-0.5, -0.5),
                                    color: AppColors.whiteShadow,
                                    spreadRadius: 1,
                                    blurRadius: 1
                                )
                                    :BoxShadow(
                                    offset:Offset(1, 1),
                                    color: AppColors.greyTextColor,
                                    spreadRadius: 0.6,
                                    blurRadius: 1.5
                                ),
                              ]
                          ),
                          child: ListTile(
                            // onTap: (){},
                            horizontalTitleGap: 8.0,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            leading: Image.network(snapData.data!.results![index].emoji!,height: 30,width: 30,
                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                                  return const Icon(Icons.image_not_supported,color: Colors.deepOrange,);
                                }),
                            title:Text16by400(text: '${snapData.data!.results![index].name}',fontSize: 14,color: AppColors.counsellingTextColor,),
                            trailing:const Icon(Icons.navigate_next),
                          ),
                        ),
                      ),
                    );
                  });
            }
            else {
              return const Center(
                child: Text('Something Error'),
              );
            }
          }),

    );
  }
}
