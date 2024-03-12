import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../appWidgets/appBar.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../../views/views/subscription_related_faqs_view.dart';
import '../controllers/help_desk_page_controller.dart';

class HelpDeskPageView extends GetView<HelpDeskPageController> {
  const HelpDeskPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller=HelpDeskPageController();
    TextEditingController searchController=TextEditingController();
    List<Map<String, String>> paymentOptions = [
      {
        "title": "ramusingh008@gmail.com",
        "iconUrl": "assets/contact_us/dashicons_email-alt.png",
      },
      {
        "title": "+91-85968578577",
        "iconUrl": "assets/contact_us/bi_phone-vibrate-fill.png",
      },
      {
        "title": "facebook/582.profile.com",
        "iconUrl": "assets/contact_us/ic_round-facebook.png",
      },
      {
        "title": "8758Ram nagar, Sindhi village, noonriver, 130-fit road, govind nagar",
        "iconUrl": "assets/contact_us/ci_location.png",
      },
    ];
    return Scaffold(
        appBar: CustomUniversalAppBar(title: 'Help Desk', appBar: AppBar(),),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text('How can we help you ?'.tr,style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),),
                    const SizedBox(height: 40,),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffF3F3F4),
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 11.0),
                      child: ListTile(
                        onTap: ()async {
                          var whatsapp = "+918083434142";
                          var whatsappAndroid =Uri.parse(
                              "whatsapp://send?phone=$whatsapp&text=Hello Bikram Singh, This is to inform you that our whatsapp chatSupport is now working perfectly!");
                          if (await launchUrl(whatsappAndroid)) {
                            launchUrl(whatsappAndroid);
                          }else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "WhatsApp is not installed on the device"),
                              ),
                            );
                          }
                        },
                        // {
                        //   helpSupportController.whatsappChatSupport(context);
                        //   // Get.to(()=>ChatSupportView());
                        // },
                        horizontalTitleGap: 1.0,
                        contentPadding: EdgeInsets.all(1.0),
                        leading: Icon(Icons.message,),
                        trailing: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.arrow_forward_ios_sharp,)),
                        title: Text("Chat Support".tr),

                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffF3F3F4),
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 11.0),
                      child: ListTile(
                        onTap: ()=> controller.launchDialer(),
                        horizontalTitleGap: 1.0,
                        contentPadding: EdgeInsets.all(1.0),
                        leading: Icon(Icons.call,),
                        trailing: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.arrow_forward_ios_sharp,)),
                        title: Text("Call Support".tr),

                      ),
                    ),
                    SizedBox(height: 20,),
                    SizedBox(height: 40,),
                    InkWell(
                      onTap: ()=>controller.launchEmail(),
                      child: Ink(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius:30,
                              backgroundColor: AppColors.appThemeColor,
                              child: Icon(Icons.mail_outline,color: Colors.white,size: 28,),),
                            Text("or mail us at".tr,style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                            ),),
                            Text("hello@seekme.io",style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                            ),),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
    );
    // return Scaffold(
    //   appBar: CustomUniversalAppBar(title: 'Help Desk', appBar: AppBar(),),
    //   body: ListView(
    //     padding: EdgeInsets.all(18.0),
    //     children: [
    //       TextFormField(
    //         autofocus: false,
    //         controller: searchController,
    //         keyboardType: TextInputType.text,
    //         validator: (val) {
    //           if (val!.isEmpty) {
    //             return 'Please Enter a valid input';
    //           }
    //         },
    //         style: TextStyle(
    //           fontSize: 16,
    //           fontWeight: FontWeight.w400,
    //           color: AppColors.blackishTextColor,
    //         ),
    //         cursorColor: AppColors.blackishTextColor,
    //         decoration: InputDecoration(
    //           suffixIcon: Icon(Icons.search_sharp,color: AppColors.greyTextColor,),
    //             hintText: 'What are you looking for?' ,
    //             labelStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color:AppColors.lightGreyTextColor),
    //             focusedBorder: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(10.0),
    //                 borderSide: BorderSide(
    //                   color: AppColors.lightGreyTextColor.withOpacity(0.5),
    //                   width: 1.5,
    //                 )),
    //             enabledBorder: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(10.0),
    //                 borderSide: BorderSide(
    //                   color: AppColors.lightGreyTextColor.withOpacity(0.5),
    //                   width: 1.5,
    //                 ))
    //         ),
    //
    //       ),
    //       Expanded(
    //         child: ListView.builder(
    //             padding: EdgeInsets.symmetric(vertical: 18.0),
    //           physics: NeverScrollableScrollPhysics(),
    //           shrinkWrap: true,
    //             itemCount: 5,
    //             itemBuilder: (context,index){
    //           return Column(
    //             children: [
    //               ListTile(
    //                 onTap: (){
    //                   Get.to(()=>SubscriptionRelatedFaqsView());
    //                 },
    //                 contentPadding: EdgeInsets.zero,
    //                 title: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text16by700(text: 'Subscription Related',color: AppColors.bluishTextColor,),
    //                     Text14by400(text: 'Changing talk therapist, Rescheduling session, I missed a session, Contacting talk therapist.',
    //                       color: AppColors.counsellingTextColor,)
    //                   ],
    //                 ),
    //                 trailing: Icon(Icons.navigate_next_outlined,color: AppColors.bluishTextColor,),
    //               ),
    //               Divider(height: 10,)
    //             ],
    //           );
    //         }),
    //       ),
    //     ],
    //   ),
    // );
  }
}
