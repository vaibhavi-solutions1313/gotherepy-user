import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/appButtons.dart';
import 'package:gotherepy/app/appWidgets/text_styles.dart';
import 'package:http/http.dart'as http;
import 'package:loader_overlay/loader_overlay.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../../app_constants/constants_end_points.dart';
import '../../../views/views/health_score_view_view.dart';
import '../controllers/health_assesment_page_controller.dart';
import '../model/question_and_answer_option_model.dart';

class HealthScorePageView extends StatefulWidget {
  final QuestionAndAnswerOptionModel questionsWithOptions;
  final String quizType;
  final num totalScore;
  const HealthScorePageView({super.key, required this.questionsWithOptions, required this.quizType, required this.totalScore});

  @override
  State<HealthScorePageView> createState() => _HealthScorePageViewState();
}

class _HealthScorePageViewState extends State<HealthScorePageView>  with SingleTickerProviderStateMixin {
  var scoreController = Get.find<HealthAssesmentPageController>();
  TabController? newTabController;
  List<Map> selectedOptions = [];

  void _handleTabChange() {
    scoreController.currentIndex.value=newTabController!.index+1;
    selectedOptions.removeWhere((element) => element['questionIndex'] == scoreController.currentIndex.value);
    selectedOptions.add({
      "questionIndex" : scoreController.currentIndex.value,
      "optionIndex": scoreController.serial.value
    });
    scoreController.serial.value = 0;
    // You can add your logic here based on the selected tab index
  }

  Future<http.StreamedResponse> submitTherapyForm({required List<int> selectedAnswers}) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer ${EndPoints.accessToken}'};
    var request = http.Request('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/submit-quiz'));
    request.body = json.encode({
      "options": selectedAnswers,
      "quiz_type": widget.quizType
    });
    print(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }



  @override
  void initState() {
    newTabController = TabController(length: scoreController.tab.value, vsync: this);
    scoreController.currentIndex.value = 1;
    newTabController!.addListener(_handleTabChange);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomUniversalAppBar(
        title: 'Health Scores',
        showBackButton: true,
        appBar: AppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => scoreController.tab.value > 0
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
                TextSpan(
                    text: '${scoreController.currentIndex.value}/',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.teal),
                    children: [
                      TextSpan(
                        text: scoreController.tab.value.toString().padLeft(2, '0'),
                        style: TextStyle(color: Colors.black),
                      ),
                    ])),
            TabBar(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                isScrollable: false,
                controller: newTabController,
                dividerColor: AppColors.tealColor,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: List.generate(
                  scoreController.tab.value,
                      (index) => Container(
                    height: 5.0,
                    width: 25.0,
                  ),
                )),
            Expanded(
              child: Stack(
                children: [
                  TabBarView(
                    // physics: NeverScro
                    // llableScrollPhysics(),
                      controller: newTabController,
                      children: List.generate(
                        scoreController.tab.value,
                            (index) => ListView(
                              children: [
                                Text14by500(
                                  text: widget.questionsWithOptions.results![index].question!.question.toString(),
                                  fontSize: 20,
                                ),
                                ...List.generate(
                                    widget.questionsWithOptions.results![index].answers!.length,
                                        (optionIndex) => BorderButton(
                                      buttonText: widget.questionsWithOptions.results![index].answers![optionIndex].answer.toString(),
                                      onClick: () {
                                        scoreController.serial.value = optionIndex;
                                      },
                                      textColor: scoreController.serial.value == optionIndex ? AppColors.tealColor : AppColors.greyColor676464 ,
                                      borderColor: scoreController.serial.value == optionIndex ? AppColors.tealColor  : AppColors.greyColor676464,
                                    )),
                                SizedBox(height: 100,)
                              ],
                            ),
                      )),
                  Positioned(
                    width: Get.width-31,
                    bottom: 10.0,
                    child: CustomSolidButton(
                      buttonText: widget.questionsWithOptions.results!.length==scoreController.currentIndex.value?'Save':'Save & Next',
                      onClick: () {
                        if(widget.questionsWithOptions.results!.length==scoreController.currentIndex.value){
                          try{
                            context.loaderOverlay.show();
                            print('==================last==================');
                            selectedOptions.add({
                              "questionIndex" : scoreController.currentIndex.value,
                              "optionIndex": scoreController.serial.value+1
                            });
                            List<int> options = [];
                            selectedOptions.forEach((element) {
                              options.add(element['optionIndex']);
                            });
                            print(selectedOptions);
                            submitTherapyForm(selectedAnswers: options).then((value)async {
                              context.loaderOverlay.hide();
                              var data= jsonDecode(await value.stream.bytesToString());
                              print(data.toString());
                              if(data['status']==true) {
                                selectedOptions.clear();
                                Get.to(() =>  HealthScoreViewView(data: data, totalScore: widget.totalScore,), fullscreenDialog: true);
                              }else{
                                Fluttertoast.showToast(msg: data['message']);
                              }
                            });
                          }catch (e){
                            context.loaderOverlay.hide();
                          }
                        }else{
                          scoreController.currentIndex.value=newTabController!.index+1;
                          selectedOptions.removeWhere((element) => element['questionIndex'] == scoreController.currentIndex.value);
                          selectedOptions.add({
                            "questionIndex" : scoreController.currentIndex.value,
                            "optionIndex": scoreController.serial.value+1
                          });
                          scoreController.serial.value = 0;
                          newTabController!.animateTo(newTabController!.index+1);
                        }



                        // scoreController.tabController!.value.animateTo(scoreController.currentIndex.value);
                        // scoreController.saveAnswers().whenComplete(() {
                        //  Get.to(()=> const DailyAffirmationView());
                        //   });
                        // scoreController.tabController.animateTo(2);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        )
            : Center(child: const CircularProgressIndicator())
        ),
      ),
    );
  }
}



// class HealthScorePageView extends GetView  {
//   // final QuestionAndAnswerOptionModel questionsWithOptions;
//   // final Rx<TabController>? newTabController;
//   const HealthScorePageView( {Key? key, }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     var scoreController = Get.find<HealthAssesmentPageController>();
//     TabController newTabController;
//     return Scaffold(
//       appBar: CustomUniversalAppBar(
//         title: 'Health Score',
//         appBar: AppBar(),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Obx(() => scoreController.tab.value > 0
//             ? Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text.rich(
//                       TextSpan(
//                       text: '${scoreController.tabController!.value.index}/',
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.teal),
//                       children: [
//                         TextSpan(
//                           text: scoreController.tab.value.toString().padLeft(2, '0'),
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ])),
//                   TabBar(
//                       padding: EdgeInsets.symmetric(vertical: 16.0),
//                       isScrollable: false,
//                       controller: newTabController!.value,
//                       dividerColor: AppColors.tealColor,
//                       indicatorSize: TabBarIndicatorSize.tab,
//                       tabs: List.generate(
//                         scoreController.tab.value,
//                         (index) => Container(
//                           height: 5.0,
//                           width: 25.0,
//                         ),
//                       )),
//                   Expanded(
//                     child: TabBarView(
//
//                         // physics: NeverScro
//                       // llableScrollPhysics(),
//                         controller: newTabController!.value,
//                         children: List.generate(
//                           scoreController.tab.value,
//                           (index) => Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Column(
//                                 children: [
//                                   Text14by500(
//                                     text: 'questionsWithOptions.results![index].question!.question.toString()',
//                                     fontSize: 20,
//                                   ),
//                                   ...List.generate(
//                                       5,
//                                       (optionIndex) => BorderButton(
//                                             buttonText: 'fgh',
//                                             // buttonText: questionsWithOptions.results![index].answers![optionIndex].answer.toString(),
//                                             onClick: () {
//                                               scoreController.serial.value = optionIndex;
//                                             },
//                                             textColor: scoreController.serial.value == optionIndex ? AppColors.tealColor : AppColors.greyColor676464 ,
//                                             borderColor: scoreController.serial.value == optionIndex ? AppColors.tealColor  : AppColors.greyColor676464,
//                                           )),
//                                 ],
//                               ),
//                               Spacer(),
//                               CustomSolidButton(
//                                 buttonText: 'Save & Next',
//                                 onClick: () {
//                                   scoreController.currentIndex.value=4;
//                                  // scoreController.tabController!.value.animateTo(scoreController.currentIndex.value);
//                                   // scoreController.saveAnswers().whenComplete(() {
//                                   //  Get.to(()=> const DailyAffirmationView());
//                                   //   });
//                                   // scoreController.tabController.animateTo(2);
//                                 },
//                               )
//                             ],
//                           ),
//                         )),
//                   )
//                 ],
//               )
//             : Center(child: const CircularProgressIndicator())
//         ),
//       ),
//     );
//   }
// }
