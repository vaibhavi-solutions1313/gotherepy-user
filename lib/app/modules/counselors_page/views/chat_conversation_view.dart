import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/appTextField.dart';
import 'package:gotherepy/app/app_constants/constants_end_points.dart';
import 'package:gotherepy/app/app_model/conversation.dart';
import 'package:gotherepy/main.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/counselors_page_controller.dart';

class ChatConversationPageView extends GetView {
  final String doctorId;
  final String doctorName;
  final String doctorAvatar;
  const ChatConversationPageView({required this.doctorAvatar, required this.doctorName, required this.doctorId, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CounselorsPageController chatPageController=Get.put(CounselorsPageController());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    AppColors.tealColor.withOpacity(0.6),
                    AppColors.tealColor,
                    // AppColors.tealColor.withOpacity(0.7),
                    AppColors.bluishColor.withOpacity(0.8),
                    AppColors.bluishColor.withOpacity(0.9),
                    AppColors.bluishColor,
                  ],
                  begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
              image: DecorationImage(image: AssetImage(AppImages.appbarBackgroundPngImage),
                  fit: BoxFit.cover,
                // repeat: ImageRepeat.repeatY
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap:(){Get.back();},
                          child: Icon(Icons.arrow_back)),
                      SizedBox(width: 10),
                      Text16by600(text: 'Help',color: Colors.white),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(

                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: Container(
                                  height:60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent.withOpacity(0.8),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(image: NetworkImage(EndPoints.baseUrl+doctorAvatar),onError: (obj,cv){},
                                          fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  child: Image.asset(AppImages.marriage),
                                ),
                              ),
                              Text.rich(
                                TextSpan(text: 'Aevrage wait time',children: [
                                TextSpan(text:' 3',style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500
                                )),
                                TextSpan(text:' minutes',style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500
                                )),
                              ]),maxLines: 2,style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w300
                              ),)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text16by600(text: doctorName,color: Colors.white,),
                                  Image.asset(AppImages().chatPageHandLogoOfPeace,height: 40,width: 50,)
                                ],
                              ),
                              Text.rich(TextSpan(text: 'We are here to help you'),maxLines: 2,style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w300
                              ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<Rx<Conversation>>(
                future: chatPageController.getConversation(userId: userInfo.userData.value.results!.userId.toString(), doctorId: doctorId),
                builder: (context,snapData){
              if(snapData.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }else if(snapData.hasError){
                return Center(child: Text('snapData.error.toString()'),);
              }else{
                chatPageController.userConversation.value=snapData.data!.value;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => chatPageController.userConversation.value.results!.isNotEmpty?
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: chatPageController.userConversation.value.results!.length,
                        itemBuilder: (context, index) {
                          return Align(
                              alignment: chatPageController.userConversation.value.results![index].isDoctorUser==0?Alignment.centerRight:Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ChatMessage(text: chatPageController.userConversation.value.results![index].message.toString()),
                              ));
                        },
                      ),
                    )
                        :Center(child: Text('No chats available')
                    ),),
                    Row(
                      children: [
                        IconButton(onPressed: (){}, icon: Icon(Icons.emoji_emotions_outlined,color: Colors.grey,size: 28)),
                        IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt_outlined,color: Colors.grey,size: 28)),
                        Expanded(child: Container(child: CustomTextFieldWithoutBorderAndHeading(hintText: 'Type Your problems', textEditingController: Get.find<CounselorsPageController>().messageEditingController, maxLine: 1,))),
                        Obx(() => IconButton(onPressed: (){
                          Get.find<CounselorsPageController>().sendMessages(
                              userId: userInfo.userData.value.results!.userId.toString(),
                              doctorId: doctorId,
                              message: Get.find<CounselorsPageController>().messageEditingController.text.trim()
                          ).whenComplete(() {
                            chatPageController.getConversation(userId: userInfo.userData.value.results!.userId.toString(), doctorId: doctorId);
                          });
                          Get.find<CounselorsPageController>().messageEditingController.clear();
                        },
                            icon: chatPageController.isMessagingFetching.value?const CircularProgressIndicator():Icon(Icons.send,color: Colors.grey,size: 28,))),
                      ],
                    )
                  ],
                );
              }
            }
            ),
          ),
        ],
      ),
    );
  }
}
class ChatMessage extends StatelessWidget {
  final String text;
  const ChatMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}


// class ChatScreen extends StatefulWidget {
//   final Rx<Conversation> conversation;
//   final String doctorId;
//   const ChatScreen({super.key,required this.conversation, required this.doctorId});
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   List<String> messages = []; // List to store the chat messages
//   @override
//   Widget build(BuildContext context) {
//     return  Column(
//       children: [
//         Obx(() => widget.conversation.value.results!.isNotEmpty?
//         Expanded(
//           child: ListView.builder(
//             shrinkWrap: true,
//             reverse: true,
//             itemCount: widget.conversation.value.results!.length,
//             itemBuilder: (context, index) {
//               return Align(
//                   alignment: widget.conversation.value.results![index].isDoctorUser==0?Alignment.centerRight:Alignment.centerLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ChatMessage(text: widget.conversation.value.results![index].message.toString()),
//                   ));
//             },
//           ),
//         )
//             :Center(child: Text('No chats available')
//         ),),
//         Row(
//           children: [
//             IconButton(onPressed: (){}, icon: Icon(Icons.emoji_emotions_outlined,color: Colors.grey,size: 28)),
//             IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt_outlined,color: Colors.grey,size: 28)),
//             Expanded(child: Container(child: CustomTextFieldWithoutBorderAndHeading(hintText: 'Type Your problems', textEditingController: Get.find<CounselorsPageController>().messageEditingController, maxLine: 1,))),
//             IconButton(onPressed: (){ Get.find<CounselorsPageController>().sendMessages(
//                 userId: userInfo.userData.value.results!.userId.toString(),
//                 doctorId: widget.doctorId,
//                 message: Get.find<CounselorsPageController>().messageEditingController.text.trim()
//             );
//             Get.find<CounselorsPageController>().messageEditingController.clear();
//               },
//                 icon: Icon(Icons.send,color: Colors.grey,size: 28,)),
//           ],
//         )
//       ],
//     );
//   }
// }






