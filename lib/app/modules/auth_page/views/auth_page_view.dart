import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/app_constants/constants_appColors.dart';
import 'package:gotherepy/app/modules/auth_page/views/sign_in_view.dart';
import 'package:gotherepy/app/modules/auth_page/views/sign_up_view.dart';
import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_constants/app_images.dart';
import '../controllers/auth_page_controller.dart';

class AuthPageView extends GetView<AuthPageController> {
  const AuthPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthPageController authPageController=Get.put(AuthPageController());
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.backgroundPngImage),repeat: ImageRepeat.repeat,),
        ),
        child: ListView(
          children: [
            Image.asset(AppImages.appLogoImage1,height:Get.height/3,fit: BoxFit.fitHeight,),
            Image.asset(AppImages.yogaImage,height:Get.height/3,fit: BoxFit.fitHeight),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  BorderButton(buttonText: 'Sign In', onClick: () {
                    Get.to(()=>const SignInView(),transition: Transition.downToUp);
                  },),
                  BorderButton(buttonText: 'Sign up', onClick: () {
                    Get.to(()=>const SignUpView(),transition: Transition.upToDown);
                  },),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginWithSocial extends StatelessWidget {
  const LoginWithSocial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(height: 25,),
        Row(
          children: [
            Expanded(
              child: Divider(
                thickness: 2,
                height: 42,
                color: AppColors.lightGreyTextColor,
              ),
            ),
            Text16by400(text: ' Login With ',fontSize:14,color: AppColors.lightGreyTextColor,),
            Expanded(
              child: Divider(
                thickness: 2,
                height: 42,
                color: AppColors.lightGreyTextColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 15,),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: (){
                      Get.find<AuthPageController>().signInWithGoogle();
                    },
                    child: Ink(
                      padding: EdgeInsets.only(left: 0.0,top: 20.0,right: 30.0,bottom: 20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              width: 1,
                              color: AppColors.lightGreyTextColor
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(AppImages.fbLogo,height: 25,width: 25,fit: BoxFit.fitHeight,),
                          Text16by400(text: 'Facebook')
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: (){
                      Get.find<AuthPageController>().signInWithGoogle();
                    },
                    child: Ink(
                      padding: EdgeInsets.only(left: 0.0,top: 20.0,right: 30.0,bottom: 20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              width: 1,
                              color: AppColors.lightGreyTextColor
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(AppImages.googleLogo,height: 25,width: 25,fit: BoxFit.fitHeight,),
                          Text16by400(text: 'Google')
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
        SizedBox(height: 10,),
      ],
    );
  }
}
