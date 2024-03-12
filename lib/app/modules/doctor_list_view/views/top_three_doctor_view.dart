import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/appButtons.dart';
import 'package:gotherepy/app/app_constants/constants_end_points.dart';
import 'package:gotherepy/app/modules/doctor_list_view/views/doctor_list_view_view.dart';
import 'package:gotherepy/app/modules/home/controllers/home_controller.dart';
import 'package:gotherepy/app/modules/profile_page/views/user_profile_view.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../../app_model/therapists.dart';
import '../../../app_model/topthreedoctorlist.dart';
import '../../counselors_page/views/counselor_profile_view.dart';
import '../../counselors_page/views/slots_booking_page_view.dart';
import '../controllers/doctor_list_view_controller.dart';

Future<TopThreeDoctorModel> fetchTopThreeDoctors(String doctorType) async {
  var topDoctorsByType=doctorType=='2'?'Yog Therapy':doctorType=='1'?'Meditation Therapy':'Counseling Therapy';
  var headers = {'Authorization': 'Bearer ${EndPoints.accessToken}', 'Content-Type': 'application/json'};

  var request = http.Request('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/get-top-doctor?profile_type=$topDoctorsByType'));
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var data = jsonDecode(await response.stream.bytesToString());
    if (data['results'] != null) {
      return TopThreeDoctorModel.fromJson(data);
    } else {
      return TopThreeDoctorModel(
        status: false,
        msg: 'No results available',
        results: [],
      );
    }
  } else {
    return TopThreeDoctorModel(
      status: false,
      msg: 'Failed to fetch data',
      results: [],
    );
  }
}


Future<Results> getDoctorById(String doctorId) async {
  var headers = {
    'Authorization': 'Bearer ${EndPoints.accessToken}'
  };
  var request = http.MultipartRequest('POST', Uri.parse('http://gotherapy.care/backend/public/api/doctor/get-doctor-by-id'));
  request.fields.addAll({
    'id': doctorId
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  Results abc=Results();
  if (response.statusCode == 200) {
    var json = jsonDecode(await response.stream.bytesToString());
    print(json.toString());
     abc=Results.fromJson(json['results']);
    return abc;
  }
  else {
    print(response.reasonPhrase);
    return abc;
  }

}

class TopThreeDoctorListPageView extends GetView<DoctorListViewController> {
  final String? appbarTitle;
  final bool showBackButton;
  final String categoryID;
  const TopThreeDoctorListPageView({
    Key? key,
    this.showBackButton = true,
    this.appbarTitle = 'Top Three Doctors',
    required this.categoryID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DoctorListViewController controller = Get.put(DoctorListViewController());
    Fluttertoast.showToast(msg: categoryID);
    return Scaffold(
      appBar: CustomUniversalAppBar(title: appbarTitle.toString(), appBar: AppBar(), showBackButton: showBackButton),
      body: Obx(() => Column(
            children: [
            Visibility(
                visible: controller.showAllDoctors.value,
                replacement: Expanded(
                  child: FutureBuilder<Rx<Therapists>>(future: Get.find<HomeController>().provider.fetchDoctorListByDoctorType(controller.doctorId.value), builder: (context,snapData){
                    if(snapData.connectionState==ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }else{
                      var data = snapData.data!.value.results;
                      return   data!=null && data.isNotEmpty?
                      ListView.builder(
                          padding: EdgeInsets.only(top: 6.0,bottom: 16.0),
                          // physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              // padding: EdgeInsets.only(left: 18.0,top: 18.0,right: 18.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.0),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0.5, 1),
                                        blurRadius: 1,
                                        spreadRadius: 1,
                                        color: AppColors.lightGreyTextColor.withOpacity(0.5)
                                    )
                                  ]
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
                                          flex:2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: CircularPercentIndicator(
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
                                              percent: 0.6,
                                              center: InkWell(
                                                onTap: () {
                                                  // Get.to(() => ChatPageView());
                                                },
                                                child: CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor: Colors.red,
                                                    child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(140.0),
                                                        child: Image.network(data[index].avatar!.isNotEmpty ? data[index].avatar!:''))),
                                              ),
                                              circularStrokeCap: CircularStrokeCap.round,
                                              startAngle: 150,
                                              backgroundColor: Colors.transparent,
                                              footer: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 6.0),
                                                    child: Icon(Icons.thumb_up, color: AppColors.greenColor, size: 14,),
                                                  ),
                                                  if( data[index].degree!=null)
                                                    Expanded(child: Text(data[index].degree!, style: TextStyle(color: AppColors.greyTextColor, fontSize: 12, fontWeight: FontWeight.w500,overflow: TextOverflow.ellipsis),maxLines: 2,))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex:5,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text14by400(text: data[index].username??''),

                                                  Text16by400(text: 'Specialization', fontSize: 12, color: AppColors.greyColor676464,),
                                                  Wrap(
                                                    spacing: 2.0,
                                                    runSpacing: 2.0,
                                                    children:
                                                    List.generate(data[index].specialization!.length>4?4:data[index].specialization!.length, (innerIndex) {
                                                      if(innerIndex>=3){
                                                        return Container(
                                                          padding: EdgeInsets.all(2.0),
                                                          child: Text16by400(text: '+ ${data[index].specialization!.length - 4}', fontSize: 10, color: AppColors.greyColor676464,maxLine: 3,),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              border: Border.all(color: Colors.black12)
                                                          ),
                                                        );
                                                      }
                                                      return Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 6.0,vertical: 1.0),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(12.0),
                                                            border: Border.all(color: Colors.black12)
                                                        ),
                                                        child:
                                                        Text16by400(text: data[index].specialization![innerIndex], fontSize: 10, color: AppColors.lightGreyTextColor,maxLine: 3,),
                                                      );
                                                    }),

                                                  ),
                                                  if(data[index].rate!=null)
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                                                      child: Text16by400(text: '₹ ${data[index].rate} /mins', fontSize: 12, color: AppColors.lightGreyTextColor,),
                                                    ),
                                                ],
                                              ),
                                              // Spacer(),
                                              if(data[index].title!=null &&  data[index].title!='')
                                                Container(
                                                  margin: EdgeInsets.symmetric(vertical: 6.0),
                                                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                                                  decoration: ShapeDecoration(shape: StadiumBorder(),
                                                      color: AppColors.containerColor
                                                  ),
                                                  child: Text14by400(text: data[index].title!, color: AppColors.lightGreyTextColor,maxLine: 2,),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    // onTap: () {
                                    //   context.loaderOverlay.show();
                                    //   WalletProvider().fetchWalletBalance().then((value) async {
                                    //     context.loaderOverlay.hide();
                                    //     var decodedData = jsonDecode(await value.stream.bytesToString());
                                    //     if (decodedData['wallet_details'] != null) {
                                    //       var walletBalance = num.parse(decodedData['wallet_details'][0]['amount'].toString());
                                    //       if (walletBalance < (30 * 300)) {
                                    //         Get.defaultDialog(
                                    //             titlePadding: EdgeInsets.zero,
                                    //             contentPadding: EdgeInsets.zero,
                                    //             title: '',
                                    //             middleText: '',
                                    //             content: Container(
                                    //               padding: EdgeInsets.symmetric(horizontal: 18.0),
                                    //               child: Column(
                                    //                 children: [
                                    //                   Icon(
                                    //                     Icons.warning_amber_rounded, size: 56, color: AppColors.greyTextColor,),
                                    //                   SizedBox(height: 10,),
                                    //                   Text16by600(text: 'Alert', fontSize: 20,),
                                    //                   SizedBox(height: 15,),
                                    //                   FooterTextWithCenterAligned(
                                    //                     text: 'You don’t have sufficient balance Minimum balance should for 15 min chat.', fontSize: 16,),
                                    //                   SizedBox(height: 10,),
                                    //                   CustomSolidButton(buttonText: 'Top Up Wallet', onClick: () {
                                    //                     Get.off(() => const WalletPageView());
                                    //                   }, fontSize: 16,)
                                    //                 ],
                                    //               ),
                                    //             )
                                    //         );
                                    //       } else {
                                    //         Get.to(() => const LiveCounselorView());
                                    //       }
                                    //
                                    //     } else {
                                    //       Get.defaultDialog(
                                    //           titlePadding: EdgeInsets.zero,
                                    //           contentPadding: EdgeInsets.zero,
                                    //           title: '',
                                    //           middleText: '',
                                    //           content: Container(
                                    //             padding: EdgeInsets.symmetric(horizontal: 18.0),
                                    //             child: Column(
                                    //               children: [
                                    //                 Icon(
                                    //                   Icons.warning_amber_rounded, size: 56, color: AppColors.greyTextColor,),
                                    //                 SizedBox(height: 10,),
                                    //                 Text16by600(text: 'Alert', fontSize: 20,),
                                    //                 SizedBox(height: 15,),
                                    //                 const FooterTextWithCenterAligned(
                                    //                   text: 'You don’t have sufficient balance Minimum balance of Rs${30 * 300} should for 15 min chat.', fontSize: 16,),
                                    //                 SizedBox(height: 10,),
                                    //                 CustomSolidButton(buttonText: 'Top Up Wallet', onClick: () {
                                    //                   Get.off(() => const WalletPageView());
                                    //                 }, fontSize: 16,)
                                    //               ],
                                    //             ),
                                    //           )
                                    //       );
                                    //     }
                                    //   });
                                    // },

                                    onTap:(){
                                      context.loaderOverlay.show();
                                      getDoctorById(categoryID).then((value){
                                        context.loaderOverlay.hide();
                                        if(value.name != null) {
                                          Get.to(()=>CounselorProfileView(therapist: value,));
                                        }
                                      }).onError((error, stackTrace) {
                                        context.loaderOverlay.hide();
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                      decoration:
                                      const BoxDecoration(color: AppColors.tealColor, borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0))),
                                      child:  Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          // Padding(
                                          //   padding: EdgeInsets.only(right: 6.0),
                                          //   child: Icon(
                                          //     Icons.message_rounded,
                                          //     size: 13,
                                          //   ),
                                          // ),
                                          Text(
                                            'See Details',
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
                          :Center(child: Column(
                        children: [
                          Text16by400(text: 'Not Available', fontSize: 12, color: AppColors.lightGreyTextColor,),
                        ],
                      ));
                    }

                  }),
                ),
                  child:  Expanded(
                    child: FutureBuilder<TopThreeDoctorModel>(
                        future: fetchTopThreeDoctors(categoryID),
                        builder: (context, snapData) {
                          if (snapData.connectionState == ConnectionState.waiting) {

                            return Center(child: CircularProgressIndicator());
                          } else {
                            print(snapData.data?.results.toString());
                            print(snapData.data.toString());
                            return snapData.data != null
                                ? ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                // physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapData.data!.results?.length,
                                itemBuilder: (context, index) {
                                  var data = snapData.data!.results![index];
                                  return Padding(
                                    padding: EdgeInsets.symmetric( vertical: 8.0),
                                    child: InkWell(
                                        onTap:(){
                                          context.loaderOverlay.show();
                                          getDoctorById(categoryID).then((value){
                                            context.loaderOverlay.hide();
                                            if(value.name != null) {
                                              Get.to(()=>CounselorProfileView(therapist: value,));
                                            }
                                          }).onError((error, stackTrace) {
                                            context.loaderOverlay.hide();
                                          });
                                        },
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Ink(
                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.0), boxShadow: [
                                          BoxShadow(offset: Offset(0.5, 1), blurRadius: 1, spreadRadius: 1, color: AppColors.lightGreyTextColor.withOpacity(0.5))
                                        ]),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(6.0),
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red.withOpacity(0.2),
                                                      borderRadius: BorderRadius.circular(16.0),
                                                      image: DecorationImage(image: NetworkImage(EndPoints.imageBaseUrl+data.avatar!))
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text14by500(text: data.fname??''),
                                                    Text14by500(text: data.review??''),
                                                    Row(
                                                      children: [
                                                        ...List.generate(5, (index){
                                                          return Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Icon(Icons.star,color: Colors.yellow,),
                                                            ],
                                                          );
                                                        }),
                                                        // const Text14by500(text: 'kjhkh',),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(4.0),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(16.0),
                                                gradient: LinearGradient(colors: [AppColors.appThemeColor,AppColors.whiteShadow],begin: Alignment.centerLeft,end: Alignment.centerRight),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text16by400(text: '${data.exp} Years of Experience'),
                                                  Material(
                                                    borderRadius: BorderRadius.circular(16.0),
                                                    child: InkWell(
                                                      onTap:(){
                                                        context.loaderOverlay.show();
                                                        getDoctorById(categoryID).then((value){
                                                          context.loaderOverlay.hide();
                                                          if(value.name != null) {
                                                            Get.to(()=>SlotsBookingPageView(doctorInfo: value,));
                                                          }
                                                        }).onError((error, stackTrace) {
                                                          context.loaderOverlay.hide();
                                                        });
                                                      },
                                                      borderRadius: BorderRadius.circular(16.0),
                                                      child: Ink(
                                                        padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 6.0),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(16.0),
                                                            boxShadow: const [
                                                              BoxShadow(offset: Offset(0.5, 0.5),
                                                                  spreadRadius: -0.2,
                                                                  blurRadius: 0.8,
                                                                  color: AppColors.appThemeColor
                                                              )
                                                            ],
                                                            color: AppColors.bluishColor
                                                        ),
                                                        child: Text('Book',style: TextStyle(color: Colors.white),),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
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
                          }
                        }),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const DoctorListPageView());
                  },
                  child: CustomSolidButton(buttonText: controller.showAllDoctors.value?'View All Doctors':'Top Doctors', onClick: () {
                    controller.showAllDoctors.toggle();
                  },),

                ),
              ),
            ],
          )),
    );
  }
}
