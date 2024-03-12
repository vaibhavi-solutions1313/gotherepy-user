import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../../app_model/user_info.dart';
import '../../../app_utils/services.dart';
import '../providers/profile_info_provider.dart';

class ProfilePageController extends GetxController {
  //TODO: Implement ProfilePageController
  var isUserClickedToChangePassword=true.obs;
  var userImage=''.obs;
  var nameController=TextEditingController().obs;
  var lastNameController=TextEditingController().obs;
  var emailController=TextEditingController().obs;
  var dobController=TextEditingController().obs;

  var oldPasswordController=TextEditingController().obs;
  var newPasswordController=TextEditingController().obs;
  var newConfirmPasswordController=TextEditingController().obs;


  getProfileInfo(){
    ProfileInfoProvider().getProfileInfo().then((value)async {
      if(value.statusCode==200){
        var decodedData=jsonDecode(await value.stream.bytesToString());
        decodedData['results']['first_name']!=null?nameController.value.text=decodedData['results']['first_name']:null;
        decodedData['results']['last_name']!=null?lastNameController.value.text=decodedData['results']['last_name']:null;
        decodedData['results']['avatar']!=null?userImage.value=decodedData['results']['avatar']:null;
      emailController.value.text=decodedData['results']['email'];
        dobController.value.text=decodedData['results']['dob'] ;
      }
    });
  }
   getPicture(ImageSource source) async {
    var picker = ImagePicker();
    var pickedFile = await picker.pickImage(source: source);
    if(pickedFile!.path.isNotEmpty) {
      print('-------------updating Image--------------------');
      ProfileInfoProvider().updateImage(pickedFile.path).then((responseData) async{
        var decodedResponseData=jsonDecode(await responseData.stream.bytesToString());
        Fluttertoast.showToast(msg: decodedResponseData['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.tealColor,
            textColor: Colors.white,
            fontSize: 16.0

        );
        ProfileInfoProvider().fetchUserInfo().then((resValue) async{
          var userDecodedData=jsonDecode(await resValue.stream.bytesToString()) ;
          Get.find<Services>().box.write('userInfo', userDecodedData);
          userInfo.userData.value=UserInfoModel.fromJson(Get.find<Services>().box.read('userInfo'));
          if (kDebugMode) {
            print( userInfo.userData.value.toJson().toString());
          }
        });
        getProfileInfo();
      });
    }
  }

  updateProfile(BuildContext context,Map data){
    ProfileInfoProvider().updateUserProfile(data).then((responseData) async{
        if(responseData.statusCode==200){
          var decodedResponseData=jsonDecode(await responseData.stream.bytesToString());
          Fluttertoast.showToast(msg: decodedResponseData['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: AppColors.tealColor,
              textColor: Colors.white,
              fontSize: 16.0

          );
          ProfileInfoProvider().fetchUserInfo().then((resValue) async{
            context.loaderOverlay.hide();
            // var userDecodedData=jsonDecode(await resValue.stream.bytesToString()) ;
            // Get.find<Services>().box.write('userInfo', userDecodedData);
            // userInfo.userData.value=UserInfoModel.fromJson(Get.find<Services>().box.read('userInfo'));
          });
          getProfileInfo();
        }
    });
  }
  Future changePassword({required String oldPassword, required String newPassword,required String newConfirmedPassword})async{
    if(oldPassword.isNotEmpty && newPassword.isNotEmpty && newConfirmedPassword.isNotEmpty){
      Map data={
        'oldPassword':oldPassword,
        'newPassword':newPassword,
        'newConfirmedPassword':newConfirmedPassword,
      };
      await ProfileInfoProvider().changePassword(data).then((value) async{
        isUserClickedToChangePassword.value=true;
        var data=jsonDecode(await value.stream.bytesToString());
        print(data.toString());
      Fluttertoast.showToast(msg: data['msg']);
      });
    }else{
      Fluttertoast.showToast(msg: 'Please enter the field');
    }
  }
  @override
  void onInit() {
    nameController.value.text=userInfo.userData.value.results?.firstName??'';
    emailController.value.text=userInfo.userData.value.results?.email??'';
    dobController.value.text=userInfo.userData.value.results?.dob??'';
    super.onInit();
    getProfileInfo();
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
