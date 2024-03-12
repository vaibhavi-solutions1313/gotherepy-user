import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/appButtons.dart';
import 'package:gotherepy/app/appWidgets/appTextField.dart';
import 'package:gotherepy/app/appWidgets/text_styles.dart';
import 'package:gotherepy/app/app_constants/constants_end_points.dart';
import 'package:http/http.dart'as http;
import 'package:loader_overlay/loader_overlay.dart';
import '../../appWidgets/universalAppBar.dart';

class DailyAffirmationView extends GetView {
  const DailyAffirmationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future callApi()async{
      var headers = {
        'Authorization': 'Bearer ${EndPoints.accessToken}'
      };
      var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/user/get-affirmation-questions'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
        var decodedData=jsonDecode(await response.stream.bytesToString());
        return decodedData['results'];
    }
    TextEditingController nameTextController=TextEditingController();
    return Scaffold(
      appBar:CustomUniversalAppBar(title: 'Daily Affirmations',appBar: AppBar(),),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 6.0),
        children: [
          FutureBuilder(
            future: callApi(),
              builder: (context,snapData){
            if(snapData.connectionState==ConnectionState.waiting){
              return SizedBox(
                  height: Get.height-100,
                  child: Center(child: const CircularProgressIndicator()));
            }else{
              return snapData.data.length!=null
                  ?Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(snapData.data.length, (index) =>
                    CustomCircularBorderTextFieldWithHintTextAndTitle(
                  textEditingController: nameTextController,
                  title: snapData.data[index]['questions'].toString(),
                  hintText: 'Something....',
                  readOnly: false,)),
                CustomSolidButton(buttonText: 'Save', onClick: ()async{
                  context.loaderOverlay.show();
                  await Future.delayed(Duration(seconds: 4),(){
                    Fluttertoast.showToast(msg: 'Answer Saved');
                    context.loaderOverlay.hide();
                  });
                })
                ]
              )
                  : SizedBox(
                  height: Get.height-100,
                  child: const Center(child: Text14by500(text: 'No Data Available')));
            }
          }),
        ],
      ),
    );
  }
}
