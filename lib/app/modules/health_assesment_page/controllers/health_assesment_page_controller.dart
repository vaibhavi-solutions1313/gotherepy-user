import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/question_and_answer_option_model.dart';
import '../model/quiz_type_model.dart';
import '../providers/health_assesment_provider.dart';

class HealthAssesmentPageController extends GetxController with GetSingleTickerProviderStateMixin{
  //TODO: Implement HealthAssesmentPageController
  HealthAssesmentProvider provider=HealthAssesmentProvider();
   Rx<TabController>? tabController;
  var tab = 0.obs;

  var currentIndex = 1.obs;
  var serial = 0.obs;

  ///QuizType
  var isPressed=false.obs;
 Future<QuizType> getQuizes()async{
 return await provider.fetchQuizes().then((value) async{
   var decodedData=jsonDecode(await value.stream.bytesToString());
   return QuizType.fromJson(decodedData);
 });
}

///Questions
  Future<dynamic> getQuestions({required String questionsId})async{
   return await provider.fetchQuestions(questionsId: questionsId).then((value) async{
     var json = jsonDecode(await value.stream.bytesToString());
     tab.value=json['results'].length;
     tabController?.value=TabController(length: tab.value, vsync: this);
     return json;
   });
  }
  @override
  void onInit() {
    // provider.getQuestions().then((responseData) {
    //   tab.value=responseData.length;
    //   tabController=TabController(length: responseData.length, vsync: this);
    //   data=responseData;
    // });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
Future<void>saveAnswers()async {
    HealthAssesmentProvider().saveAnswer();
}

}
