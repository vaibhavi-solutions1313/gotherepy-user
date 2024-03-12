import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/modules/counselling_page/bindings/counselling_page_binding.dart';
import 'package:gotherepy/app/modules/counselors_page/bindings/counselors_page_binding.dart';
import 'package:gotherepy/main.dart';
import 'package:http/http.dart' as http;
import '../../../app_constants/constants_end_points.dart';
import '../../counselors_page/views/slots_booking_page_view.dart';
import '../controllers/schedule_calls_page_controller.dart';
import '../session_model/call_session.dart';
import '../../../app_model/therapists.dart' as therapists_result;

class SessionCallRecordsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<CallSessionModel> fetchCallRecords(String userId) async {
    var headers = {'Authorization': 'Bearer ${EndPoints.accessToken}'};
    var request = http.MultipartRequest('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/get-user-sessions'));
    request.fields.addAll({'user_id': userId});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonDecodedData = jsonDecode(await response.stream.bytesToString());
       Get.find<ScheduleCallsPageController>().sessionCallRecords.value = CallSessionModel.fromJson(jsonDecodedData);
      print('===============================fetchCallRecords=743=======================================');
       print(jsonDecodedData);
      return Get.find<ScheduleCallsPageController>().sessionCallRecords.value;
    } else {
      print(response.reasonPhrase);
      return Get.find<ScheduleCallsPageController>().sessionCallRecords.value;
    }
  }

  Future fetchDoctorById({required String doctorId,String? appointmentId}) async {
    var headers = {'Authorization': 'Bearer ${EndPoints.accessToken}'};
    var request = http.MultipartRequest('POST', Uri.parse('http://gotherapy.care/backend/public/api/doctor/get-doctor-by-id'));
    request.fields.addAll({'id': doctorId});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonDecodedData = jsonDecode(await response.stream.bytesToString());
      therapists_result.Results doctorInfo = therapists_result.Results();
                if (kDebugMode) {
                  print('---------------------------doctor info-------------------------------');
                  print(jsonDecodedData.toString());
                }
      if(jsonDecodedData['results']!=null){
        doctorInfo = therapists_result.Results.fromJson(jsonDecodedData['results']);
        Get.to(() => SlotsBookingPageView(
          doctorInfo: doctorInfo,
          appointmentId: appointmentId,
        ),binding: CounselorsPageBinding());
      }else{
        Fluttertoast.showToast(msg: jsonDecodedData['msg']);
      }

    } else {
      print(response.reasonPhrase);
    }
  }
}
