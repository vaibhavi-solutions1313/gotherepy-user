import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/modules/home/controllers/home_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../../app_model/therapists.dart';
import '../../counselors_page/views/counselor_profile_view.dart';
import '../controllers/doctor_list_view_controller.dart';

class DoctorListPageView extends GetView<DoctorListViewController> {
  final Rx<Therapists>? allTherapist;
  final String? appbarTitle;
  final bool showBackButton;
  const DoctorListPageView({Key? key,this.allTherapist, this.showBackButton=true,this.appbarTitle='Connect with our experts', }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DoctorListViewController controller=Get.put(DoctorListViewController());
    return Scaffold(
      appBar: CustomUniversalAppBar(title:appbarTitle.toString(), appBar: AppBar(),showBackButton: showBackButton),
      body: Obx(() => Column(
        children: [
          if(Get.find<HomeController>().doctorType.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:  Row(
                children: List.generate(
                    Get.find<HomeController>().doctorType.length, (index) =>  Padding(
                  padding: const EdgeInsets.only(top: 6.0,right: 8.0,bottom: 6.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.0),
                    onTap: (){
                      controller.doctorId.value=Get.find<HomeController>().doctorType[index]['id'].toString();
                      controller.update();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 6.0),
                      // width: Get.width*0.4,
                      decoration: BoxDecoration(
                          color: AppColors.appThemeColor.withOpacity(controller.doctorId.value==Get.find<HomeController>().doctorType[index]['id'].toString()?0.6:0.2),
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(Get.find<HomeController>().doctorType.length-index==1?0.0:16.0),
                              left: Radius.circular(index==0?0.0:16.0)
                          ),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0.4, 3.0),
                            blurRadius: 2.0,
                            spreadRadius: 1.0,
                            color: Colors.grey.withOpacity(0.5)
                          ),
                        ]
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(radius: 12,),
                          SizedBox(width: 6.0,),
                          Text16by400(text: Get.find<HomeController>().doctorType[index]['doctor_type'].toString(),fontSize: 14,maxLine: 2),
                        ],
                      ),
                    ),
                  ),
                )),
              ),
              // child: ListView.builder(
              //   scrollDirection: Axis.horizontal,
              //   itemCount: Get.find<HomeController>().doctorType.length,
              //     shrinkWrap: true,
              //     itemBuilder: (context,index){
              //     return Padding(
              //       padding: const EdgeInsets.only(right: 8.0),
              //       child: Container(
              //         width: Get.width*0.4,
              //         decoration: BoxDecoration(
              //           color: Colors.deepPurpleAccent
              //         ),
              //         child: Row(
              //           children: [
              //            const CircleAvatar(),
              //             Text16by400(text: Get.find<HomeController>().doctorType[index]['doctor_type'].toString(),fontSize: 14,maxLine: 2),
              //           ],
              //         ),
              //       ),
              //     );
              //     }),
            ),
          Expanded(
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
                                Get.to(()=>CounselorProfileView(therapist: data[index],));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                decoration:
                                const BoxDecoration(color: AppColors.tealColor, borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0))),
                                child: const Row(
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
        ],
      )),
    );
  }
}
