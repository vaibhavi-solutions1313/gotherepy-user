import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/appButtons.dart';
import 'package:gotherepy/app/appWidgets/text_styles.dart';
import 'package:gotherepy/app/modules/journal_page/providers/journal_provider.dart';
import 'package:gotherepy/app/modules/journal_page/views/create_new_journal_page_view.dart';
import 'package:gotherepy/main.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:math' as math;
import '../../../appWidgets/appTextField.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../../app_constants/constants_end_points.dart';
import '../../chat_page/chat_list_model/chat_list_model.dart';
import '../../counselors_page/views/chat_conversation_view.dart';
import '../controllers/journsal_page_controller.dart';


class JournalPageView extends GetView<JournalPageController> {
  const JournalPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(JournalPageController());
    return Scaffold(
      appBar: CustomUniversalAppBar(
        title: 'Journal',
        // title:'Hi ${userInfo.userData.value.results?.firstName??'User'}',
        appBar: AppBar(),),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Obx(() => controller.refreshJournal.value? const Row():Expanded(
              child: FutureBuilder(
                  future: JournalProvider().getJournalNotes(),
                  builder: (context, snapData){
                    if(snapData.connectionState==ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    if(snapData.hasError){
                      print(snapData.error);
                      return const Text14by500(text: 'Unable to load');
                    }
                    if(snapData.hasData){

                      if(snapData.data!=null) {
                        return ListView(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text('Select All',style: TextStyle(color: Colors.blue),),
                                Obx(() => Checkbox(value: controller.isSelectedAll.value, onChanged: (val){
                                  controller.isSelectedAll.value=!controller.isSelectedAll.value;
                                }),)
                              ],
                            ),
                            MasonryGridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                              shrinkWrap: true,
                              itemCount: snapData.data.length,
                              // itemCount: controller.newNotesList.length,
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0), color: Color((math.Random().nextDouble() * 0xFFFFFE).toInt()).withOpacity(0.2)),
                                  // height: (math.Random().nextInt(300)).toDouble(),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  snapData.data[index]['date'].toString(),
                                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),maxLines: 2,
                                                ),
                                              ),
                                             Obx(() =>  Checkbox(value: controller.isSelectedAll.value, onChanged: (val){
                                               controller.isSelectedAll.value=!controller.isSelectedAll.value;
                                             }))
                                            ],
                                          ),
                                          Text(snapData.data[index]['journal']['answer'].toString(),
                                              style: TextStyle(
                                                color: AppColors.greyColor2F2F2F.withOpacity(0.8),
                                                fontSize: 14,
                                              )),
                                          const SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                controller.editNotes.text = snapData.data[index]['journal']['answer'].toString();
                                                Get.dialog(Material(
                                                  child: Container(
                                                    margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                                                    decoration: const BoxDecoration(color: Colors.white),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        CustomTextFieldWithoutBorderAndHeading(
                                                          textEditingController: controller.editNotes,
                                                          hintText: snapData.data[index]['journal']['answer'].toString(),
                                                          maxLine: 3,
                                                        ),
                                                        CustomSolidButton(
                                                            buttonText: 'Save',
                                                            onClick: () {
                                                              if(controller.editNotes.text.isNotEmpty){
                                                                context.loaderOverlay.show();
                                                                controller.journalProvider.updateNotes(snapData.data[index]['journal']['id'],controller.editNotes.text).whenComplete(() {
                                                                  Get.back();
                                                                  controller.editNotes.clear();
                                                                  controller.refreshJournal.value=!controller.refreshJournal.value;
                                                                  controller.refreshJournal.value=!controller.refreshJournal.value;
                                                                  context.loaderOverlay.hide();
                                                                });
                                                              }
                                                            })
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                              },
                                              borderRadius: BorderRadius.circular(30.0),
                                              child: const Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: AppColors.tealColor,
                                                ),
                                              )),
                                          InkWell(
                                              onTap: () {
                                                context.loaderOverlay.show();
                                                print(snapData.data[index].toString());
                                                controller.journalProvider.deleteNotes(snapData.data[index]['journal']['id']).whenComplete(() {
                                                  controller.refreshJournal.value=!controller.refreshJournal.value;
                                                  controller.refreshJournal.value=!controller.refreshJournal.value;
                                                  context.loaderOverlay.hide();
                                                });
                                              },
                                              borderRadius: BorderRadius.circular(30.0),
                                              child: const Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: Icon(
                                                  Icons.delete_outline,
                                                  color: AppColors.tealColor,
                                                ),
                                              )),
                                          InkWell(
                                              onTap: () {
                                                Get.dialog(
                                                   Dialog(child: FutureBuilder<ChatListModel>(
                                                       future: controller.getAllChatList(userId: userInfo.userData.value.results!.userId.toString()),
                                                       builder: (context,snapData){
                                                         if(snapData.connectionState==ConnectionState.waiting){
                                                           return Center(child: const CircularProgressIndicator());
                                                         }
                                                         if(snapData.data!.results!.isNotEmpty){
                                                           return ListView.builder(
                                                             // shrinkWrap: true,
                                                               itemCount: snapData.data!.results!.length,
                                                               itemBuilder: (context,index){
                                                                   return Container(
                                                                     margin: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                                                                     // padding: EdgeInsets.only(left: 18.0,top: 18.0,right: 18.0),
                                                                     decoration: BoxDecoration(
                                                                         color: Colors.white,
                                                                         borderRadius: BorderRadius.circular(16.0),
                                                                         boxShadow: [
                                                                           BoxShadow(
                                                                               offset: const Offset(1, 1),
                                                                               blurRadius: 2,
                                                                               spreadRadius: 3,
                                                                               color: AppColors.lightGreyTextColor.withOpacity(0.5)
                                                                           )
                                                                         ]
                                                                     ),
                                                                     child: Column(
                                                                       children: [
                                                                         Padding(
                                                                           padding: const EdgeInsets.only(left: 18.0,top: 18.0,right: 18.0),
                                                                           child: Column(
                                                                             crossAxisAlignment: CrossAxisAlignment.start,
                                                                             children: [
                                                                               Row(
                                                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                                                 children: [
                                                                                   Row(
                                                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                                                     children: [
                                                                                       Padding(
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
                                                                                           center:  InkWell(
                                                                                             onTap: (){
                                                                                               // Get.to(()=>const ChatPageView());
                                                                                             },
                                                                                             child: CircleAvatar(
                                                                                                 radius: 30,
                                                                                                 backgroundColor: Colors.red,
                                                                                                 child: ClipRRect(
                                                                                                     borderRadius: BorderRadius.circular(140.0),
                                                                                                     child: Image.network(snapData.data!.results!.isNotEmpty &&
                                                                                                         snapData.data!.results![index].avatar!.isNotEmpty
                                                                                                         ? EndPoints.imageBaseUrl+snapData.data!.results![index].avatar!
                                                                                                         : ''))),
                                                                                           ),
                                                                                           circularStrokeCap: CircularStrokeCap.round,
                                                                                           startAngle: 150,
                                                                                           backgroundColor: Colors.transparent,
                                                                                           footer: Row(
                                                                                             mainAxisSize: MainAxisSize.min,
                                                                                             children: [
                                                                                               Padding(
                                                                                                 padding: const EdgeInsets.only(right: 6.0),
                                                                                                 child: Icon(Icons.thumb_up,color: AppColors.greenColor,size: 14,),
                                                                                               ),
                                                                                               Text('88%',style: TextStyle(color: AppColors.greyTextColor,fontSize: 12,fontWeight: FontWeight.w500),)
                                                                                             ],
                                                                                           ),
                                                                                         ),
                                                                                       ),
                                                                                       Column(
                                                                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                                                         children: [
                                                                                            Text14by400(text: snapData.data!.results![index].doctorName.toString()),
                                                                                           // Padding(
                                                                                           //   padding: const EdgeInsets.symmetric(vertical: 6.0),
                                                                                           //   child: IntrinsicHeight(
                                                                                           //     child:
                                                                                           //     Row(
                                                                                           //       children: [
                                                                                           //         Text16by400(text: 'Specialisation',fontSize: 12,color: AppColors.lightGreyTextColor,),
                                                                                           //         const VerticalDivider(color: Colors.black,indent: 2.0,endIndent: 2.0),
                                                                                           //         Text16by400(text: snapData.data!.results![index].degree.toString(),fontSize: 12,color: AppColors.lightGreyTextColor,)
                                                                                           //
                                                                                           //       ],
                                                                                           //     ),
                                                                                           //
                                                                                           //   ),
                                                                                           // ),
                                                                                           Padding(
                                                                                             padding: const EdgeInsets.symmetric(vertical: 2.0),
                                                                                             child: Text16by400(text: '₹ 30 /mins',fontSize: 12,color: AppColors.lightGreyTextColor,),
                                                                                           ),
                                                                                           Row(
                                                                                             mainAxisAlignment: MainAxisAlignment.start,
                                                                                             children: [
                                                                                               Container(
                                                                                                 margin: const EdgeInsets.symmetric(vertical: 6.0),
                                                                                                 padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4.0),
                                                                                                 decoration: ShapeDecoration(shape: const StadiumBorder(),
                                                                                                     color: AppColors.containerColor
                                                                                                 ),
                                                                                                 child: Row(
                                                                                                   children: [
                                                                                                     Text14by400(text: 'Free Chat',color: AppColors.lightGreyTextColor),
                                                                                                   ],
                                                                                                 ),
                                                                                               )
                                                                                             ],
                                                                                           ),
                                                                                         ],
                                                                                       ),
                                                                                     ],
                                                                                   ),
                                                                                 ],
                                                                               ),
                                                                               // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor

                                                                             ],
                                                                           ),
                                                                         ),
                                                                         InkWell(
                                                                           // onTap: (){
                                                                           //   context.loaderOverlay.show();
                                                                           //   WalletProvider().fetchWalletBalance().then((value)async {
                                                                           //     context.loaderOverlay.hide();
                                                                           //     var decodedData = jsonDecode(await value.stream.bytesToString());
                                                                           //     if (decodedData['wallet_details'] != null) {
                                                                           //       var walletBalance = num.parse(decodedData['wallet_details'][0]['amount'].toString());
                                                                           //       if(walletBalance<(30*300)){
                                                                           //         Get.defaultDialog(
                                                                           //             titlePadding: EdgeInsets.zero,
                                                                           //             contentPadding: EdgeInsets.zero,
                                                                           //             title: '',
                                                                           //             middleText: '',
                                                                           //             content: Container(
                                                                           //               padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                                                           //               child: Column(
                                                                           //                 children: [
                                                                           //                   Icon(
                                                                           //                     Icons.warning_amber_rounded,size: 56,color: AppColors.greyTextColor,),
                                                                           //                   const SizedBox(height: 10,),
                                                                           //                   const Text16by600(text: 'Alert',fontSize: 20,),
                                                                           //                   const SizedBox(height: 15,),
                                                                           //                   const FooterTextWithCenterAligned(text: 'You don’t have sufficient balance Minimum balance should for 15 min chat.', fontSize: 16,),
                                                                           //                   const SizedBox(height: 10,),
                                                                           //                   CustomSolidButton(buttonText: 'Top Up Wallet', onClick: (){
                                                                           //                     Get.off(()=>const WalletPageView());
                                                                           //                   },fontSize: 16,)
                                                                           //                 ],
                                                                           //               ),
                                                                           //             )
                                                                           //         );
                                                                           //       }else{
                                                                           //         Get.to(()=>const LiveCounselorView());
                                                                           //       }
                                                                           //     }else{
                                                                           //       Get.defaultDialog(
                                                                           //           titlePadding: EdgeInsets.zero,
                                                                           //           contentPadding: EdgeInsets.zero,
                                                                           //           title: '',
                                                                           //           middleText: '',
                                                                           //           content: Container(
                                                                           //             padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                                                           //             child: Column(
                                                                           //               children: [
                                                                           //                 Icon(
                                                                           //                   Icons.warning_amber_rounded,size: 56,color: AppColors.greyTextColor,),
                                                                           //                 const SizedBox(height: 10,),
                                                                           //                 const Text16by600(text: 'Alert',fontSize: 20,),
                                                                           //                 const SizedBox(height: 15,),
                                                                           //                 const FooterTextWithCenterAligned(text: 'You don’t have sufficient balance Minimum balance of Rs${30 * 300} should for 15 min chat.', fontSize: 16,),
                                                                           //                 const SizedBox(height: 10,),
                                                                           //                 CustomSolidButton(buttonText: 'Top Up Wallet', onClick: (){
                                                                           //                   Get.off(()=>const WalletPageView());
                                                                           //                 },fontSize: 16,)
                                                                           //               ],
                                                                           //             ),
                                                                           //           )
                                                                           //       );
                                                                           //     }
                                                                           //   });
                                                                           // },
                                                                           onTap: (){
                                                                             Get.to(()=>ChatConversationPageView(doctorId: snapData.data!.results![index].doctorId.toString(), doctorAvatar: snapData.data!.results![index].avatar??'', doctorName: snapData.data!.results![index].doctorName??'',));
                                                                           },
                                                                           child: Container(
                                                                             padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
                                                                             decoration: const BoxDecoration(
                                                                                 color: AppColors.tealColor,
                                                                                 borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0))
                                                                             ),
                                                                             child: const Row(
                                                                               mainAxisSize: MainAxisSize.max,
                                                                               mainAxisAlignment: MainAxisAlignment.center,
                                                                               children: [
                                                                                 Padding(
                                                                                   padding: EdgeInsets.only(right: 6.0),
                                                                                   child: Icon(Icons.message_rounded,size: 13,),
                                                                                 ),
                                                                                 Text('Chat',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400),)
                                                                               ],
                                                                             ),
                                                                           ),
                                                                         )
                                                                       ],
                                                                     ),
                                                                   );
                                                               });
                                                         }else{
                                                           return  Container(
                                                             margin: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                                                             padding: EdgeInsets.all(18.0),
                                                             decoration: BoxDecoration(
                                                                 color: Colors.white,
                                                                 borderRadius: BorderRadius.circular(16.0),
                                                                 boxShadow: [
                                                                   BoxShadow(
                                                                       offset: const Offset(1, 1),
                                                                       blurRadius: 2,
                                                                       spreadRadius: 3,
                                                                       color: AppColors.lightGreyTextColor.withOpacity(0.5)
                                                                   )
                                                                 ]
                                                             ),
                                                             child:  Text('You had not booked any therapist\'s yet',style: TextStyle(color: AppColors.greyTextColor,fontSize: 12,fontWeight: FontWeight.w500),),
                                                           );
                                                         }

                                                       }))

                                                );
                                              },
                                              borderRadius: BorderRadius.circular(30.0),
                                              child: const Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: Icon(
                                                  Icons.share,
                                                  color: AppColors.tealColor,
                                                ),
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      }else{
                        return const Center(child: Text('No Data Found'));}
                    }else{
                      return Center(child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: BorderButton(buttonText: 'Create New Journal', onClick: (){
                          Get.to(()=>const CreateNewJournalPageView());
                        }),
                      ),);
                    }
                  }),
            )),

          Offstage(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomSolidButton(buttonText: 'Create New Journal',
                onClick: (){
                  Get.to(()=>const CreateNewJournalPageView())?.then((value) {
                    controller.refreshJournal.value=true;
                    controller.refreshJournal.value=false;
                  });
                }),
          ),offstage: false,)
        ],
      )
    );
  }
}




//Define the Note class to store the title and content of a note
class Note {
  final String title;
  final String content;

  Note({required this.title, required this.content});

  // Copy constructor to create a new note with updated values
  Note copyWith({String? title, String? content}) {
    return Note(
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }
}
