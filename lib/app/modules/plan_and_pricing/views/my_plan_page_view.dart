import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/modules/plan_and_pricing/views/plan_container_view.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../../app_constants/constants_end_points.dart';
import 'package:http/http.dart' as http;

class MyPlanPageView extends GetView {
  const MyPlanPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future<dynamic> callApi() async {
      var headers = {'Authorization': 'Bearer ${EndPoints.accessToken}'};
      var request = http.Request('GET', Uri.parse('${EndPoints.baseUrl}get-user-subscription'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var responseData = jsonDecode(await response.stream.bytesToString());
      if (responseData['results'].isNotEmpty) {
        return responseData;
      } else {
        return null;
      }
    }

    return Scaffold(
      appBar: CustomUniversalAppBar(
        title: 'My Plan',
        appBar: AppBar(),
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<dynamic>(
            future: callApi(),
            builder: (context, snapData) {
              if (snapData.connectionState == ConnectionState.waiting) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: context.height - 100,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                );
              } else if (snapData.hasError) {
                return SizedBox(
                    height: context.height - 100,
                    child: const Center(
                        child: Text(
                      'Failed To Load',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.blackishTextColor),
                    )));
              } else if (snapData.hasData) {
                List activeList = snapData.data['results'].where((element) => element['status'] == 'active').toList();
                List expiredList = snapData.data['results'].where((element) => element['status'] == 'pending').toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (activeList.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Text14by500(
                          text: 'Active Plan',
                          fontSize: 18,
                        ),
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: activeList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                              padding: const EdgeInsets.all(8.0),
                              decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(16.0), border: Border.all(color: AppColors.bluishColor.withOpacity(0.5))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                        child: Container(
                                          height: 70,
                                          width: 80,
                                          decoration: BoxDecoration(color: Color(0xffFD8642), borderRadius: BorderRadius.circular(16.0), boxShadow: [
                                            BoxShadow(offset: Offset(1.0, 1.0), color: Colors.grey.withOpacity(0.5), blurRadius: 0.5, spreadRadius: 0.5)
                                          ]),
                                          child: CustomPaint(
                                            size: Size(70, (70 * 0.4444444444444444).toDouble()),
                                            painter: RPSPlanAndPricingCustomPainter(),
                                            child: Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text14by500(
                                                        text: activeList[index]['plan_name'].toString(),
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                      ),
                                                      Text14by400(
                                                        text: activeList[index]['status'],
                                                        fontSize: 10,
                                                        color: Colors.white,
                                                      ),
                                                      //Text14by400(text: '${snapshot.data['results'][index]['chat_access']} Video/Audio/Chat Session',fontSize: 6,color: Colors.white,),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Image.asset(AppImages.marriage,height: 70,) ,
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text14by500(
                                              text: activeList[index]['plan_name'].toString(),
                                              fontSize: 18,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text14by400(
                                              text: activeList[index]['activation_date'].toString(),
                                              color: AppColors.greyColor676464,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text14by500(
                                        text: '₹${activeList[index]['price'].toString()}',
                                        fontSize: 18,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text14by400(
                                        text: activeList[index]['status'].toString().toUpperCase(),
                                        color: AppColors.greenColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                    if (expiredList.isNotEmpty) ...[
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Text14by500(
                          text: 'Expired',
                          fontSize: 18,
                        ),
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: expiredList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0), border: Border.all(color: AppColors.greyColor676464.withOpacity(0.5))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ClipRRect(
                                            child: Container(
                                              height: 70,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  color: AppColors.greyColor676464.withOpacity(0.5),
                                                  borderRadius: BorderRadius.circular(16.0),
                                                  boxShadow: [
                                                    BoxShadow(offset: Offset(1.0, 1.0), color: Colors.grey.withOpacity(0.5), blurRadius: 0.5, spreadRadius: 0.5)
                                                  ]),
                                              child: CustomPaint(
                                                size: Size(70, (70 * 0.4444444444444444).toDouble()),
                                                painter: RPSPlanAndPricingCustomPainter(),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text14by500(
                                                            text: expiredList[index]['plan_name'].toString(),
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                          ),
                                                          Text14by400(
                                                            text: expiredList[index]['status'],
                                                            fontSize: 10,
                                                            color: Colors.white,
                                                          ),
                                                          //Text14by400(text: '${snapshot.data['results'][index]['chat_access']} Video/Audio/Chat Session',fontSize: 6,color: Colors.white,),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Image.asset(AppImages.marriage,height: 70,) ,
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text14by500(
                                                  text: expiredList[index]['plan_name'].toString(),
                                                  fontSize: 18,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text14by400(
                                                  text: expiredList[index]['activation_date'].toString(),
                                                  color: AppColors.greyColor676464,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text14by500(
                                            text: '₹${expiredList[index]['price'].toString()}',
                                            fontSize: 18,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text14by400(
                                            text: expiredList[index]['status'].toString().toUpperCase(),
                                            color: AppColors.greyColor676464,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          })
                    ],
                  ],
                );
              } else {
                return SizedBox(
                    height: Get.height-100,
                    child: const Center(child: Text14by500(text:"No plans found")));
              }
            }),
      ),
    );
  }
}
