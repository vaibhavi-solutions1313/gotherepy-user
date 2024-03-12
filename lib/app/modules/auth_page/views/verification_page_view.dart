import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/appTextField.dart';
import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/phoneTextField.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../../app_utils/services.dart';
import '../controllers/auth_page_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationPageView extends GetView {
  final bool newUser;
  const VerificationPageView({this.newUser=false, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthPageController authPageController=Get.find<AuthPageController>();
    authPageController.isClicked.value=newUser;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [AppColors.bluishColor, AppColors.bluishColor.withOpacity(0.7)]),
            image: DecorationImage(
                image: AssetImage(AppImages.appbarBackgroundPngImage),fit: BoxFit.fitWidth, alignment: Alignment.topCenter,
                repeat: ImageRepeat.repeatY
            )
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Center(child: Text('GoTherapy',style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),textAlign: TextAlign.center,)),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        if(newUser==true)...[Text('Sign up',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24,color: AppColors.bluishTextColor),)],
                        if(newUser==false)...[Text('Reset Password',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24,color: AppColors.bluishTextColor),)],
                        // :..[Text('Reset Password',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24,color: AppColors.bluishTextColor),)],
                        Text16by400(text: 'Sign in to access your account',fontSize: 14,color: AppColors.greyTextColor,),
                        SizedBox(height: 50,),
                        Row(
                          children: [
                            Text16by400(text: 'Enter Your Mobile No',color: AppColors.greyTextColor,),
                          ],
                        ),

                        PhoneTextField(title: 'text', phoneController: authPageController.signUpPhoneController, hint: 'klkj',),
                        Obx(() => CustomSolidButton(buttonText: authPageController.canResendOtp.value?'Send OTP':'Resend otp in ${authPageController.timer.value} sec', onClick: (){
                          if(authPageController.canResendOtp.value=true){
                            if(authPageController.signUpPhoneController.text.isNotEmpty){
                              authPageController.sendOtp(context,authPageController.signUpPhoneController.text);
                            }else{
                              Services().getSnackMessage(title: 'Please Fill The Required Field',message: 'Enter Phone Number');
                            }
                          }

                        },
                        boxColor: authPageController.canResendOtp.value?AppColors.tealColor:Colors.grey),
                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            Text16by400(text: 'Enter OTP',color: AppColors.greyTextColor,),
                          ],
                        ),
                        PinCodeTextField(
                          mainAxisAlignment: MainAxisAlignment.start,
                          keyboardType: TextInputType.phone,
                          controller: authPageController.otpNumber,
                          length: 4,
                          textStyle: TextStyle(color: Color(0xff00AC4F),),
                          obscureText: false,
                          enablePinAutofill: true,

                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            fieldOuterPadding: EdgeInsets.only(top:10.0,right: 10),
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 40,
                            fieldWidth: 40,
                            activeFillColor: AppColors.scaffoldColor,
                            activeColor: AppColors.bluishColor,
                            selectedFillColor: Colors.white70,
                            selectedColor: AppColors.bluishColor,
                            inactiveFillColor:  AppColors.lightGreyTextColor.withOpacity(0.3),
                            inactiveColor: AppColors.lightGreyTextColor.withOpacity(0.4),
                          ),
                          animationDuration: const Duration(milliseconds: 300),
                          // backgroundColor: Colors.blue.shade50,
                          enableActiveFill: true,
                          // errorAnimationController: errorController,
                          // controller: textEditingController,
                          onCompleted: (v) {
                            print("Completed");
                            //verifyController.enteredOTP.value = v;
                          },
                          onChanged: (value) {
                            print(value);
                            // setState(() {
                            //   currentText = value;
                            // });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          }, appContext: context,
                        ),
                        Row(
                          children: [
                            Text16by400(text: 'Send Again',fontSize: 12,color: AppColors.tealColor,),
                          ],
                        ),
                        if(newUser==false)...[Obx(() => Visibility(
                          visible: authPageController.showResetPasswordField.value,
                          child: Column(
                            children: [
                              CustomPasswordTextField(hintText: 'Password', textEditingController: authPageController.setNewPassword, title: 'Password'),
                              CustomPasswordTextField(hintText: 'Confirm Password', textEditingController: authPageController.confirmNewPassword, title: 'Confirm Password'),
                            ],
                          ),
                        ))],
                       Obx(() =>  CustomSolidButton(
                           boxColor: authPageController.isClicked.value?AppColors.tealColor:AppColors.greyColor2F2F2F.withOpacity(0.5),
                           buttonText: 'Submit', onClick: (){
                         if(newUser==true){
                           print('vikram5');
                           authPageController.submitOtp(context,authPageController.signUpPhoneController.text,authPageController.otpNumber.text);
                         }else {
                           if (authPageController.setNewPassword.text == authPageController.confirmNewPassword.text) {
                             print('vikram');
                             authPageController.setPassword(authPageController.setNewPassword.text);
                           }
                         }
                       })),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
