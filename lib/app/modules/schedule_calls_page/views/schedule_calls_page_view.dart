import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/app_constants/constants_end_points.dart';
import 'package:gotherepy/app/modules/counselors_page/bindings/counselors_page_binding.dart';
import 'package:gotherepy/app/modules/counselors_page/views/chat_conversation_view.dart';
import 'package:gotherepy/app/modules/counselors_page/views/live_counselor_view.dart';
import 'package:gotherepy/app/modules/home/controllers/home_controller.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../counselors_page/views/slots_booking_page_view.dart';
import '../controllers/schedule_calls_page_controller.dart';

class ScheduleCallsPageView extends GetView<ScheduleCallsPageController> {
  final bool showBackButton;
  const ScheduleCallsPageView( {this.showBackButton=false,Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ScheduleCallsPageController tab = Get.put(ScheduleCallsPageController());
    return Scaffold(
      appBar: CustomUniversalAppBar(
        showBackButton: showBackButton,
        title: 'Schedule Session',
        appBar: AppBar(),
      ),
      body: Column(
        children: [
          /*Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.lightGreyTextColor),
                borderRadius: BorderRadius.circular(16.0),

                // color: Color(0xFFF5C316),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: AppColors.bluishColor,
                    image: DecorationImage(image: AssetImage(AppImages.appbarBackgroundPngImage), fit: BoxFit.fitWidth)),
                labelColor: Colors.white,
                labelStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                unselectedLabelColor: AppColors.lightGreyTextColor,
                controller: tab.callTabController,
                tabs: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        // color: Color(0xFFF5C316),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Text(
                      'Individual session'.tr,
                    )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: Text(
                      'Group session'.tr,
                    )),
                  ),
                ],
              ),
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.lightGreyTextColor),
                borderRadius: BorderRadius.circular(15.0),
                // color: Colors.transparent,
                // gradient: LinearGradient(colors: [Colors.teal.withOpacity(0.1),Colors.white],begin: Alignment.centerRight,end: Alignment.center)
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    // color: AppColors.bluishColor.withRed(220),
                    gradient: LinearGradient(colors: [AppColors.bluishColor, AppColors.bluishColor.withOpacity(0.7)]),
                    image: DecorationImage(image: AssetImage(AppImages.appbarBackgroundPngImage), fit: BoxFit.fitWidth)),
                labelColor: Colors.white,
                labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                unselectedLabelColor: AppColors.lightGreyTextColor,
                controller: tab.tabController,
                tabs: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        // color: Color(0xFFF5C316),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Text(
                      'Upcoming'.tr,
                    )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: Text(
                      'Completed'.tr,
                    )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: Text(
                      'Cancel'.tr,
                    )),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tab.callTabController,
              children: [
                ///Individual-subTab
                TabBarView(controller: tab.tabController, children: [
                  ///Upcoming session
                  Obx(() => tab.upcomingSessionCallRecords.value.results != null && tab.upcomingSessionCallRecords.value.results!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: tab.upcomingSessionCallRecords.value.results?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                              child: Container(
                                margin: EdgeInsets.only(top: 16),
                                padding: EdgeInsets.all(18.0),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.0), boxShadow: [
                                  BoxShadow(offset: Offset(1, 1), blurRadius: 2, spreadRadius: 3, color: AppColors.lightGreyTextColor.withOpacity(0.5))
                                ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.red,
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(140.0),
                                                      child: Image.network(tab.upcomingSessionCallRecords.value.results!.isNotEmpty &&
                                                              tab.upcomingSessionCallRecords.value.results![index].avatar!.isNotEmpty
                                                          ? EndPoints.imageBaseUrl+tab.upcomingSessionCallRecords.value.results![index].avatar!
                                                          : ''))),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text14by400(text: tab.upcomingSessionCallRecords.value.results![index].name!),
                                                Text16by400(
                                                  text: tab.upcomingSessionCallRecords.value.results![index].degree!,
                                                  fontSize: 12,
                                                  color: AppColors.lightGreyTextColor,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Change Doc for Session',
                                          style: TextStyle(
                                              fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.tealColor, decoration: TextDecoration.underline),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
                                          decoration: ShapeDecoration(shape: StadiumBorder(), color: AppColors.containerColor),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today,
                                                color: AppColors.lightGreyTextColor,
                                              ),
                                              Text14by400(
                                                  text: DateFormat('dd-MM-yyyy')
                                                      .format(DateTime.parse(tab.upcomingSessionCallRecords.value.results![index].bookingDate!))
                                                      .toString(),
                                                  color: AppColors.lightGreyTextColor),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.access_time_rounded,
                                                color: AppColors.lightGreyTextColor,
                                              ),
                                              Text14by400(
                                                  text:
                                                      '${tab.upcomingSessionCallRecords.value.results![index].bookingStartTime}-${tab.upcomingSessionCallRecords.value.results![index].bookingEndTime}',
                                                  color: AppColors.lightGreyTextColor),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                            child: BorderButton(
                                                buttonText: 'Reschedule',
                                                fontSize: 12,
                                                onClick: () async {
                                                  context.loaderOverlay.show();
                                                  if (DateTime.now()
                                                          .difference(DateTime.parse(tab.upcomingSessionCallRecords.value.results![index].bookingDate!)) <
                                                      const Duration(hours: 6)) {
                                                    context.loaderOverlay.hide();
                                                    Get.dialog(Dialog(
                                                      child: Container(
                                                        padding: const EdgeInsets.all(30.0),
                                                        decoration: const BoxDecoration(color: AppColors.lightGreen),
                                                        child: const Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Text16by700(text: 'You can not schedule this session,'),
                                                            Text('You can reschedule a session before 6 hour from the booking date,'),
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                                  } else {
                                                    tab
                                                        .getDoctorById(doctorId: tab.upcomingSessionCallRecords.value.results![index].doctorId!.toString(),appointmentId: tab.upcomingSessionCallRecords.value.results![index].appointmentNumber)
                                                        .whenComplete(() => context.loaderOverlay.hide());
                                                  }
                                                })),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                            child: CustomSolidButton(
                                          buttonText: 'Enter Waiting Room',
                                          onClick: () async {
                                            context.loaderOverlay.show();
                                            Get.to(()=>const LiveCounselorView(),binding: CounselorsPageBinding());
                                            context.loaderOverlay.hide();
                                            // Fluttertoast.showToast(msg: 'Doctor Not Available');
                                          },
                                          fontSize: 12,
                                        )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                      : tab.isAllCallSessionLoading.value==true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Center(
                              child: Text('No records'),
                            )
                  ),

                  ///completed session
                  Obx(() => tab.completedSessionCallRecords.value.results != null && tab.completedSessionCallRecords.value.results!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: tab.completedSessionCallRecords.value.results!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                              child: Container(
                                margin: EdgeInsets.only(top: 16),
                                padding: EdgeInsets.all(18.0),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.0), boxShadow: [
                                  BoxShadow(offset: Offset(1, 1), blurRadius: 2, spreadRadius: 3, color: AppColors.lightGreyTextColor.withOpacity(0.5))
                                ]),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Row(
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.red,
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(140.0),
                                                      child: Image.network(tab.completedSessionCallRecords.value.results!.isNotEmpty &&
                                                          tab.completedSessionCallRecords.value.results![index].avatar!.isNotEmpty
                                                          ? EndPoints.imageBaseUrl+tab.completedSessionCallRecords.value.results![index].avatar!
                                                          : ''))),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text14by400(text: tab.completedSessionCallRecords.value.results![index].name ?? ''),
                                                Text16by400(
                                                  text: tab.completedSessionCallRecords.value.results![index].degree ?? '',
                                                  fontSize: 12,
                                                  color: AppColors.lightGreyTextColor,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
                                          decoration: ShapeDecoration(shape: StadiumBorder(), color: AppColors.containerColor),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today,
                                                color: AppColors.lightGreyTextColor,
                                              ),
                                              Text14by400(
                                                  text: tab.completedSessionCallRecords.value.results![index].bookingDate ?? '',
                                                  color: AppColors.lightGreyTextColor),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.access_time_rounded,
                                                color: AppColors.lightGreyTextColor,
                                              ),
                                              Text14by400(
                                                  text: tab.completedSessionCallRecords.value.results![index].bookingStartTime ??
                                                      ''
                                                          '${"-${tab.completedSessionCallRecords.value.results![index].bookingEndTime}"}',
                                                  color: AppColors.lightGreyTextColor),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                            child: BorderButton(
                                                buttonText: 'Chat with Doctor',
                                                fontSize: 12,
                                                onClick: () async {
                                                 Get.to(()=>ChatConversationPageView(doctorId: tab.completedSessionCallRecords.value.results![index].doctorId.toString(), doctorAvatar: tab.completedSessionCallRecords.value.results![index].avatar.toString(), doctorName: tab.completedSessionCallRecords.value.results![index].name.toString(),));
                                                })),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                            child: CustomSolidButton(
                                          buttonText: 'Download Report',
                                          onClick: () async {
                                            context.loaderOverlay.show();
                                            await Future.delayed(Duration(seconds: 4), () {
                                              context.loaderOverlay.hide();
                                              Fluttertoast.showToast(msg: 'Doctor Not Available');
                                            });
                                          },
                                          fontSize: 12,
                                        )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                      : tab.isAllCallSessionLoading.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Center(
                              child: Text('No records'),
                            )),

                  ///cancelled session
                  Obx(() => tab.cancelledSessionCallRecords.value.results != null && tab.cancelledSessionCallRecords.value.results!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                              child: Container(
                                margin: EdgeInsets.only(top: 16),
                                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.0), boxShadow: [
                                  BoxShadow(offset: Offset(1, 1), blurRadius: 2, spreadRadius: 3, color: AppColors.lightGreyTextColor.withOpacity(0.5))
                                ]),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Row(
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.red,
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(140.0),
                                                      child: Image.network(tab.cancelledSessionCallRecords.value.results!.isNotEmpty &&
                                                          tab.cancelledSessionCallRecords.value.results![index].avatar!.isNotEmpty
                                                          ? EndPoints.imageBaseUrl+tab.cancelledSessionCallRecords.value.results![index].avatar!
                                                          : ''))),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text14by400(text: 'Dr. Mira Desai'),
                                                Text16by400(
                                                  text: 'Dentist',
                                                  fontSize: 12,
                                                  color: AppColors.lightGreyTextColor,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
                                          decoration: ShapeDecoration(shape: StadiumBorder(), color: AppColors.containerColor),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today,
                                                color: AppColors.lightGreyTextColor,
                                              ),
                                              Text14by400(text: '12 Aug 2021', color: AppColors.lightGreyTextColor),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.access_time_rounded,
                                                color: AppColors.lightGreyTextColor,
                                              ),
                                              Text14by400(text: '10 am - 10:30 pm', color: AppColors.lightGreyTextColor),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomSolidButton(
                                          buttonText: 'Download Report',
                                          onClick: () async {
                                            context.loaderOverlay.show();
                                            await Future.delayed(Duration(seconds: 4), () {
                                              context.loaderOverlay.hide();
                                              Fluttertoast.showToast(msg: 'Doctor Not Available');
                                            });
                                          },
                                          fontSize: 12,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                      : tab.isAllCallSessionLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Center(
                              child: Text('No records'),
                            )),
                ]),
                ///Individual-GroupTab
                TabBarView(controller: tab.tabController, children: [
                  ///Upcoming session
                  Obx(() => tab.upcomingSessionCallRecords.value.results != null && tab.upcomingSessionCallRecords.value.results!.isNotEmpty
                      ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: tab.upcomingSessionCallRecords.value.results?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                          child: Container(
                            margin: EdgeInsets.only(top: 16),
                            padding: EdgeInsets.all(18.0),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.0), boxShadow: [
                              BoxShadow(offset: Offset(1, 1), blurRadius: 2, spreadRadius: 3, color: AppColors.lightGreyTextColor.withOpacity(0.5))
                            ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.red,
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(140.0),
                                                  child: Image.network(tab.upcomingSessionCallRecords.value.results!.isNotEmpty &&
                                                      tab.upcomingSessionCallRecords.value.results![index].avatar!.isNotEmpty
                                                      ? EndPoints.imageBaseUrl+tab.upcomingSessionCallRecords.value.results![index].avatar!
                                                      : ''))),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text14by400(text: tab.upcomingSessionCallRecords.value.results![index].name!),
                                            Text16by400(
                                              text: tab.upcomingSessionCallRecords.value.results![index].degree!,
                                              fontSize: 12,
                                              color: AppColors.lightGreyTextColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Change Doc for Session',
                                      style: TextStyle(
                                          fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.tealColor, decoration: TextDecoration.underline),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
                                      decoration: ShapeDecoration(shape: StadiumBorder(), color: AppColors.containerColor),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            color: AppColors.lightGreyTextColor,
                                          ),
                                          Text14by400(
                                              text: DateFormat('dd-MM-yyyy')
                                                  .format(DateTime.parse(tab.upcomingSessionCallRecords.value.results![index].bookingDate!))
                                                  .toString(),
                                              color: AppColors.lightGreyTextColor),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.access_time_rounded,
                                            color: AppColors.lightGreyTextColor,
                                          ),
                                          Text14by400(
                                              text:
                                              '${tab.upcomingSessionCallRecords.value.results![index].bookingStartTime}-${tab.upcomingSessionCallRecords.value.results![index].bookingEndTime}',
                                              color: AppColors.lightGreyTextColor),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                        child: BorderButton(
                                            buttonText: 'Reschedule',
                                            fontSize: 12,
                                            onClick: () async {
                                              context.loaderOverlay.show();
                                              if (DateTime.now()
                                                  .difference(DateTime.parse(tab.upcomingSessionCallRecords.value.results![index].bookingDate!)) <
                                                  const Duration(hours: 6)) {
                                                context.loaderOverlay.hide();
                                                Get.dialog(Dialog(
                                                  child: Container(
                                                    padding: const EdgeInsets.all(30.0),
                                                    decoration: const BoxDecoration(color: AppColors.lightGreen),
                                                    child: const Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text16by700(text: 'You can not schedule this session,'),
                                                        Text('You can reschedule a session before 6 hour from the booking date,'),
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                              } else {
                                                tab
                                                    .getDoctorById(doctorId: tab.upcomingSessionCallRecords.value.results![index].doctorId!.toString(),appointmentId: tab.upcomingSessionCallRecords.value.results![index].appointmentNumber)
                                                    .whenComplete(() => context.loaderOverlay.hide());
                                              }
                                            })),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                        child: CustomSolidButton(
                                          buttonText: 'Enter Waiting Room',
                                          onClick: () async {
                                            context.loaderOverlay.show();
                                            await Future.delayed(Duration(seconds: 4), () {
                                              context.loaderOverlay.hide();
                                              Fluttertoast.showToast(msg: 'Doctor Not Available');
                                            });
                                          },
                                          fontSize: 12,
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      })
                      : tab.isAllCallSessionLoading.value
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : const Center(
                    child: Text('No records'),
                  )),

                  ///completed session
                  Obx(() => tab.completedSessionCallRecords.value.results != null && tab.completedSessionCallRecords.value.results!.isNotEmpty
                      ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: tab.completedSessionCallRecords.value.results!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                          child: Container(
                            margin: EdgeInsets.only(top: 16),
                            padding: EdgeInsets.all(18.0),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.0), boxShadow: [
                              BoxShadow(offset: Offset(1, 1), blurRadius: 2, spreadRadius: 3, color: AppColors.lightGreyTextColor.withOpacity(0.5))
                            ]),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: CircleAvatar(
                                            radius: 30,
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text14by400(text: tab.completedSessionCallRecords.value.results![index].name ?? ''),
                                            Text16by400(
                                              text: tab.completedSessionCallRecords.value.results![index].degree ?? '',
                                              fontSize: 12,
                                              color: AppColors.lightGreyTextColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
                                      decoration: ShapeDecoration(shape: StadiumBorder(), color: AppColors.containerColor),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            color: AppColors.lightGreyTextColor,
                                          ),
                                          Text14by400(
                                              text: tab.completedSessionCallRecords.value.results![index].bookingDate ?? '',
                                              color: AppColors.lightGreyTextColor),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.access_time_rounded,
                                            color: AppColors.lightGreyTextColor,
                                          ),
                                          Text14by400(
                                              text: tab.completedSessionCallRecords.value.results![index].bookingStartTime ??
                                                  ''
                                                      '${"-${tab.completedSessionCallRecords.value.results![index].bookingEndTime}"}',
                                              color: AppColors.lightGreyTextColor),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                        child: BorderButton(
                                            buttonText: 'Chat with Doctor',
                                            fontSize: 12,
                                            onClick: () async {
                                              context.loaderOverlay.show();
                                              await Future.delayed(Duration(seconds: 4), () {
                                                context.loaderOverlay.hide();
                                                Fluttertoast.showToast(msg: 'Doctor Not Available');
                                              });
                                            })),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                        child: CustomSolidButton(
                                          buttonText: 'Download Report',
                                          onClick: () async {
                                            context.loaderOverlay.show();
                                            await Future.delayed(Duration(seconds: 4), () {
                                              context.loaderOverlay.hide();
                                              Fluttertoast.showToast(msg: 'Doctor Not Available');
                                            });
                                          },
                                          fontSize: 12,
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      })
                      : tab.isAllCallSessionLoading.value
                      ? Center(
                    child: CircularProgressIndicator(),
                  )
                      : const Center(
                    child: Text('No records'),
                  )),

                  ///cancelled session
                  Obx(() => tab.cancelledSessionCallRecords.value.results != null && tab.cancelledSessionCallRecords.value.results!.isNotEmpty
                      ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                          child: Container(
                            margin: EdgeInsets.only(top: 16),
                            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.0), boxShadow: [
                              BoxShadow(offset: Offset(1, 1), blurRadius: 2, spreadRadius: 3, color: AppColors.lightGreyTextColor.withOpacity(0.5))
                            ]),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: CircleAvatar(
                                            radius: 30,
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text14by400(text: 'Dr. Mira Desai'),
                                            Text16by400(
                                              text: 'Dentist',
                                              fontSize: 12,
                                              color: AppColors.lightGreyTextColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
                                      decoration: ShapeDecoration(shape: StadiumBorder(), color: AppColors.containerColor),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            color: AppColors.lightGreyTextColor,
                                          ),
                                          Text14by400(text: '12 Aug 2021', color: AppColors.lightGreyTextColor),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.access_time_rounded,
                                            color: AppColors.lightGreyTextColor,
                                          ),
                                          Text14by400(text: '10 am - 10:30 pm', color: AppColors.lightGreyTextColor),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomSolidButton(
                                      buttonText: 'Download Report',
                                      onClick: () async {
                                        context.loaderOverlay.show();
                                        await Future.delayed(Duration(seconds: 4), () {
                                          context.loaderOverlay.hide();
                                          Fluttertoast.showToast(msg: 'Doctor Not Available');
                                        });
                                      },
                                      fontSize: 12,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      })
                      : tab.isAllCallSessionLoading.value
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : const Center(
                    child: Text('No records'),
                  )),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
