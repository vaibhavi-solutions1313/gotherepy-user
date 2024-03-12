import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/app_model/therapists.dart';
import 'package:gotherepy/app/modules/home/providers/home_provider.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_utils/notification_services.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin{
   NotificationServices notificationServices= NotificationServices();
   HomeProvider provider=HomeProvider();
   PageController homePageController=PageController();
  //TODO: Implement HomeController
  ///Banner
   var bannersList = [].obs;
   var doctorBannersList = [].obs;
  ///Counselling
  var counsellingList=[].obs;
  List<Map<String,dynamic>> activitiesList=[
    {
      'image':AppImages.bookANewSession,
      'activityName':'Schedule a Session',
      'backgroundImage':AppImages.bookANewSessionBackground,
    },
    {
      'image':AppImages.journals,
      'activityName':'Journals',
      'backgroundImage':AppImages.journalsBackground,
    },
    // {
    //   'image':AppImages.bookANewYogaSession,
    //   'activityName':'Book a new yoga session',
    //   'backgroundImage':AppImages.bookANewYogaSessionBackground,
    // },
    // {
    //   'image':AppImages.bookANewMeditationSession,
    //   'activityName':'Book a new meditation session',
    //   'backgroundImage':AppImages.bookANewMeditationSessionBackground,
    // },
    {
      'image':AppImages.moodTrackerIn,
      'activityName':'Mood Tracker-In',
      'backgroundImage':AppImages.moodTrackerInBackground,
    },
    // {
    //   'image':AppImages.bookANewMeditationSession,
    //   'activityName':'Sleep Tracker',
    //   'backgroundImage':AppImages.bookANewMeditationSessionBackground,
    // },

  ].obs;

  List<Map<String,dynamic>> home_counselling_list=[
    {
      'image':AppImages.individual_counselling,
      'activityName':'Individual Counselling',
    },
    {
      'image':AppImages.child_counselling,
      'activityName':'Child Counselling',
    },
    {
      'image':AppImages.lgbtq_counselling,
      'activityName':'LGBTQ Counselling',
    },
    {
      'image':AppImages.mental_health_counselling,
      'activityName':'Mental Health Counselling',
    },
  ].obs;

  List<Map<String, dynamic>> carousel_banner_list = [
    {
      'image': AppImages.connect_banner,
    },
    {
      'image': AppImages.meeting_banner,
    }
  ].obs;

  List<Map<String, dynamic>> doctor_image_list = [
    {
      'image': AppImages.doctor_one,
      'doctor_name': 'Rahul Rana',
      'price': '24/Min'
    },
    {
      'image': AppImages.doctor_two,
      'doctor_name': 'Rahul Rana',
      'price': '24/Min'
    },
    {
      'image': AppImages.doctor_three,
      'doctor_name': 'Rahul Rana',
      'price': '24/Min'
    },
    {
      'image': AppImages.doctor_one,
      'doctor_name': 'Rahul Rana',
      'price': '24/Min'
    },
  ].obs;

  ///DoctorType
   var doctorType=[].obs;

   ///BottomNavigationBar
  var currentIndex=0.obs;
  jumpToPage(int index){
    currentIndex.value=index;
    homePageController.jumpToPage(currentIndex.value);
  }

  ///Activity
   var selectedIndex=0.obs;
   var selectedMoodID=''.obs;
   DateTime? selectedDate;
   var selectedTime=0.obs;
   ///
   Rx<Therapists> therapists=Therapists().obs;
   Future getTherapist() async {
    await  provider.fetchDoctorTypes().then((value)async {
       var jsonDecodedData=jsonDecode(value.toString());
       if(jsonDecodedData['results']!=null){
         doctorType.value=jsonDecodedData['results'];
         print(doctorType.toString());
         await provider.fetchDoctorListByDoctorType(jsonDecodedData['results'][0]['id'].toString()).then((value){
           therapists.value=value.value;
         });
       }
     });
   }
  @override
  void onInit() {
    // provider.getCounselling();
    // provider.fetchBanner();
    // provider.fetchDoctorBanner();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit();
    // getTherapist();
    // homeTabController=TabController(length: 5, vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
    // getTherapist();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}


