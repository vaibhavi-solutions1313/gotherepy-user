import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/text_styles.dart';
import 'package:gotherepy/app/modules/plan_and_pricing/views/plan_container_view.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../wallet_page/views/wallet_page_view.dart';
import '../controllers/plan_and_pricing_controller.dart';
import 'package:http/http.dart'as http;

class PlanAndPricingView extends GetView<PlanAndPricingController> {
  const PlanAndPricingView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    PlanAndPricingController planAndPricingController=Get.put(PlanAndPricingController());
    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Plan & Pricing',appBar: AppBar(),showBackButton: true,),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(18.0),
        // shrinkWrap: true,
        children: [
          const Text16by600(text: 'Choose help, Not Suffering',color: AppColors.blackishTextColor,fontSize: 22,),
          FutureBuilder(
            future: planAndPricingController.plansList(),
            builder: (BuildContext context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return SizedBox(
                height: context.height-100,
                  child: Center(child: CircularProgressIndicator()));
            }else if(snapshot.hasError){
              return SizedBox(
                  height: context.height-100,
                  child: const Center(child: Text14by500(text: 'Failed to Load')));
            }else{
              return  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  const Text16by400(text: 'Counselling Therapy',fontSize: 18),
                  ListView.builder(
                    padding: EdgeInsets.only(top: 4.0),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 1,
                    // itemCount: snapshot.data['results'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return  InkWell(
                        onTap: (){
                          context.loaderOverlay.show();
                          planAndPricingController.getBalance().then((walletData) {
                            if(walletData['wallet_details']!=null && walletData['wallet_details'][0]['amount']<=snapshot.data['results'][index]['price']){
                              context.loaderOverlay.hide();
                              Get.to(()=>const WalletPageView());
                            }else{
                              context.loaderOverlay.hide();
                              planAndPricingController.startPayment(snapshot.data['results'][index]['price'].toString());
                            }
                          });

                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 16.0),
                            height: 120,
                            decoration: BoxDecoration(
                                color: AppColors.lightOrange,
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(1.0,1.0),
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 0.5,
                                      spreadRadius: 0.5
                                  )
                                ]
                            ),
                            child: CustomPaint(
                              size: Size(Get.width, (Get.width*0.4444444444444444).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                              painter: RPSPlanAndPricingCustomPainter(),
                              child:  Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text14by500(text: snapshot.data['results'][index]['plan'].toString(),fontSize: 16,color: AppColors.blackishTextColor,),
                                        Text14by400(text: '${snapshot.data['results'][index]['session_count']} Video/Audio Session',fontSize: 12,color: AppColors.blackishTextColor,),
                                        Text14by400(text: '${snapshot.data['results'][index]['chat_access']} Video/Audio/Chat Session',fontSize: 12,color: AppColors.blackishTextColor,),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text16by600(text: 'INR ${snapshot.data['results'][index]['price'].toString()}',fontSize: 12,color: Colors.black,),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
          },),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text16by400(text: 'Yoga Therapy',fontSize: 18),
              ListView.builder(
                padding: EdgeInsets.only(top: 4.0),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                // itemCount: snapshot.data['results'].length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                      context.loaderOverlay.show();
                      planAndPricingController.getBalance().then((walletData) {
                        if(walletData['wallet_details']!=null && walletData['wallet_details'][0]['amount']<=999){
                          context.loaderOverlay.hide();
                          Get.to(()=>const WalletPageView());
                        }else{
                          context.loaderOverlay.hide();
                          planAndPricingController.startPayment('999');
                        }
                      });

                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16.0),
                        height: 120,
                        decoration: BoxDecoration(
                            color: AppColors.lightGreen,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(1.0,1.0),
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 0.5,
                                  spreadRadius: 0.5
                              )
                            ]
                        ),
                        child: CustomPaint(
                          size: Size(Get.width, (Get.width*0.4444444444444444).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                          painter: RPSPlanAndPricingCustomPainter(),
                          child:  Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text14by500(text: 'Yoga plan',fontSize: 16,color: AppColors.blackishTextColor,),
                                    Text14by400(text: 'Video/Audio Session',fontSize: 12,color: AppColors.blackishTextColor,),
                                    Text14by400(text: 'Video/Audio/Chat Session',fontSize: 12,color: AppColors.blackishTextColor,),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text16by600(text: 'INR 999',fontSize: 12,color: AppColors.blackishTextColor,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text16by400(text: 'Buy Meditation Therapy',fontSize: 18),

      ListView.builder(
        padding: EdgeInsets.only(top: 4.0),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 1,
        // itemCount: snapshot.data['results'].length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              context.loaderOverlay.show();
              planAndPricingController.getBalance().then((walletData) {
                if(walletData['wallet_details']!=null && walletData['wallet_details'][0]['amount']<=999){
                  context.loaderOverlay.hide();
                  Get.to(()=>const WalletPageView());
                }else{
                  context.loaderOverlay.hide();
                  planAndPricingController.startPayment('999');
                }
              });

            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              child: Container(
                margin: EdgeInsets.only(bottom: 16.0),
                height: 120,
                decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1.0,1.0),
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 0.5,
                          spreadRadius: 0.5
                      )
                    ]
                ),
                child: CustomPaint(
                  size: Size(Get.width, (Get.width*0.4444444444444444).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: RPSPlanAndPricingCustomPainter(),
                  child:  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text14by500(text: 'Meditation plan',fontSize: 16,color: AppColors.blackishTextColor,),
                            Text14by400(text: 'Video/Audio Session',fontSize: 12,color: AppColors.blackishTextColor,),
                            Text14by400(text: 'Video/Audio/Chat Session',fontSize: 12,color: AppColors.blackishTextColor,),
                          ],
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text16by600(text: 'INR 999',fontSize: 12,color: AppColors.blackishTextColor,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )
            ],
          ),
        ],
      ),
    );
  }
}






