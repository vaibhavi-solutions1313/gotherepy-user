import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/appButtons.dart';
import 'package:gotherepy/app/appWidgets/text_styles.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/wallet_page_controller.dart';

class WalletPageView extends GetView<WalletPageController> {
  const WalletPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WalletPageController walletPageController =Get.put(WalletPageController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.scaffoldColor,
      appBar: CustomUniversalAppBar(title: 'My Wallet', appBar: AppBar(),),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(18.0),
            margin: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.0,1.0),
                  blurRadius: 6.0,
                  spreadRadius: 2.0,
                  color: AppColors.lightGreyTextColor
                )
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text16by400(text: 'My Wallet',fontSize: 17,),
                    CircleAvatar(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Column(
                    children: [
                      Text14by400(text: 'Your balance'),
                      Obx(() => Text('₹ ${walletPageController.walletBalance.value}',style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bluishColor,
                        // decoration: TextDecoration.underline
                      ),)),
                       SizedBox(
                        width: 235,
                        child: FlipCard(
                          onFlip: (){},
                          controller: walletPageController.flipCardController,
                          direction: FlipDirection.VERTICAL,
                          alignment: Alignment.center,
                          front: BorderButton(buttonText:'Add Money',fontSize: 12, onClick: (){
                            walletPageController.flipCardController.toggleCard();
                          }),
                          back: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width:170,
                                // height: 40,
                                child:  TextField(
                                  controller: walletPageController.textEditingController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.blackishTextColor,
                                  ),
                                  // cursorColor: AppColors.blackishTextColor,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                          color: AppColors.tealColor
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                          color: AppColors.tealColor
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: AppColors.containerColor,
                                    hintText: 'Add Amount',
                                    labelStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color:AppColors.lightGreyTextColor),
                                  ),
                                ),
                              ),
                              //child: CustomCircularBorderTextFieldWithHintTextAndTitle(title: 'dfs', hintText: 'fsdfs', textEditingController: walletPageController.textEditingController, readOnly: false)),
                              InkWell(
                                onTap: (){
                                  if(walletPageController.textEditingController.value.text.isNotEmpty)
                                  {
                                    print('Start transcation');
                                    // controller.startTransaction();
                                    context.loaderOverlay.show();
                                    controller.startFalseTranscation(amount:walletPageController.textEditingController.value.text).whenComplete(() {
                                      walletPageController.textEditingController.clear();
                                      context.loaderOverlay.hide();
                                    }).onError((error, stackTrace) {
                                      context.loaderOverlay.hide();
                                    });
                                  }
                                  else{
                                    Fluttertoast.showToast(msg: 'Please Add Amount',gravity: ToastGravity.TOP);
                                  }
                                },
                                child: Container(
                                  width: 45,
                                  margin: const EdgeInsets.only(left: 14.0),
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                      color: AppColors.bluishColor,
                                      shape: BoxShape.circle
                                  ),
                                  child: Icon(Icons.send),
                                ),
                              ),
                            ],
                          ),),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(8),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(color: Color(0xff44C3D4), shape: BoxShape.circle),
                              // child: Image.asset(AppImages.twitterLogo)
                            child: Transform.rotate(
                                angle: 3.15,
                                child: Icon(Icons.file_download_outlined,color: Colors.white,size: 28,)),
                          ),
                          Text('Topup',style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: AppColors.tealColor,

                          ),)
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(8),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(color: Color(0xff44C3D4), shape: BoxShape.circle),
                            child: Transform.rotate(
                                angle: 3.15,
                                child: Icon(Icons.sync_alt_outlined,color: Colors.white,size: 28,)),),
                          Text('Transfer',style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: AppColors.tealColor,
                          ),)
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(8),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(color: Color(0xff44C3D4), shape: BoxShape.circle),
                            child: Transform.rotate(
                                angle: 3.15,
                                child: Icon(Icons.settings_outlined,color: Colors.white,size: 28,)),),
                          Text('Settings',style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: AppColors.tealColor,
                          ),)
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: Text16by600(text: 'All Transactions',fontSize: 20,),
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              // scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                  return ListTile(
                      onTap: () {},
                      splashColor: AppColors.tealColor.withOpacity(0.2),
                      leading: Container(
                          height: 53,
                          width: 53,
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.green.withOpacity(0.2)
                          ),
                          child: Icon(Icons.arrow_drop_up,size:36,color: Colors.green,)),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text14by400(text: 'Add Money',fontSize: 15,),
                          Text14by400(text: '10 Dec 2022',fontSize: 10,color: AppColors.lightGreyTextColor,),
                        ],
                      ),
                    trailing: Text16by600(text: '+ ₹ 5,451',fontSize: 15,),
                  );
              }),
        ],
      ),
    );
  }
}
