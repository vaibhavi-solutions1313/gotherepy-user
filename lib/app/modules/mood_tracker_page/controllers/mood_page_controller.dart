import 'package:get/get.dart';
import 'package:gotherepy/app/app_constants/app_images.dart';
import 'package:gotherepy/app/modules/mood_tracker_page/providers/mood_tracker_provider.dart';

class MoodPageController extends GetxController{

  MoodTrackerProvider moodTrackerProvider = MoodTrackerProvider();

  controllerGetMoodsList(){
    MoodTrackerProvider().apiGetUserMoods().then((value) {

    });
  }

  List<Map<String, dynamic>> mood_list = [
    {
      'image': AppImages.aloneImg,
      'mood_name': AppImages.aloneText,
      'feeling': 'alone'
    },
    {
      'image': AppImages.anxiousImg,
      'mood_name': AppImages.anxiousText,
      'feeling': 'anxious'
    },
    {
      'image': AppImages.calmImg,
      'mood_name': AppImages.calmText,
      'feeling': 'calm'
    },
    {
      'image': AppImages.crankyImg,
      'mood_name': AppImages.crankyText,
      'feeling': 'cranky'
    },
    {
      'image': AppImages.creativeImg,
      'mood_name': AppImages.creativeText,
      'feeling': 'creative'
    },
    {
      'image': AppImages.disappointedImg,
      'mood_name': AppImages.disappointedText,
      'feeling': 'disappointed'
    },
    {
      'image': AppImages.energeticImg,
      'mood_name': AppImages.energeticText,
      'feeling': 'energetic'
    },
    {
      'image': AppImages.excitedImg,
      'mood_name': AppImages.excitedText,
      'feeling': 'excited'
    },
    {
      'image': AppImages.frustratedImg,
      'mood_name': AppImages.frustratedText,
      'feeling': 'frustrated'
    },
    {
      'image': AppImages.gratefulImg,
      'mood_name': AppImages.gratefulText,
      'feeling': 'grateful'
    },
    {
      'image': AppImages.happyImg,
      'mood_name': AppImages.happyText,
      'feeling': 'happy'
    },
    {
      'image': AppImages.jealousImg,
      'mood_name': AppImages.jealousText,
      'feeling': 'jealous'
    },
    {
      'image': AppImages.lovedImg,
      'mood_name': AppImages.lovedText,
      'feeling': 'loved'
    },
    {
      'image': AppImages.lostImg,
      'mood_name': AppImages.lostText,
      'feeling': 'lost'
    },
    {
      'image': AppImages.sadImg,
      'mood_name': AppImages.sadText,
      'feeling': 'sad'
    },
    {
      'image': AppImages.tiredImg,
      'mood_name': AppImages.tiredText,
      'feeling': 'tired'
    },
  ].obs;
}