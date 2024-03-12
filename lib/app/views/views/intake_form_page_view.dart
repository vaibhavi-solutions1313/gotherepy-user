import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/text_styles.dart';
import 'package:gotherepy/app/app_constants/constants_end_points.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../appWidgets/appButtons.dart';
import '../../appWidgets/universalAppBar.dart';
import '../../app_model/therapists.dart';
import '../../modules/counselors_page/views/counselors_page_view.dart';
import 'package:http/http.dart' as http;

import '../../modules/counselors_page/views/slots_booking_page_view.dart';
import 'health_score_view_view.dart';

List<Map> selectedItems = [];

class IntakeFormPageView extends GetView {
  final Results? therapist;
  final String? categoryId;

  const IntakeFormPageView({
    this.therapist,
    Key? key,
    this.categoryId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future callApi({required String categoryId}) async {
      var headers = {'Authorization': 'Bearer ${EndPoints.accessToken}'};

      var request = http.MultipartRequest('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/get-intake-que-ans'));
      request.fields.addAll({'category_id': categoryId});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      var decodedData = jsonDecode(await response.stream.bytesToString());

      return decodedData;
    }

    Future<http.StreamedResponse> submitTherapyForm({required List<int> selectedAnswers, required String quizType}) async {
      var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer ${EndPoints.accessToken}'};
      var request = http.Request('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/submit-quiz'));
      request.body = json.encode({
        "options": selectedAnswers,
        "quiz_type": quizType
      });
      print(request.body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      return response;
    }
    print('vikram');
    print(categoryId.toString());
    return Scaffold(
      appBar: CustomUniversalAppBar(
        title: 'Therapy Intake Form',
        appBar: AppBar(),
        showBackButton: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          FutureBuilder(
              future: callApi(categoryId: therapist != null ? therapist!.doctorType.toString() : categoryId.toString()),
              builder: (context, snapData) {
                if (snapData.connectionState == ConnectionState.waiting) {
                  return SizedBox(height: Get.height - 100, child: const Center(child: CircularProgressIndicator()));
                } else if (snapData.hasError) {
                  return Text('Failed to Load');
                } else {
                  return Column(
                    children: [
                      ...List.generate(
                          snapData.data['results'].length,
                          (index) => Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text16by400(
                                      text: (index + 1).toString() + '. ' + snapData.data['results'][index]['question']['questions'].toString(), maxLine: 5),
                                  snapData.data['results'][index]['isForm'] == 0
                                      ? Container(
                                          margin: EdgeInsets.only(bottom: 16.0, top: 6.0),
                                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                                          decoration:
                                              BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.0), border: Border.all(width: 0.5)),
                                          child: MyExpansionTile(
                                              questionIndex: index,
                                              // title: snapData.data['results'][index]['answers'].isNotEmpty
                                              //     ? snapData.data['results'][index]['answers'][0]['answer'].toString()
                                              //     : '',
                                              data: snapData.data['results'][index]),
                                        )
                                      : Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: TextField(
                                            decoration: InputDecoration(
                                                filled: true,
                                              border: OutlineInputBorder(borderRadius:const BorderRadius.all(Radius.circular(20.0)) ),
                                              hintText: 'Your answer...'
                                            ),
                                          ),
                                      ),
                                ],
                              )),
                      CustomSolidButton(
                          buttonText: 'Submit',
                          onClick: () {
                            if(selectedItems.isNotEmpty) {
                              context.loaderOverlay.show();
                              List<int> options = [];
                              selectedItems.forEach((element) {
                                options.add(element['selectedOption']);
                              });
                              num totalScore=0;
                              for(var x in snapData.data['results']){
                                if(x['isForm'] == 0) {
                                  totalScore = totalScore + x['answers'].length;
                                }
                              }
                              submitTherapyForm(selectedAnswers: options, quizType: snapData.data['msg']).then((responseData) async {
                                context.loaderOverlay.hide();
                                try {
                                  var decodedData = jsonDecode(await responseData.stream.bytesToString());
                                  if (decodedData['status'] == true) {
                                    selectedItems.clear();
                                    Get.to(
                                            () => HealthScoreViewView(
                                          data: decodedData, totalScore: totalScore,categoryId: categoryId.toString(),
                                        ),
                                        fullscreenDialog: true);
                                  } else {
                                    Fluttertoast.showToast(msg: decodedData['message'].toString());
                                  }
                                } on Exception catch (e) {
                                  Fluttertoast.showToast(msg: e.toString());
                                  // Get.to(() => const CounselorsPageView());
                                }
                              });
                            } else {
                              print("select atleast 1");
                            }

                          })
                    ],
                  );
                }
              }),
        ],
      ),
    );
  }
}

class MyExpansionTile extends StatefulWidget {
  final String title;
  final int questionIndex;
  final dynamic data;
  const MyExpansionTile({super.key, this.title = "Select", this.data, required this.questionIndex});

  @override
  State<MyExpansionTile> createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  String answerTitle = "";

  @override
  void initState() {
    answerTitle = widget.title;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        expandedAlignment: Alignment.centerLeft,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),

        title: Text(answerTitle),
        children: List.generate(
          widget.data['answers'].length,
          (optionIndex) => CustomSolidButton(
            onClick: () {
              answerTitle = widget.data['answers'][optionIndex]['answer'];

              // REMOVE IF ALREADY EXISTS
              try {
                selectedItems.removeWhere((element) => element['indexNumber'] == widget.questionIndex);
              } catch (e) {
                // TODO
              }
              selectedItems.add({'indexNumber': widget.questionIndex, "selectedOption": optionIndex});
              setState(() {});
              print(selectedItems);
            },
            buttonText: widget.data['answers'][optionIndex]['answer'],
            boxColor: Colors.teal.withOpacity(0.1),
            textColor: Colors.black54,
          ),
        ));
  }
}
