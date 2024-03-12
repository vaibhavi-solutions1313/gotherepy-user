import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotherepy/app/modules/auth_page/views/sign_in_view.dart';
import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/appTextField.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/auth_page_controller.dart';
import 'auth_page_view.dart';

class SignUpView extends GetView {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthPageController authPageController=Get.find<AuthPageController>();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [AppColors.bluishColor, AppColors.bluishColor.withOpacity(0.7)]),
            image: DecorationImage(
                image: AssetImage(AppImages.appbarBackgroundPngImage),fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
                repeat: ImageRepeat.repeatY
            )
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Center(
                    child: Text(
                      'GoTherapy',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    )),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Form(
                          key: authPageController.signUpFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text16by400(text: 'Enter your details',fontSize: 24),
                              SizedBox(height: 15,),
                              CustomTextFieldWithTitle(title: 'Username', textEditingController: authPageController.usernameController, hintText: 'Username',),
                              CustomTextFieldWithTitle(title: 'Email address', textEditingController: authPageController.signUpEmailController, hintText: 'Email address',),
                              CustomTextFieldWithTitle(title: 'Mobile number', textEditingController: authPageController.signUpPhoneController, hintText: 'Mobile number',inputType: TextInputType.number,),
                              CustomPasswordTextField(title: 'Password', textEditingController: authPageController.signUpPasswordController, hintText: 'Password', inputType: TextInputType.phone, isObscureText: true,),
                              CustomPasswordTextField(title: 'Confirm Password', textEditingController: authPageController.confirmPasswordController, hintText: 'Password', inputType: TextInputType.phone, isObscureText: true,),
                              SizedBox(height: 25,),
                              CustomSolidButton(buttonText: 'Sign up', onClick: (){
                                  if(authPageController.signUpFormKey.currentState!.validate()){
                                    if(GetUtils.isEmail(authPageController.signUpEmailController.text)){
                                      if(authPageController.signUpPasswordController.text==authPageController.confirmPasswordController.text){
                                        Map data={
                                          "username":authPageController.usernameController.text,
                                          "email":authPageController.signUpEmailController.text,
                                          "phone": authPageController.signUpPhoneController.text,
                                          "password":authPageController.signUpPasswordController.text,
                                          "confirm_password":authPageController.confirmPasswordController.text
                                        };
                                        authPageController.registerNewUser(data,context);
                                      }else {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password mismatched')));
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter Valid Email')));
                                    }
                                  }


                              }),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            RichText(
                              textAlign: TextAlign.right,
                              text:  TextSpan(
                                  text: 'Already Have an Account? ',
                                  style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: AppColors.blackishTextColor),
                                  children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()..onTap=(){
                                        Get.to(()=>SignInView());
                                      },
                                      text: 'Sign In ',
                                      style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: AppColors.tealColor),
                                    )]
                              ),
                            ),
                            LoginWithSocial()
                          ],
                        )
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