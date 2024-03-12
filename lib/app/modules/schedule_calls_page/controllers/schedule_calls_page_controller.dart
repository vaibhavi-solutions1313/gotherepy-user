import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../main.dart';
import '../providers/session_call_records_provider_provider.dart';
import '../session_model/call_session.dart';

class ScheduleCallsPageController extends GetxController  with GetTickerProviderStateMixin{
  //TODO: Implement ScheduleCallsPageController
  SessionCallRecordsProvider callRecordsProvider=SessionCallRecordsProvider();
  Rx<CallSessionModel> sessionCallRecords=CallSessionModel().obs;
  Rx<CallSessionModel> upcomingSessionCallRecords=CallSessionModel().obs;
  Rx<CallSessionModel> completedSessionCallRecords=CallSessionModel().obs;
  Rx<CallSessionModel> cancelledSessionCallRecords=CallSessionModel().obs;
  late  TabController tabController;
  late  TabController callTabController;

  var isAllCallSessionLoading=true.obs;


  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    callTabController = TabController(length: 1, vsync: this);
    getSessionCallRecords();
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

  void getSessionCallRecords(){
    print('77777777777777777777777777777777777777777777777777');
    print('77777777777777777777777777777777777777777777777777');
    print('777777777777777777777777555555555555555577777777777777777777777777');
    print('77777777777777777777777777777777777777777777777777');
    print('77777777777777777777777777777777777777777777777777');
  if( userInfo.userData.value.results!=null){
    callRecordsProvider.fetchCallRecords(userInfo.userData.value.results!.userId!.toString()).then((value) {
      isAllCallSessionLoading.value=false;
      if(value.results!.isNotEmpty){
        if (kDebugMode) {
          print('===============================fetchCallRecords=741=======================================');
          print(value.results![0].name.toString());
        }
        upcomingSessionCallRecords.value.results=value.results?.where((element) => element.status=='pending').toList();
        completedSessionCallRecords.value.results=value.results?.where((element) => element.status=='completed').toList();
        cancelledSessionCallRecords.value.results=value.results?.where((element) => element.status=='cancel').toList();
      }
    });
  }
  }

   Future getDoctorById({required String doctorId,String? appointmentId})async{
     await callRecordsProvider.fetchDoctorById(doctorId: doctorId,appointmentId: appointmentId);
  }

}
