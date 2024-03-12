import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/universalAppBar.dart';
import 'package:gotherepy/app/modules/home/bindings/home_binding.dart';
import 'package:gotherepy/app/modules/home/controllers/home_controller.dart';
import 'package:gotherepy/app/modules/home/views/home_view.dart';
import 'package:gotherepy/app/modules/schedule_calls_page/bindings/schedule_calls_page_binding.dart';
import 'package:gotherepy/app/modules/schedule_calls_page/views/schedule_calls_page_view.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/appTextField.dart';
import '../../../appWidgets/phoneTextField.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../../app_model/therapists.dart';
import '../../wallet_page/providers/wallet_provider.dart';
import '../../wallet_page/views/wallet_page_view.dart';
import '../controllers/counselors_page_controller.dart';
import 'counselor_profile_view.dart';

class SlotsBookingPageView extends GetView<CounselorsPageController> {
  final Results doctorInfo;
  final String? appointmentId;
  const SlotsBookingPageView({
    Key? key,
    required this.doctorInfo,
    this.appointmentId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    var slotsController = Get.put(CounselorsPageController());

    return Scaffold(
      appBar: CustomUniversalAppBar(
        title: 'Fill the form to book slots',
        appBar: AppBar(),
        showBackButton: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: AppColors.tealColor.withOpacity(0.1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CircularPercentIndicator(
                          radius: 35.0,
                          animation: true,
                          animationDuration: 1200,
                          linearGradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xFF44C3D4),
                              Color(0xFF44C3D4),
                            ],
                          ),
                          lineWidth: 2.0,
                          percent: 0.6,
                          center: InkWell(
                            onTap: () {
                              Get.to(() => CounselorProfileView(
                                therapist: doctorInfo,
                              ));
                            },
                            child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.red,
                                child:
                                ClipRRect(borderRadius: BorderRadius.circular(140.0), child: Image.network(doctorInfo != null ? doctorInfo!.avatar! : ''))),
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          startAngle: 150,
                          backgroundColor: Colors.transparent,
                          footer: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6.0),
                                    child: Icon(
                                      Icons.thumb_up,
                                      color: AppColors.greenColor,
                                      size: 14,
                                    ),
                                  ),
                                  Text(
                                    '88%',
                                    style: TextStyle(color: AppColors.greyTextColor, fontSize: 12, fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Text16by600(
                                  text: 'View Profile',
                                  fontSize: 12,
                                  color: AppColors.tealColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text14by400(
                              text: doctorInfo.name ?? "",
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text14by400(text: doctorInfo.degree ?? "", fontSize: 10),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text14by400(text: doctorInfo.title ?? "", fontSize: 10),
                            ),
                            Wrap(
                              children: [
                                ...List.generate(
                                    doctorInfo.specialization!.length,
                                        (index) => Text14by400(
                                      text: doctorInfo.specialization![index] ?? "",
                                      fontSize: 10,
                                      maxLine: 3,
                                    )),
                              ],
                            ),
                            Text(
                              doctorInfo.about ?? "",
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: AppColors.blackish5E5E5E),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                        },
                        child: Text14by400(text: '₹ ${doctorInfo.rate ?? ""} /hr', fontSize: 13),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child:
              ListView(
                padding: EdgeInsets.all(12.0),
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        color:Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: const [
                          BoxShadow(offset: Offset(0.5, 0.5),
                              blurRadius: 2.0,
                              spreadRadius: -0.4,
                              color: Colors.black26
                          ),
                        ]
                    ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Session Package',style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),),
                        // Text('Total Duration: ${doctorInfo.multipleSessionPrices!.callSession![index]}'),
                        Divider(thickness: 2),
                        if(doctorInfo.multipleSessionPrices!=null && doctorInfo.multipleSessionPrices!.callSession!=null && doctorInfo.multipleSessionPrices!.callSession!.isNotEmpty)
                        ...List.generate(doctorInfo.multipleSessionPrices!.callSession!.length, (index) =>  Column(
                          children: [
                           ListTile(
                            // onTap: (){
                            //   slotsController.selectedSessionPackage.value=doctorInfo.multipleSessionPrices!.callSession![index].priceAfterAllExcludedTaxes.toString();
                            // },
                            contentPadding: EdgeInsets.zero,
                            horizontalTitleGap: 4.0,
                            leading:  Obx(() => Radio(
                              value: doctorInfo.multipleSessionPrices!.callSession![index].priceAfterAllExcludedTaxes.toString(),
                              groupValue: slotsController.selectedSessionPackage.value,
                              onChanged: (value) {
                                slotsController.selectedSessionPackage.value = value.toString();
                              },
                            ),),
                            title:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Pack of ${doctorInfo.multipleSessionPrices!.callSession![index].sessionCount} Session'),
                                Card(
                                    color: Colors.orangeAccent.withOpacity(0.1),
                                    shadowColor: Colors.black12,
                                    child:  Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text('Save ${doctorInfo.multipleSessionPrices!.callSession![index].discountInPercent}',style: TextStyle(color: Colors.deepOrange),),
                                    )),
                              ],
                            ),
                            trailing:  Column(
                              children: [
                                Text('${doctorInfo.multipleSessionPrices!.callSession![index].priceAfterAllExcludedTaxes}',style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 16,fontWeight: FontWeight.bold)),
                                Text('${doctorInfo.multipleSessionPrices!.callSession![index].sessionPrice}',style: TextStyle(decoration: TextDecoration.lineThrough),),
                              ],
                            ),
                          ),
                            Divider(height: 0.0,),
                          ],
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.0,),
                  Text('Enter Detail',style: TextStyle(fontWeight: FontWeight.bold),),
                  CustomTextFieldWithHintTextAndBorder(textEditingController: slotsController.nameTextEditingController, labelText: 'Name',),
                  CustomTextFieldWithHintTextAndBorder(textEditingController: slotsController.emailTextEditingController, labelText: 'Email',),
                  PhoneTextField(title: 'Ind', phoneController: slotsController.phoneTextEditingController, hint: 'Whatsapp Number',),
                  TextFormField(
                    controller: slotsController.dateTextEditingController,
                    onTap: (){
                      showDatePicker(
                          builder: (context,child){
                            return Theme(
                                data:  Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: AppColors.appThemeColor.withOpacity(0.5),   // header background color
                                    onPrimary: Colors.black, // header text color
                                    brightness: Brightness.dark,
                                    onSurface: Colors.deepOrangeAccent, // body text color
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.green, // button text color
                                    ),
                                  ),
                                ),
                                child: child!);
                          },
                          keyboardType: TextInputType.datetime,
                          initialDate: DateTime.now(),
                          context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 7)),
                      ).then((value) {
                        if(value != null) {
                          slotsController.dateTextEditingController.text = value.toString();
                          slotsController.getSlotsAvailability(doctorId: doctorInfo.doctorId.toString(), date: value.toString());

                        }
                      });
                    },
                    readOnly: true,
                    autofocus: false,
                    keyboardType: TextInputType.datetime,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please Enter a valid input';
                      }else{
                        return null;
                      }
                    },
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackishTextColor,
                    ),
                    cursorColor: AppColors.blackishTextColor,
                    decoration: InputDecoration(
                        contentPadding:  const EdgeInsets.symmetric(horizontal: 12.0),
                        hintText: 'Date',
                        labelText: 'select Date',
                        labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color:AppColors.lightGreyTextColor),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset( AppImages.bookANewSession,height: 14,width: 14,fit: BoxFit.fitWidth,),
                        ),
                        alignLabelWithHint: true,
                        floatingLabelAlignment: FloatingLabelAlignment.start,
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
                            ))

                    ),

                  ),
                  Obx(() => slotsController.doctorAvailabilitySlotsModel.value.results!=null && slotsController.doctorAvailabilitySlotsModel.value.results!.time!.isNotEmpty?Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Text14by500(
                        text: 'Available Slots (${slotsController.doctorAvailabilitySlotsModel.value.results!.time!.length.toString()})',
                        color: AppColors.bluishTextColor,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          verticalDirection: VerticalDirection.down,
                          direction: Axis.horizontal,
                          spacing: 6.0,
                          runSpacing: 16.0,
                          alignment: WrapAlignment.center,
                          children: List.generate(
                              slotsController.doctorAvailabilitySlotsModel.value.results!.time!.length,
                                  (index) {
                                return InkWell(
                                  child: SlotButton(
                                    // data:slotsController.slotsList[index] ,
                                    slotsController: slotsController,
                                    index: index,
                                    selectedButtonColor: slotsController.slotButtonColor.value,
                                    bookingTime: slotsController.doctorAvailabilitySlotsModel.value.results!.time![index],
                                    doctorId: doctorInfo.doctorId.toString(),
                                  ),
                                );
                                  })),
                      CustomSolidButton(buttonText: 'Book Now', onClick: (){
                        if(slotsController.selectedSessionPackage.value!=''){
                          context.loaderOverlay.show();
                          WalletProvider().fetchWalletBalance().then((value) async {

                            context.loaderOverlay.hide();
                            var decodedData = jsonDecode(await value.stream.bytesToString());
                            if (decodedData['wallet_details'] != null) {
                              var walletBalance = num.parse(decodedData['wallet_details'][0]['amount'].toString());
                              //TODO

                              if (walletBalance < double.parse(slotsController.selectedSessionPackage.value.toString())) {

                                Get.defaultDialog(
                                    titlePadding: EdgeInsets.zero,
                                    contentPadding: EdgeInsets.zero,
                                    title: '',
                                    middleText: '',
                                    content: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.warning_amber_rounded,
                                            size: 56,
                                            color: AppColors.greyTextColor,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text16by600(
                                            text: 'Alert',
                                            fontSize: 20,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          FooterTextWithCenterAligned(
                                            text: 'You don’t have sufficient balance to book this doctor, Minimum balance of Rs${slotsController.selectedSessionPackage.value} required to book him/her',
                                            fontSize: 16,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CustomSolidButton(
                                            buttonText: 'Top Up Wallet',
                                            onClick: () {
                                              Get.off(() => const WalletPageView());
                                            },
                                            fontSize: 16,
                                          )
                                        ],
                                      ),
                                    ));
                              } else {
                                await Get.find<CounselorsPageController>()
                                    .getSlotBook(bookingDate: slotsController.dateTextEditingController.text, doctorId: doctorInfo.doctorId.toString(),
                                    bookingTime: slotsController.selectedSlot.value, doctorCharge: double.parse(slotsController.selectedSessionPackage.value.toString()))
                                    .whenComplete(()  {
                                  context.loaderOverlay.hide();
                                  Get.find<HomeController>().getTherapist().then((value) {
                                    Get.find<HomeController>().jumpToPage(4);
                                    // Get.to(()=>const ScheduleCallsPageView(showBackButton: true),binding: ScheduleCallsPageBinding());
                                    Get.to(()=>const ScheduleCallsPageView(showBackButton: true));
                                  });

                                });
                              }
                            } else {
                              context.loaderOverlay.hide();
                              Get.defaultDialog(
                                  titlePadding: EdgeInsets.zero,
                                  contentPadding: EdgeInsets.zero,
                                  title: '',
                                  middleText: '',
                                  content: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.warning_amber_rounded,
                                          size: 56,
                                          color: AppColors.greyTextColor,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text16by600(
                                          text: 'Alert',
                                          fontSize: 20,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        FooterTextWithCenterAligned(
                                          text: 'You don’t have sufficient balance to book this doctor, Minimum balance of Rs${slotsController.selectedSessionPackage.value} required to book him/her.',
                                          fontSize: 16,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomSolidButton(
                                          buttonText: 'Top Up Wallet',
                                          onClick: () {
                                            Get.off(() => const WalletPageView());
                                          },
                                          fontSize: 16,
                                        )
                                      ],
                                    ),
                                  ));
                            }
                          });
                        }else{
                          Fluttertoast.showToast(msg: 'Please select session first!');
                        }


                      })
                    ],
                  ):Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16.0,),
                      Center(
                          child: Image.asset(
                            AppImages.bookANewSession,
                            height: 80,
                            width: 80,
                            scale: 0.5,
                          )),
                      const Text('No slot available'),
                      const SizedBox(height: 16.0,),
                    ],
                  )),
                ],
              ),


          )
        ],
      ),
    );
  }
}

class SlotButton extends StatefulWidget {
  final String doctorId;
  final String bookingTime;
  final CounselorsPageController slotsController;
  final int index;
  final bool selectedButtonColor;
  const SlotButton(
      {Key? key,
      required this.slotsController,
      required this.index,
      required this.selectedButtonColor,
      required this.bookingTime,
      required this.doctorId,
    })
      : super(key: key);

  @override
  State<SlotButton> createState() => _SlotButtonState();
}

class _SlotButtonState extends State<SlotButton> {
  var slotsController = Get.find<CounselorsPageController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      slotsController.selectedSlot.value = "";
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
          onTap: () {
            slotsController.selectedSlot.value = widget.bookingTime.toString();
            // // Get.defaultDialog(
            // //     titlePadding: EdgeInsets.zero,
            // //     contentPadding: EdgeInsets.zero,
            // //     title: '',
            // //     middleText: '',
            // //     content: Container(
            // //       padding: EdgeInsets.symmetric(horizontal: 18.0),
            // //       child: Column(
            // //         children: [
            // //           Icon(
            // //             Icons.warning_amber_rounded,
            // //             size: 56,
            // //             color: AppColors.greyTextColor,
            // //           ),
            // //           const SizedBox(
            // //             height: 10,
            // //           ),
            // //           const Text16by600(
            // //             text: 'Alert',
            // //             fontSize: 20,
            // //           ),
            // //           const SizedBox(
            // //             height: 15,
            // //           ),
            // //           const FooterTextWithCenterAligned(
            // //             text: 'You don’t have sufficient balance Minimum balance should for 15 min chat.',
            // //             fontSize: 16,
            // //           ),
            // //           const SizedBox(
            // //             height: 10,
            // //           ),
            // //           CustomSolidButton(
            // //             buttonText: 'Top Up',
            // //             onClick: () {},
            // //             fontSize: 16,
            // //           )
            // //         ],
            // //       ),
            // //     ));
            // context.loaderOverlay.show();
            // WalletProvider().fetchWalletBalance().then((value) async {
            //   context.loaderOverlay.hide();
            //   var decodedData = jsonDecode(await value.stream.bytesToString());
            //   if (decodedData['wallet_details'] != null) {
            //     var walletBalance = num.parse(decodedData['wallet_details'][0]['amount'].toString());
            //     if (walletBalance < (30 * 30)) {
            //       Get.defaultDialog(
            //           titlePadding: EdgeInsets.zero,
            //           contentPadding: EdgeInsets.zero,
            //           title: '',
            //           middleText: '',
            //           content: Container(
            //             padding: EdgeInsets.symmetric(horizontal: 18.0),
            //             child: Column(
            //               children: [
            //                 Icon(
            //                   Icons.warning_amber_rounded,
            //                   size: 56,
            //                   color: AppColors.greyTextColor,
            //                 ),
            //                 SizedBox(
            //                   height: 10,
            //                 ),
            //                 Text16by600(
            //                   text: 'Alert',
            //                   fontSize: 20,
            //                 ),
            //                 SizedBox(
            //                   height: 15,
            //                 ),
            //                 FooterTextWithCenterAligned(
            //                   text: 'You don’t have sufficient balance to book this doctor, Minimum balance of Rs9800 required to book him/her',
            //                   fontSize: 16,
            //                 ),
            //                 SizedBox(
            //                   height: 10,
            //                 ),
            //                 CustomSolidButton(
            //                   buttonText: 'Top Up Wallet',
            //                   onClick: () {
            //                     Get.off(() => const WalletPageView());
            //                   },
            //                   fontSize: 16,
            //                 )
            //               ],
            //             ),
            //           ));
            //     } else {
            //       Get.find<CounselorsPageController>()
            //           .getSlotBook(widget.appointmentId, bookingDate: widget.bookingDate, doctorId: widget.doctorId, bookingTime: widget.bookingTime)
            //           .whenComplete(() => context.loaderOverlay.hide());
            //     }
            //   } else {
            //     context.loaderOverlay.hide();
            //     Get.defaultDialog(
            //         titlePadding: EdgeInsets.zero,
            //         contentPadding: EdgeInsets.zero,
            //         title: '',
            //         middleText: '',
            //         content: Container(
            //           padding: EdgeInsets.symmetric(horizontal: 18.0),
            //           child: Column(
            //             children: [
            //               Icon(
            //                 Icons.warning_amber_rounded,
            //                 size: 56,
            //                 color: AppColors.greyTextColor,
            //               ),
            //               const SizedBox(
            //                 height: 10,
            //               ),
            //               const Text16by600(
            //                 text: 'Alert',
            //                 fontSize: 20,
            //               ),
            //               SizedBox(
            //                 height: 15,
            //               ),
            //               const FooterTextWithCenterAligned(
            //                 text: 'You don’t have sufficient balance to book this doctor, Minimum balance of Rs${30 * 300} required to book him/her.',
            //                 fontSize: 16,
            //               ),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               CustomSolidButton(
            //                 buttonText: 'Top Up Wallet',
            //                 onClick: () {
            //                   Get.off(() => const WalletPageView());
            //                 },
            //                 fontSize: 16,
            //               )
            //             ],
            //           ),
            //         ));
            //   }
            // });
          },
          child: Container(
            width: 70,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
                color: slotsController.selectedSlot.value == widget.bookingTime.toString() ? AppColors.tealColor : Colors.grey.shade500,
                borderRadius: BorderRadius.circular(6.0)),
            child: Center(
                child: Text(
              widget.bookingTime,
              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
            )),
          ),
        ));
  }
}
