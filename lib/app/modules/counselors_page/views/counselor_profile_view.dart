import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/appButtons.dart';
import 'package:gotherepy/app/appWidgets/universalAppBar.dart';
import 'package:gotherepy/app/app_constants/constants_appColors.dart';
import 'package:gotherepy/app/modules/counselors_page/views/slots_booking_page_view.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_model/therapists.dart';
import '../../wallet_page/providers/wallet_provider.dart';
import '../../wallet_page/views/wallet_page_view.dart';
import '../controllers/counselors_page_controller.dart';

class CounselorProfileView extends GetView {
  final Results? therapist;
  const CounselorProfileView({this.therapist, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Rx<double> sliderValue=0.0.obs;
    final doctorInfoController=Get.put(CounselorsPageController());
   print(therapist);
    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Profile',showBackButton: true, appBar: AppBar(),),
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 8.sp),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25.sp),
                        child: Container(
                          width: 35.sp,
                          height: 35.sp,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                            image: therapist?.avatar!=null?DecorationImage(image: NetworkImage(therapist!.avatar!)):null
                          ),

                          child: therapist?.avatar==null?Center(child: Text(therapist?.name?.substring(1)??'')):null,
                        ),
                      ),
                      SizedBox(
                        width: 15.sp,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                therapist?.name ?? "NA",
                                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Counselling Psychologist",
                                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.black54),
                              ),
                              Row(
                                children: List.generate(
                                    5,
                                        (index) => Icon(
                                      Icons.star,
                                      color: AppColors.bluishColor, 
                                      size: 17.sp,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            border: Border.all(width: 1.5, color: Colors.green.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(25.sp)),
                        child: const Icon(
                          Icons.notifications,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                            color: AppColors.bluishColor.withOpacity(0.2),
                            border: Border.all(width: 1.5, color: AppColors.bluishColor.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(25.sp)),
                        child: Icon(
                          Icons.query_stats,
                          color: AppColors.bluishColor,
                        ),
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      Text(
                        "250 Sessions",
                        style: TextStyle(fontSize: 15.sp, color: Colors.black54),
                      ),
                      SizedBox(
                        width: 15.sp,
                      ),
                      Container(
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                            color: AppColors.bluishColor.withOpacity(0.2),
                            border: Border.all(width: 1.5, color: AppColors.bluishColor.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(25.sp)),
                        child: Icon(
                          Icons.backpack,
                          color: AppColors.bluishColor,
                        ),
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      Text(
                        "${therapist?.exp??'1'} yrs experience",
                        style: TextStyle(fontSize: 15.sp, color: Colors.black54),
                      ),
                    ],
                  ),
            
                  // CHAT AND BOOK SESSION VIEW BELOW
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.sp),
                    child: Container(
                      padding: EdgeInsets.all(15.sp),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12.sp),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.chat,
                                          color: AppColors.bluishColor,
                                        ),
                                        SizedBox(
                                          width: 15.sp,
                                        ),
                                        Text(
                                          "Chat",
                                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Connect with john doe for instant guidance.",
                                      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                               Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      "Starting at",
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "${therapist?.multipleSessionPrices!=null && therapist?.multipleSessionPrices!.chatSession!=null?therapist?.multipleSessionPrices!.chatSession![0].chatSessionPrice:'N/A'}",
                                      style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.bluishColor),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          color: AppColors.bluishColor,
                                        ),
                                        SizedBox(
                                          width: 15.sp,
                                        ),
                                        Text(
                                          "Book Session",
                                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Book a personal audio/video session for in-depth guidance.",
                                      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${therapist?.multipleSessionPrices!=null && therapist?.multipleSessionPrices!.callSession!=null?therapist?.multipleSessionPrices!.callSession![0].sessionCount:'N/A'}",
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "${therapist?.multipleSessionPrices!=null && therapist?.multipleSessionPrices!.callSession!=null?therapist?.multipleSessionPrices!.callSession![0].sessionPrice:"N/A"}",
                                      style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.bluishColor),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
            
                  // WHAT CAN YOU ASK ME VIEW BELOW
                  // Text(
                  //   "What can you ask me",
                  //   style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  // ),
                  // SizedBox(
                  //   height: 10.sp,
                  // ),
                  // Column(
                  //   children: [
                  //     Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Icon(
                  //           Icons.format_quote_outlined,
                  //           color: AppColors.bluishColor,
                  //         ),
                  //         SizedBox(
                  //           width: 8.sp,
                  //         ),
                  //         Expanded(
                  //             child: Text(
                  //               "How do i manage my emotions and thoughts?",
                  //               style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  //             ))
                  //       ],
                  //     ),
                  //     SizedBox(
                  //       height: 10.sp,
                  //     ),
                  //     Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Icon(
                  //           Icons.format_quote_outlined,
                  //           color: AppColors.bluishColor,
                  //         ),
                  //         SizedBox(
                  //           width: 8.sp,
                  //         ),
                  //         Expanded(
                  //             child: Text(
                  //               "How do i achieve a better work-life balance and manage stress?",
                  //               style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  //             ))
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 15.sp,
                  // ),
                  Text(
                    "Who can reach out to me",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  Wrap(
                    children: [
                      ...List.generate(therapist!.tags!.split(',').length, (index) => Container(
                          margin: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(color: AppColors.bluishColor.withOpacity(0.2), borderRadius: BorderRadius.circular(12.sp)),
                          padding: EdgeInsets.all(10.sp),
                          child: Text(
                              therapist!.tags!.split(',')[index].trim(),
                            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: AppColors.bluishColor),
                          ))),
                    ],
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Text(
                    "Who can I help you achieve",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.border_inner_rounded,
                              color: Colors.black38,
                            ),
                            Text(
                              "Emotional \nBalance",
                              style: TextStyle(color: Colors.black87),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 25.sp,
                        width: 2.sp,
                        color: Colors.black38,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cruelty_free,
                              color: Colors.black38,
                            ),
                            Text(
                              "Trauma \nBalance",
                              style: TextStyle(color: Colors.black87),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 25.sp,
                        width: 2.sp,
                        color: Colors.black38,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.heart_broken,
                              color: Colors.black38,
                            ),
                            Text(
                              "Relationship Problems",
                              style: TextStyle(color: Colors.black87),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Text(
                    "About",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(therapist!.description!,style: TextStyle(
                    fontSize: 14,color: AppColors.bluishColor
                  ),textAlign: TextAlign.justify,),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Text(
                    "User Review",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(offset: Offset(0.4, 0.4),
                        spreadRadius: -0.6,
                        blurRadius: 0.9,
                        color: Colors.black54)
                      ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('4.2/5',style: TextStyle(fontSize: 21.sp),),
                        Row(children: List.generate(5, (index) => Icon(Icons.star,color: Colors.yellow,))),
                        SizedBox(
                          height: 15.sp,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('5',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w600),),
                                SizedBox(width: 10.sp,),
                                Icon(Icons.star_rate,color: AppColors.bluishColor,),
                                Expanded(child: LinearProgressIndicator(value: 0.7,minHeight: 3,)),
                                // Icon(Icons.star,color: Colors.red),
                              ],
                            ),
                            Row(
                              children: [
                                Text('4',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w600),),
                                SizedBox(width: 10.sp,),
                                Icon(Icons.star_rate,color: AppColors.bluishColor,),
                                Expanded(child: LinearProgressIndicator(value: 0.6,minHeight: 3,)),
                                // Icon(Icons.star,color: Colors.red),
                              ],
                            ),
                            Row(
                              children: [
                                Text('3',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w600),),
                                SizedBox(width: 10.sp,),
                                Icon(Icons.star_rate,color: AppColors.bluishColor,),
                                Expanded(child: LinearProgressIndicator(value: 0.4,minHeight: 3,)),
                                // Icon(Icons.star,color: Colors.red),
                              ],
                            ),
                            Row(
                              children: [
                                Text('2',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w600),),
                                SizedBox(width: 10.sp,),
                                Icon(Icons.star_rate,color: AppColors.bluishColor,),
                                Expanded(child: LinearProgressIndicator(value: 0.3,minHeight: 3,)),
                                // Icon(Icons.star,color: Colors.red),
                              ],
                            ),
                            Row(
                              children: [
                                Text('1',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w600),),
                                SizedBox(width: 10.sp,),
                                Icon(Icons.star_rate,color: AppColors.bluishColor,),
                                Expanded(child: LinearProgressIndicator(value: 0.1,minHeight: 3,)),
                                // Icon(Icons.star,color: Colors.red),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              CircleAvatar(child: Text('E'),),
                              SizedBox(width: 6.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Shivani Ramakrishna'),
                                  Text('30 Oct, 2023'),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(5, (index) => Icon(Icons.star,color: Colors.red,)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      const Text('The session is amazing'),
                      const Divider()
                    ],
                  ),
                  // SizedBox(height: 200,)
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0.sp),
            decoration: BoxDecoration(
                color: AppColors.appThemeColor.withOpacity(0.2),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.sp))
            ),
            child: Row(
              children: [
                Expanded(child: BorderButton(buttonText: 'Book', onClick: (){
                  if(therapist!=null && therapist?.multipleSessionPrices!=null && therapist!.multipleSessionPrices!.callSession!.isNotEmpty){
                    Get.to(()=>SlotsBookingPageView(doctorInfo: therapist!,));
                  }else{
                    Fluttertoast.showToast(msg: 'Doctor prices are not available to book');
                  }
                },)),
                const SizedBox(width: 16.0,),
                Expanded(child: CustomSolidButton(buttonText: 'Chat', onClick: () {
                  if(therapist!=null && therapist?.multipleSessionPrices!=null && therapist!.multipleSessionPrices!.chatSession!.isNotEmpty) {
                    Get.bottomSheet(
                        backgroundColor: Colors.white,
                        elevation: 2.0,
                        isDismissible: true,
                        Container(
                          padding: const EdgeInsets.all(18.0),
                          decoration: const BoxDecoration(
                            // color: Colors.white,
                            // borderRadius: BorderRadius.vertical(top: Radius.circular(32.0))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('For how long do you want to talk?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),),
                              const SizedBox(height: 20,),
                                  if(therapist!=null && therapist!.multipleSessionPrices!=null && therapist!.multipleSessionPrices!.chatSession!=null)
                                  Wrap(
                                    runSpacing: 6.0,
                                    spacing: 16.0,
                                    direction: Axis.horizontal,
                                    alignment: WrapAlignment.start,
                                    runAlignment: WrapAlignment.start,
                                    children: List.generate(therapist!.multipleSessionPrices!.chatSession!.length, (index) =>
                                        Obx(() => InkWell(
                                      onTap: () {
                                        doctorInfoController.selectedChatSession.value=therapist!.multipleSessionPrices!.chatSession![index];
                                        doctorInfoController.selectedSlotPrice.value = therapist!.multipleSessionPrices!.chatSession![index].priceAfterAllExcludedTaxes!.toString();
                                      },
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 60,
                                            maxWidth: 80,
                                            maxHeight: 40,
                                            minHeight: 40
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12.0),
                                            color: doctorInfoController.selectedSlotPrice.value == therapist!.multipleSessionPrices!.chatSession![index].priceAfterAllExcludedTaxes!.toString() ? AppColors.bluishColor.withOpacity(0.2) : Colors.white,
                                            border: Border.all(color: Colors.deepOrange, width: 0.5),
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(0.5, 0.5),
                                                  spreadRadius: -0.8,
                                                  blurRadius: 2.0,
                                                  color: Colors.tealAccent.shade100.withOpacity(0.4)
                                              )
                                            ]
                                        ),
                                        child: Center(child: Text(therapist!.multipleSessionPrices!.chatSession![index].durationInMinutes??'N/A', style: TextStyle(color: Colors.deepOrange),)),
                                      ),
                                    ))),
                                  ),

                              SizedBox(height: 20,),

                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.green.withOpacity(0.2),
                                ),
                                child: Center(child: Row(
                                  children: [
                                    // Icon(Icons.percent_rounded,color: Colors.green,),
                                    // SizedBox(width: 6.0,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Get 20% off on First chat.', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                                        RichText(text: TextSpan(text: 'use code:', style: TextStyle(color: Colors.green),
                                            children: [
                                              TextSpan(text: 'SOL1313', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),)
                                            ]),),
                                      ],
                                    ),
                                  ],
                                )),
                              ),
                              SizedBox(height: 10,),
                              Divider(height: 2,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total Amount: '),
                                  Obx(() =>
                                      Text('${doctorInfoController.selectedSlotPrice.value}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),)),
                                ],
                              ),
                              Spacer(),
                              CustomSolidButton(buttonText: 'Start now', onClick: () async{
                                if (therapist != null && therapist?.doctorId != null) {
                                  if(doctorInfoController.selectedChatSession.value.priceAfterAllExcludedTaxes!=null){
                                    context.loaderOverlay.show();
                                    Get.back();
                                    await WalletProvider().fetchWalletBalance().then((value) async {
                                      context.loaderOverlay.hide();
                                      var decodedData = jsonDecode(await value.stream.bytesToString());
                                      if (decodedData['wallet_details'] != null) {
                                        var walletBalance = num.parse(decodedData['wallet_details'][0]['amount'].toString());
                                        //TODO

                                        if (walletBalance < doctorInfoController.selectedChatSession.value.priceAfterAllExcludedTaxes!) {

                                          Get.defaultDialog(
                                              titlePadding: EdgeInsets.zero,
                                              contentPadding: EdgeInsets.zero,
                                              title: '',
                                              middleText: '',
                                              content: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 18.0),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.warning_amber_rounded,
                                                      size: 56,
                                                      color: AppColors.greyTextColor,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text16by600(
                                                      text: 'Alert',
                                                      fontSize: 20,
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    FooterTextWithCenterAligned(
                                                      text: 'You don’t have sufficient balance to book this doctor, Minimum balance of Rs${doctorInfoController.selectedSlotPrice.value} required to book him/her',
                                                      fontSize: 16,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    CustomSolidButton(
                                                      buttonText: 'Top Up Wallet',
                                                      onClick: () {
                                                        Get.off(() => const WalletPageView());
                                                      },
                                                      fontSize: 16,
                                                    )
                                                  ],
                                                ),
                                              ));
                                        } else {
                                          await Get.find<CounselorsPageController>()
                                              .bookChatAppointment(context,chatTime: doctorInfoController.selectedChatSession.value.durationInMinutes.toString(), doctorId: therapist!.doctorId!, amount: doctorInfoController.selectedChatSession.value.priceAfterAllExcludedTaxes.toString());
                                        }
                                      } else {
                                        context.loaderOverlay.hide();
                                        Get.defaultDialog(
                                            titlePadding: EdgeInsets.zero,
                                            contentPadding: EdgeInsets.zero,
                                            title: '',
                                            middleText: '',
                                            content: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 18.0),
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    Icons.warning_amber_rounded,
                                                    size: 56,
                                                    color: AppColors.greyTextColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Text16by600(
                                                    text: 'Alert',
                                                    fontSize: 20,
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  FooterTextWithCenterAligned(
                                                    text: 'You don’t have sufficient balance to book this doctor, Minimum balance of Rs${doctorInfoController.selectedChatSession.value.priceAfterAllExcludedTaxes} required to book him/her.',
                                                    fontSize: 16,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  CustomSolidButton(
                                                    buttonText: 'Top Up Wallet',
                                                    onClick: () {
                                                      Get.off(() => const WalletPageView());
                                                    },
                                                    fontSize: 16,
                                                  )
                                                ],
                                              ),
                                            ));
                                      }
                                    });
                                  } else {
                                    Fluttertoast.showToast(msg: 'Select chat session.');
                                  }
                                } else {
                                  Fluttertoast.showToast(msg: 'Doctor not available.');
                                }


                              },),
                            ],
                          ),
                        ));
                  }else{
                    Fluttertoast.showToast(msg: 'This doctor is not available for chat.');
                  }
                },)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
