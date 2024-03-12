import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/appButtons.dart';
import 'package:gotherepy/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/profile_page_controller.dart';
ProfilePageController profilePageController = Get.put(ProfilePageController());

class ProfilePageView extends GetView<ProfilePageController> {
  const ProfilePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomUniversalAppBar(
        title: 'Edit Profile',
        appBar: AppBar(),
          showBackButton:true,

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Obx(() =>
                    CircleAvatar(
                      radius: 80,
                      backgroundImage:profilePageController.userImage.value!=''? NetworkImage(profilePageController.userImage.value):null,
                      child: profilePageController.userImage.value!=''?null: const Icon(Icons.person,size: 85,),
                    )

                ),
                Positioned(
                  bottom: 5.0,
                  right: 5.0,
                  child: InkWell(
                    onTap: () => profilePageController.getPicture(ImageSource.gallery),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.tealColor,
                      child: Icon(
                        Icons.image,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Obx(() => profilePageController.isUserClickedToChangePassword.value==true?
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          autofocus: false,
                          controller: profilePageController.nameController.value,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please Enter a valid input';
                            }else{
                              return null;
                            }
                          },
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blackishTextColor,
                          ),
                          cursorColor: AppColors.blackishTextColor,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.edit),
                              hintText: '${userInfo.userData.value.results?.firstName ?? 'Full Name'} ${userInfo.userData.value.results?.firstName ?? ''}',
                              labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.lightGreyTextColor),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: AppColors.lightGreyTextColor.withOpacity(0.5),
                                    width: 1.5,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: AppColors.lightGreyTextColor.withOpacity(0.5),
                                    width: 1.5,
                                  ))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          autofocus: false,
                          readOnly: true,
                          controller: profilePageController.emailController.value,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please Enter a valid input';
                            }else{
                              return null;
                            }
                          },
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blackishTextColor,
                          ),
                          cursorColor: AppColors.blackishTextColor,
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.edit),
                              hintText: '${userInfo.userData.value.results?.email ?? 'Email'}',
                              // labelText: 'Email',
                              labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.lightGreyTextColor),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: AppColors.lightGreyTextColor.withOpacity(0.5),
                                    width: 1.5,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: AppColors.lightGreyTextColor.withOpacity(0.5),
                                    width: 1.5,
                                  ))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          autofocus: false,
                          controller: profilePageController.dobController.value,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please Enter a valid input';
                            }else{
                              return null;
                            }
                          },
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blackishTextColor,
                          ),
                          cursorColor: AppColors.blackishTextColor,
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.edit),
                              hintText: userInfo.userData.value.results?.dob ?? 'Dob',
                              labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.lightGreyTextColor),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: AppColors.lightGreyTextColor.withOpacity(0.5),
                                    width: 1.5,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: AppColors.lightGreyTextColor.withOpacity(0.5),
                                    width: 1.5,
                                  ))),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              profilePageController.isUserClickedToChangePassword.value=false;
                            },
                              child: Text('Change Password',style: TextStyle(color: AppColors.tealColor,decoration: TextDecoration.underline,decorationColor: Colors.teal))),
                        ],
                      )
                    ],
                  ),
                )
                :Column(
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    autofocus: false,
                    controller: profilePageController.oldPasswordController.value,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Enter old password';
                      }else{
                        return null;
                      }
                    },
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackishTextColor,
                    ),
                    cursorColor: AppColors.blackishTextColor,
                    decoration: InputDecoration(
                        hintText: 'Enter old password',
                        // labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.lightGreyTextColor),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: AppColors.lightGreyTextColor.withOpacity(0.5),
                              width: 1.5,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: AppColors.lightGreyTextColor.withOpacity(0.5),
                              width: 1.5,
                            ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    autofocus: false,
                    controller: profilePageController.newPasswordController.value,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please Enter a valid input';
                      }else{
                        return null;
                      }
                    },
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackishTextColor,
                    ),
                    cursorColor: AppColors.blackishTextColor,
                    decoration: InputDecoration(
                        hintText: 'Enter new password',
                        labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.lightGreyTextColor),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: AppColors.lightGreyTextColor.withOpacity(0.5),
                              width: 1.5,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: AppColors.lightGreyTextColor.withOpacity(0.5),
                              width: 1.5,
                            ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    autofocus: false,
                    controller: profilePageController.newConfirmPasswordController.value,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please Enter a valid input';
                      }else{
                        return null;
                      }
                    },
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackishTextColor,
                    ),
                    cursorColor: AppColors.blackishTextColor,
                    decoration: InputDecoration(
                        hintText: 'Confirm password',
                        labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.lightGreyTextColor),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: AppColors.lightGreyTextColor.withOpacity(0.5),
                              width: 1.5,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: AppColors.lightGreyTextColor.withOpacity(0.5),
                              width: 1.5,
                            ))),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: (){
                          profilePageController.isUserClickedToChangePassword.value=true;
                        },
                        child: Text('Cancel',style: TextStyle(color: AppColors.tealColor,decoration: TextDecoration.underline,decorationColor: Colors.teal))),
                  ],
                )
              ],
            )
            ),
            CustomSolidButton(
                buttonText: 'Save',
                onClick: () {
                  if(profilePageController.isUserClickedToChangePassword.value==true){
                    context.loaderOverlay.show();
                    Map userData = {
                      "fname": profilePageController.nameController.value.text.trim(),
                      "lname": profilePageController.lastNameController.value.text.trim(),
                      "dob": profilePageController.dobController.value.text.trim()
                    };
                    profilePageController.updateProfile(context, userData);
                  }else{
                    context.loaderOverlay.show();
                    profilePageController.changePassword(oldPassword: profilePageController.oldPasswordController.value.text.trim(), newPassword: profilePageController.newPasswordController.value.text.trim(), newConfirmedPassword: profilePageController.newConfirmPasswordController.value.text.trim()).whenComplete(() {
                      context.loaderOverlay.hide();
                    });
                  }

                })
          ],
        ),
      ),
    );
  }
}


