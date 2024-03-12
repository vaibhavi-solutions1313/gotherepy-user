import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:gotherepy/app/app_constants/constants_end_points.dart';
import '../../counselors_page/views/chat_conversation_view.dart';
import '../chat_list_model/chat_list_model.dart';
import '../controllers/chat_page_controller.dart';
import 'package:gotherepy/main.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';

class ChatPageView extends GetView<ChatPageController> {
  final bool showBackButton;
  const ChatPageView({this.showBackButton=false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatPageController chatPageController = ChatPageController();
    return Scaffold(
      appBar: CustomUniversalAppBar(
        showBackButton: showBackButton,
        title: 'Chat with our experts',
        appBar: AppBar(),
      ),
      body: FutureBuilder<ChatListModel>(
        future: chatPageController.getAllChatList(userId: userInfo.userData.value.results!.userId.toString()),
        builder: (context, snapData) {
          if (snapData.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapData.hasError) {
            return Center(
                child: Text16by400(
              text: 'Something went wrong',
              fontSize: 12,
              color: AppColors.lightGreyTextColor,
            ));
          }
          else {
            if (snapData.data!.results == []) {
              return Center(
                  child: Text16by400(
                text: 'Not available',
                fontSize: 13,
                color: AppColors.lightGreyTextColor,
              ));
            } else {
              var data = snapData.data!.results;
              return data != null && data.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.only(top: 6.0, bottom: 16.0),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.5, 1),
                                blurRadius: 1,
                                spreadRadius: 1,
                                color: AppColors.lightGreyTextColor.withOpacity(0.5),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10.0, top: 18.0, right: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Stack(
                                          children: [
                                            CircularPercentIndicator(
                                              radius: 35.0,
                                              animation: true,
                                              animationDuration: 1200,
                                              linearGradient: const LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Color(0xFF44C3D4),
                                                  Color(0xFF44C3D4),
                                                ],
                                              ),
                                              lineWidth: 2.0,
                                              percent: 1.0,
                                              center: InkWell(
                                                onTap: () {
                                                  Fluttertoast.showToast(
                                                    msg: "This is a toast",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.black,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0,
                                                  );
                                                },
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 30,
                                                      backgroundColor: Colors.red,
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(140.0),
                                                        child: Image.network(
                                                          snapData.data!.results!.isNotEmpty && snapData.data!.results![index].avatar != null
                                                              ? EndPoints.imageBaseUrl + snapData.data!.results![index].avatar!
                                                              : '',
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      right: 0,
                                                      bottom: 0,
                                                      child: CircleAvatar(
                                                        radius: 8,
                                                        backgroundColor: AppColors.greenColor,
                                                        child: Icon(
                                                          Icons.circle,
                                                          color: AppColors.greenColor,
                                                          size: 8,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              circularStrokeCap: CircularStrokeCap.round,
                                              startAngle: 150,
                                              backgroundColor: Colors.transparent,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text14by400(text: data[index].doctorName ?? '', fontSize: 14),
                                              Text16by400(
                                                text: 'Specialization',
                                                fontSize: 12,
                                                color: AppColors.greyColor676464,
                                              ),
                                              Wrap(
                                                spacing: 2.0,
                                                runSpacing: 2.0,
                                                children: List.generate(
                                                  data[index].doctorName!.length > 4 ? 4 : data[index].doctorName!.length,
                                                  (innerIndex) {
                                                    if (innerIndex >= 3) {
                                                      return Container(

                                                        padding: EdgeInsets.all(2.0),
                                                        child: Text16by400(
                                                          text: '+ ${data[index].doctorName!.length - 4}',
                                                          fontSize: 10,
                                                          color: AppColors.greyColor676464,
                                                          maxLine: 3,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(color: Colors.black12),
                                                        ),
                                                      );
                                                    }
                                                    return Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(12.0),
                                                        border: Border.all(color: Colors.black12),
                                                      ),
                                                      child: Text16by400(
                                                        text: data[index].doctorName![innerIndex],
                                                        fontSize: 10,
                                                        color: AppColors.lightGreyTextColor,
                                                        maxLine: 3,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (data[index].doctorName != null && data[index].doctorName != '')
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 6.0),
                                              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                                              decoration: ShapeDecoration(
                                                shape: StadiumBorder(),
                                                color: AppColors.containerColor,
                                              ),
                                              child: Text14by400(
                                                text: data[index].doctorName!,
                                                color: AppColors.lightGreyTextColor,
                                                maxLine: 2,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    // Positioned(
                                    //   top: 10,
                                    //   right: 10,
                                    //   child: Container(
                                    //     padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                                    //     decoration: BoxDecoration(
                                    //       color: AppColors.tealColor,
                                    //       borderRadius: BorderRadius.circular(10.0),
                                    //     ),
                                    //     child: Text(
                                    //       '₹ ${data[index].doctorId} /mins',
                                    //       style: TextStyle(color: Colors.white, fontSize: 14),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  Get.to(() => ChatConversationPageView(
                                        doctorId: snapData.data!.results![index].doctorId!.toString(),
                                        doctorAvatar: snapData.data!.results![index].avatar ?? '',
                                        doctorName: snapData.data!.results![index].doctorName ?? '',
                                      ));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                  decoration: const BoxDecoration(
                                    color: AppColors.tealColor,
                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Send Message',
                                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                  : Center(
                      child: Column(
                      children: [
                        Text16by400(
                          text: 'Not Available',
                          fontSize: 12,
                          color: AppColors.lightGreyTextColor,
                        ),
                      ],
                    ));
              // return ListView.builder(
              //   physics: BouncingScrollPhysics(),
              //   shrinkWrap: true,
              //   itemCount: snapData.data!.results?.length,
              //   itemBuilder: (context, index) {
              //       return Card(
              //         elevation: 2,
              //         margin: EdgeInsets.all(8),
              //         child: ListTile(
              //           onTap: () {
              //             Get.to(() => ChatConversationPageView(
              //               doctorId: snapData.data!.results![index].doctorId!.toString(),
              //               doctorAvatar: snapData.data!.results![index].avatar ?? '',
              //               doctorName: snapData.data!.results![index].doctorName ?? '',
              //             ));
              //           },
              //           leading: Padding(
              //             padding: const EdgeInsets.only(right: 8.0),
              //             child: CircularPercentIndicator(
              //               radius: 25.0,
              //               animation: true,
              //               animationDuration: 1200,
              //               linearGradient: const LinearGradient(
              //                 begin: Alignment.topRight,
              //                 end: Alignment.bottomLeft,
              //                 colors: [
              //                   Color(0xFF44C3D4),
              //                   Color(0xFF44C3D4),
              //                 ],
              //               ),
              //               lineWidth: 2.0,
              //               percent: 0.6,
              //               center: CircleAvatar(
              //                 radius: 30,
              //                 child: ClipRRect(
              //                   borderRadius: BorderRadius.circular(140.0),
              //                   child: Image.network(snapData.data!.results!.isNotEmpty && snapData.data!.results![index].avatar != null ? EndPoints.imageBaseUrl + snapData.data!.results![index].avatar! : ''),
              //                 ),
              //               ),
              //               circularStrokeCap: CircularStrokeCap.round,
              //               startAngle: 150,
              //               backgroundColor: Colors.transparent,
              //             ),
              //           ),
              //           title: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Text(snapData.data!.results?[index].doctorName??'', style: TextStyle(fontSize: 14, color: AppColors.greyColor2F2F2F)),
              //               Container(
              //                 width: 8,
              //                 height: 8,
              //                 decoration: BoxDecoration(
              //                   color: Colors.green,
              //                   shape: BoxShape.circle,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           subtitle: Text14by400(text: snapData.data!.results?[index].message??'', color: AppColors.lightGreyTextColor),
              //         ),
              //       );
              //   });
            }
          }
        },
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////
