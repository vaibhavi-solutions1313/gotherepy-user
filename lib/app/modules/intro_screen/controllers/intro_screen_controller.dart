import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class IntroScreenController extends GetxController {
  //TODO: Implement IntroScreenController
PageController pageController=PageController();
var pageCurrentIndex=0.obs;

void jumpToNextPage(int pageIndex){
  pageController.animateToPage(pageIndex, duration: const Duration(milliseconds: 500), curve: Curves.linear);
}
autoSlide()async{
  if(pageCurrentIndex.value==0){
    await Future.delayed(Duration(milliseconds: 800),()async{
      jumpToNextPage(1);
    });
    await Future.delayed(Duration(milliseconds: 1000),(){
      jumpToNextPage(2);
    });
  }
}
  @override

  void onInit() {
    autoSlide();
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
