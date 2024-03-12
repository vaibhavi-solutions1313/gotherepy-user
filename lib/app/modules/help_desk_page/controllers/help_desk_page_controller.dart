import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpDeskPageController extends GetxController {
  //TODO: Implement HelpDeskPageController

  @override
  void onInit() {
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

  void whatsappChatSupport(BuildContext context) async {
    var whatsapp = "+918198096585";
    var whatsappAndroid = Uri.parse("whatsapp://send?phone=$whatsapp&text=Hello, I'm userNameHere, I need your help!");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "WhatsApp is not installed on the device"),
        ),
      );
    }
  }
  void launchEmail(){
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'smith@example.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Wellness: i need help in...!',
      }),
    );
    launchUrl(emailLaunchUri);
    Get.back();
  }
  launchDialer()async{
    const number = '180078786868';
    launch('tel:2235448899');//set the number here
    // bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}
