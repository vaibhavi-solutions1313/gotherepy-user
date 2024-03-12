import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/appButtons.dart';
import 'package:gotherepy/app/appWidgets/text_styles.dart';
import 'package:gotherepy/app/modules/doctor_list_view/views/doctor_list_view_view.dart';
import 'package:gotherepy/app/modules/doctor_list_view/views/top_three_doctor_view.dart';

import '../../appWidgets/universalAppBar.dart';
import '../../app_constants/constants_appColors.dart';
import '../../app_model/conversation.dart';

class HealthScoreViewView extends GetView {
  final dynamic data;
  final num totalScore;
  final String? categoryId;
  const HealthScoreViewView({
    Key? key,
    this.data,
    required this.totalScore,
    this.categoryId,
    
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(Get.width);
    print(Get.width * (data['results']['total_score'] * 0.1));
    print(data['results']['total_score'] * 0.1);
    print(data['results']['total_score']);
    return Scaffold(
      appBar: CustomUniversalAppBar(
        title: 'Health Score',
        showBackButton: true,
        appBar: AppBar(),
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              // physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            AppColors.appThemeColor,
                            AppColors.appThemeColor.withOpacity(0.9),
                            AppColors.bluishColor.withOpacity(0.7),
                            AppColors.bluishColor.withOpacity(0.8)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(30.0)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1.0, 1.0),
                          color: AppColors.containerColor,
                          spreadRadius: 1.0,
                          blurRadius: 2.0,
                        )
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text14by400(
                          text:
                              'Getting to know yourself is the first step towards a mentally healthier life.',
                          color: Colors.white,
                          maxLine: 6,
                          align: TextAlign.center),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text14by400(
                          text: 'Congratulations on taking the first step!.',
                          color: Colors.white,
                          maxLine: 6,
                          align: TextAlign.center),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            AppColors.appThemeColor,
                            AppColors.appThemeColor.withOpacity(0.85),
                            AppColors.appThemeColor.withOpacity(0.75),
                            AppColors.bluishColor.withOpacity(0.7),
                            AppColors.bluishColor.withOpacity(0.8)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1.0, 1.0),
                          color: AppColors.containerColor,
                          spreadRadius: 1.0,
                          blurRadius: 2.0,
                        )
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text14by400(
                        text: data['results']['quiz_type'].toString(),
                        color: Colors.yellow,
                        maxLine: 6,
                        align: TextAlign.center,
                        fontSize: 18,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: Get.width,
                            height: 18,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                //gradient: LinearGradient(colors: [AppColors.appThemeColor,AppColors.bluishColor.withOpacity(0.7),AppColors.bluishColor.withOpacity(0.8)],begin: Alignment.topRight,end: Alignment.topLeft),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.5, 0.2),
                                    color: AppColors.containerColor,
                                    spreadRadius: 3,
                                    blurRadius: 0.8,
                                  )
                                ]),
                          ),
                          Container(
                            width: (Get.width / totalScore) ,
                            height: 18,
                            // margin: EdgeInsets.all(16.0),
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    AppColors.appThemeColor,
                                    AppColors.bluishColor.withOpacity(0.7),
                                    AppColors.bluishColor.withOpacity(0.8)
                                  ],
                                  begin: Alignment.topRight,
                                  end: Alignment.topLeft),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              // boxShadow:[
                              //   BoxShadow(
                              //     offset: Offset(0.5, 0.5),
                              //     color: AppColors.containerColor,
                              //     spreadRadius: 0.6,
                              //     blurRadius: 0.8,
                              //   )
                              // ]
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text14by400(
                          text:
                              'Score is ${data['results']['total_score'].toString()} which is ${data['results']['total_score'] <= (totalScore / 4) ? 'Negligible' : (data['results']['total_score']) <= (totalScore / 2) ? 'mild' : (data['results']['total_score']) < (totalScore / 4) * 3 ? 'Moderate' : 'Severe'} level of ${data['results']['quiz_type'].toString()}.',
                          color: Colors.white,
                          maxLine: 6,
                          align: TextAlign.center),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              CustomSolidButton(
                                  buttonText: 'Negligible',
                                  onClick: () {},
                                  boxColor: Colors.greenAccent.withOpacity(0.5),
                                  textColor: Colors.green,
                                  vPadding: 4.0),
                              Text14by500(
                                text:
                                    '0-${(totalScore / 4).toStringAsFixed(0)}',
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              CustomSolidButton(
                                  buttonText: 'Mild',
                                  onClick: () {},
                                  boxColor:
                                      Colors.yellowAccent.withOpacity(0.2),
                                  textColor: Colors.orange,
                                  vPadding: 4.0),
                              Text14by500(
                                text:
                                    '${(totalScore / 4).toStringAsFixed(0)}-${(totalScore / 2).toStringAsFixed(0)}',
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              CustomSolidButton(
                                  buttonText: 'Moderate',
                                  onClick: () {},
                                  boxColor: Colors.blueAccent.withOpacity(0.5),
                                  textColor: Colors.blue,
                                  vPadding: 4.0),
                              Text14by500(
                                text:
                                    '${(totalScore / 2).toStringAsFixed(0)}-${(totalScore - totalScore / 4).toStringAsFixed(0)}',
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              CustomSolidButton(
                                  buttonText: 'Severe',
                                  onClick: () {},
                                  boxColor: Colors.redAccent.withOpacity(0.2),
                                  textColor: Colors.red,
                                  vPadding: 4.0),
                              Text14by500(
                                text:
                                    '${(totalScore - totalScore / 4).toStringAsFixed(0)}-${totalScore.toStringAsFixed(0)}',
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                ///Understanding
                Container(
                  margin: EdgeInsets.all(16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            AppColors.appThemeColor,
                            AppColors.appThemeColor.withOpacity(0.9),
                            AppColors.bluishColor.withOpacity(0.7),
                            AppColors.bluishColor.withOpacity(0.8)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1.0, 1.0),
                          color: AppColors.containerColor,
                          spreadRadius: 1.0,
                          blurRadius: 2.0,
                        )
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text14by400(
                          text: 'Understanding your assessment.',
                          color: Colors.white,
                          maxLine: 6,
                          align: TextAlign.center,
                          fontSize: 15),
                      SizedBox(
                        height: 10.0,
                      ),
                      Icon(Icons.lightbulb_outline),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text14by400(
                          text:
                              'The possible range of scores is 0 to $totalScore, 0 indicates \'no ${data['results']['quiz_type'].toString()}\' ',
                          color: Colors.white,
                          maxLine: 6,
                          align: TextAlign.center),
                      SizedBox(
                        height: 10.0,
                      ),
                      Icon(Icons.lightbulb_outline),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text14by400(
                          text:
                              'A scores of ${'${(totalScore / 4).toStringAsFixed(0)}-${(totalScore / 2).toStringAsFixed(0)}'}, you may experience some mild symptoms of ${data['results']['quiz_type'].toString()} depending',
                          color: Colors.white,
                          maxLine: 6,
                          align: TextAlign.center),
                      SizedBox(
                        height: 10.0,
                      ),
                      Icon(Icons.lightbulb_outline),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),

                ///Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomSolidButton(
                    buttonText: 'Book an appointment',
                    onClick: () {
                      if(categoryId!=null){
                        Get.to(() =>  TopThreeDoctorListPageView(categoryID: categoryId!) );
                      }else{
                        print('Something went wrong');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          // Positioned(
          //   top: 50,
          //   width: Get.width,
          //   child: ListView(
          //     shrinkWrap: true,
          //     children: [
          //       Container(
          //         padding: EdgeInsets.all(16.0),
          //         decoration: BoxDecoration(
          //           gradient: LinearGradient(colors: [AppColors.appThemeColor,AppColors.bluishColor.withOpacity(0.7),AppColors.bluishColor.withOpacity(0.8)],begin: Alignment.topCenter,end: Alignment.bottomCenter),
          //           borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
          //           boxShadow:[
          //             BoxShadow(
          //               offset: Offset(1.0, 1.0),
          //               color: AppColors.containerColor,
          //               spreadRadius: 1.0,
          //               blurRadius: 2.0,
          //             )
          //           ]
          //         ),
          //         child: Column(
          //           children: [
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //           ],
          //         ),
          //       ),
          //       Container(
          //         padding: EdgeInsets.all(16.0),
          //         decoration: BoxDecoration(
          //           gradient: LinearGradient(colors: [AppColors.appThemeColor,AppColors.bluishColor.withOpacity(0.7),AppColors.bluishColor.withOpacity(0.8)],begin: Alignment.topCenter,end: Alignment.bottomCenter),
          //           borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
          //           boxShadow:[
          //             BoxShadow(
          //               offset: Offset(1.0, 1.0),
          //               color: AppColors.containerColor,
          //               spreadRadius: 1.0,
          //               blurRadius: 2.0,
          //             )
          //           ]
          //         ),
          //         child: Column(
          //           children: [
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //           ],
          //         ),
          //       ),
          //       Container(
          //         padding: EdgeInsets.all(16.0),
          //         decoration: BoxDecoration(
          //             gradient: LinearGradient(colors: [AppColors.appThemeColor,AppColors.bluishColor.withOpacity(0.7),AppColors.bluishColor.withOpacity(0.8)],begin: Alignment.topCenter,end: Alignment.bottomCenter),
          //             borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
          //             boxShadow:[
          //               BoxShadow(
          //                 offset: Offset(1.0, 1.0),
          //                 color: AppColors.containerColor,
          //                 spreadRadius: 1.0,
          //                 blurRadius: 2.0,
          //               )
          //             ]
          //         ),
          //         child: Column(
          //           children: [
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //           ],
          //         ),
          //       ),
          //       Container(
          //         padding: EdgeInsets.all(16.0),
          //         decoration: BoxDecoration(
          //             gradient: LinearGradient(colors: [AppColors.appThemeColor,AppColors.bluishColor.withOpacity(0.7),AppColors.bluishColor.withOpacity(0.8)],begin: Alignment.topCenter,end: Alignment.bottomCenter),
          //             borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
          //             boxShadow:[
          //               BoxShadow(
          //                 offset: Offset(1.0, 1.0),
          //                 color: AppColors.containerColor,
          //                 spreadRadius: 1.0,
          //                 blurRadius: 2.0,
          //               )
          //             ]
          //         ),
          //         child: Column(
          //           children: [
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //           ],
          //         ),
          //       ),
          //       Container(
          //         padding: EdgeInsets.all(16.0),
          //         decoration: BoxDecoration(
          //             gradient: LinearGradient(colors: [AppColors.appThemeColor,AppColors.bluishColor.withOpacity(0.7),AppColors.bluishColor.withOpacity(0.8)],begin: Alignment.topCenter,end: Alignment.bottomCenter),
          //             borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
          //             boxShadow:[
          //               BoxShadow(
          //                 offset: Offset(1.0, 1.0),
          //                 color: AppColors.containerColor,
          //                 spreadRadius: 1.0,
          //                 blurRadius: 2.0,
          //               )
          //             ]
          //         ),
          //         child: Column(
          //           children: [
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //           ],
          //         ),
          //       ),
          //       Container(
          //         padding: EdgeInsets.all(16.0),
          //         decoration: BoxDecoration(
          //             gradient: LinearGradient(colors: [AppColors.appThemeColor,AppColors.bluishColor.withOpacity(0.7),AppColors.bluishColor.withOpacity(0.8)],begin: Alignment.topCenter,end: Alignment.bottomCenter),
          //             borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
          //             boxShadow:[
          //               BoxShadow(
          //                 offset: Offset(1.0, 1.0),
          //                 color: AppColors.containerColor,
          //                 spreadRadius: 1.0,
          //                 blurRadius: 2.0,
          //               )
          //             ]
          //         ),
          //         child: Column(
          //           children: [
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //           ],
          //         ),
          //       ),
          //       Container(
          //         padding: EdgeInsets.all(16.0),
          //         decoration: BoxDecoration(
          //             gradient: LinearGradient(colors: [AppColors.appThemeColor,AppColors.bluishColor.withOpacity(0.7),AppColors.bluishColor.withOpacity(0.8)],begin: Alignment.topCenter,end: Alignment.bottomCenter),
          //             borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
          //             boxShadow:[
          //               BoxShadow(
          //                 offset: Offset(1.0, 1.0),
          //                 color: AppColors.containerColor,
          //                 spreadRadius: 1.0,
          //                 blurRadius: 2.0,
          //               )
          //             ]
          //         ),
          //         child: Column(
          //           children: [
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //           ],
          //         ),
          //       ),
          //       Container(
          //         padding: EdgeInsets.all(16.0),
          //         decoration: BoxDecoration(
          //             gradient: LinearGradient(colors: [AppColors.appThemeColor,AppColors.bluishColor.withOpacity(0.7),AppColors.bluishColor.withOpacity(0.8)],begin: Alignment.topCenter,end: Alignment.bottomCenter),
          //             borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
          //             boxShadow:[
          //               BoxShadow(
          //                 offset: Offset(1.0, 1.0),
          //                 color: AppColors.containerColor,
          //                 spreadRadius: 1.0,
          //                 blurRadius: 2.0,
          //               )
          //             ]
          //         ),
          //         child: Column(
          //           children: [
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //             Text('kjhkjkkl'),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
