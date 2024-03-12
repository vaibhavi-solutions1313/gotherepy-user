import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/app_model/conversation.dart';
import 'package:gotherepy/app/app_model/therapists.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../chat_page/views/chat_page_view.dart';
import '../model/doctor_availability_model.dart';
import '../providers/counselors_provider.dart';

class CounselorsPageController extends GetxController with GetTickerProviderStateMixin{
  //TODO: Implement CounselorsPageController
  ///Provider
  CounselorsProvider counselorsProvider= CounselorsProvider();
var isSelected=[false,false,false,false].obs;
  late  TabController slotsTabController;
  late  TabController slotsBookingTabController;
  ///Doctor Info
var doctorDetail=[
  {
    'title':'Name',
    'value':'Msc in Counselling Psychology Msc in Counselling Psychology Msc in Counselling Psychology Msc in Counselling Psychology Msc in Counselling Psychology Msc in Counselling Psychology Msc in Counselling Psychology Msc in Counselling Psychology',
    'icon':Icon(Icons.edit),
  },
  {
    'title':'About',
    'value':'Hey, my name is Geeta Bhalla, I am a certified Weight Loss Dietitian. I’ve been practicing from my clinic in South Delhi (M Block Market, Greater Kailash Part 1) from 2003 till present. I have generated a huge clientele over time mainly through my positive word of mouth.',
    'icon':Icon(Icons.edit),
  },
  {
    'title':'Specialization',
    'value':'Anxiety, Depression, Stress, Relationship Issue, Suicidal Ideation, Grief & Loss, OCD.',
    'icon':Icon(Icons.edit),
  },


].obs;


///Chat Page
 TextEditingController sendMessageController=TextEditingController();
 RxList messageList=[].obs;
late ChatMessage sendMessage;


/// Slots Booking
  Rx<DoctorAvailabilitySlotsModel> doctorAvailabilitySlotsModel=DoctorAvailabilitySlotsModel().obs;
RxBool slotButtonColor=false.obs;
var selectedSlot = "".obs;
var selectedSessionPackage = ''.obs;
var selectedSlotPrice = ''.obs;
var selectedTimeIndex = 0.obs;
Rx<ChatSession> selectedChatSession=ChatSession().obs;
TextEditingController nameTextEditingController=TextEditingController();
TextEditingController emailTextEditingController=TextEditingController();
TextEditingController phoneTextEditingController=TextEditingController();
TextEditingController dateTextEditingController=TextEditingController();


 Future <DoctorAvailabilitySlotsModel?> getSlotsAvailability({required String doctorId, required String date}) async {

   return await counselorsProvider.fetchSlotsAvailability(doctorId: doctorId, date: date, timeType: '1').then((value) {
     if(value!=null){
       doctorAvailabilitySlotsModel.value =  DoctorAvailabilitySlotsModel.fromJson(value);
       return doctorAvailabilitySlotsModel.value;
     }else {
       return DoctorAvailabilitySlotsModel();
     }
   });
 }

 Future getSlotBook({ required String doctorId, required String bookingDate, required String bookingTime,required num doctorCharge} )async{
   await counselorsProvider.bookSlot(
       doctorId: doctorId,
       bookingDate: bookingDate,
       bookingTimeSlot: bookingTime,
       doctorCharge: doctorCharge);
 }
Future bookChatAppointment(BuildContext context,{required String chatTime,required int doctorId,required String amount,})async{
   context.loaderOverlay.show();
   return await counselorsProvider.requestChatBookingAppointment(chatTime: chatTime, doctorId: doctorId, amount: amount).then((value) async{
     context.loaderOverlay.hide();
     var decodedData=jsonDecode(await value.stream.bytesToString());
     print(decodedData.toString());
     if(decodedData['status']==true){
       Get.off(()=>const ChatPageView(showBackButton: true,));
     }
   });
}

 ///Conversation
  var isMessagingFetching=false.obs;
  Rx<Conversation> userConversation=Conversation().obs;
  TextEditingController messageEditingController = TextEditingController();
 Future<Rx<Conversation>> getConversation({required String userId, required String doctorId})async{
   return await counselorsProvider.fetchConversation(userId: userId, doctorId: doctorId).then((value) {
     print(value.toJson().toString());
     isMessagingFetching.value=false;
     userConversation.refresh();
      return userConversation=value;
   });
 }

  Future sendMessages({required String userId, required String doctorId, required String message, int isDoctorUser=0}) async{
    if (message.trim().isNotEmpty) {
      isMessagingFetching.value=true;
      await counselorsProvider.sendMessage(userId: userId, doctorId: doctorId, message: message,isDoctorUser: isDoctorUser);
    }
  }
  @override
  void onInit() {
    slotsTabController = TabController(length: 3, vsync: this);
    slotsBookingTabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}

class ChatMessage{
   final String senderName;
   final String senderMessage;
   ChatMessage({required this.senderName, required this.senderMessage});
}




