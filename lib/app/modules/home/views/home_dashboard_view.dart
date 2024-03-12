import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/modules/doctor_list_view/views/doctor_list_view_view.dart';
import 'package:gotherepy/app/modules/health_assesment_page/views/quiz_type_view.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../appWidgets/appBar.dart';
import '../../../appWidgets/appButtons.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../../views/views/intake_form_page_view.dart';
import '../../counselors_page/views/slots_booking_page_view.dart';
import '../../doctor_list_view/views/top_three_doctor_view.dart';
import '../../health_assesment_page/controllers/health_assesment_page_controller.dart';
import '../../plan_and_pricing/views/my_plan_page_view.dart';
import '../../schedule_calls_page/views/schedule_calls_page_view.dart';
import '../controllers/home_controller.dart';
import 'activities_view.dart';
import 'custom_app_drawer_view.dart';

class HomeDashboardView extends GetView<HomeController> {
  const HomeDashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find<HomeController>();
    Get.put(HealthAssesmentPageController());

    return Scaffold(
      // userInfo.userData.value.results!.username??
      appBar: CustomAppBar(title: 'GoTherapy', appBar: AppBar()),
      drawer: const CustomAppDrawerView(),

      ///Container used for scaffold background image
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    AppImages.backgroundPngImage
                ),
                repeat: ImageRepeat.repeat)),
        child: ListView(
          shrinkWrap: true,
          // physics: ScrollPhysics(),
          children: [
            ///counselling List in horizontal
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children:
            //       controller.home_counselling_list.map((counselling) =>
            //           CounsellingCard(counselling)).toList(),
            //   ),
            // ),
            SizedBox(
          height: 150,
          child: ListView.builder(
          scrollDirection: Axis.horizontal,
            itemCount: controller.home_counselling_list.length,
            itemBuilder: (context, index) {
              final item = controller.home_counselling_list[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Image(
                        image: AssetImage(item['image']),
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 8,),
                    RichText(
                      textAlign: TextAlign.center,
                        text: TextSpan(
                      children: [
                        TextSpan(text: item['activityName'].split(' ')[0] + '\n',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackish5E5E5E,
                                fontSize: 14,
                            ),
                        ),
                        TextSpan(text: item['activityName'].split(' ')[1],
                        style: TextStyle(
                            color: AppColors.blackish5E5E5E,
                          fontSize: 14
                        )),
                        // TextSpan(text: item['activityName'].split(' ')[2],
                        // style: TextStyle(
                        //     color: AppColors.blackish5E5E5E,
                        //   fontSize: 14
                        // ))
                      ]
                    ))
                  ],
                ),
              );
            },
          ),
        ),
            // SizedBox(
            //   height: 180,
            //   child: Obx(() => controller.counsellingList.isNotEmpty?
            //       ListView.builder(
            //       shrinkWrap: true,
            //       padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 18),
            //       scrollDirection: Axis.horizontal,
            //       itemCount: controller.counsellingList.length,
            //       itemBuilder: (context, index) {
            //         return Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: GestureDetector(
            //             onTap: (){
            //               Get.to(()=>CounsellingPageView(title: '${controller.counsellingList[index]['name']}',id: controller.counsellingList[index]['id'],));
            //             },
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               children: [
            //                  CircleAvatar(
            //                     radius: 40.0,onBackgroundImageError: (exception, stackTrace) => Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
            //                     backgroundImage: NetworkImage(controller.counsellingList[index]['icon'].toString()),
            //                     // child: Text('image')
            //                  ),
            //                 const SizedBox(height: 8,),
            //                 FooterTextWithCenterAligned(text: '${controller.counsellingList[index]['name']}'.replaceAll(' ', '\n'), fontSize: 12,),
            //                 //CustomSolidButton(buttonText: 'Book Now', onClick: (){},vPadding: 10,)
            //                 // Text16by400(text: '${controller.counsellingList[index]['counsellingType']}'.replaceAll(' ', '\n'),fontSize: 11,)
            //               ],
            //             ),
            //           ),
            //         );
            //       })
            //       :ListView.builder(
            //       shrinkWrap: true,
            //       padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 18),
            //       scrollDirection: Axis.horizontal,
            //       // physics:ScrollPhysics(),
            //       itemCount: 4,
            //       // itemCount: 6,
            //       itemBuilder: (context, index) {
            //         return Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: GestureDetector(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               children: [
            //                 SizedBox(
            //                   width:80.0,
            //                   child: ClipRRect(
            //                       borderRadius: BorderRadius.circular(50.0),
            //                       child: LinearProgressIndicator(minHeight: 80,color: Colors.transparent.withOpacity(0.1),)),
            //                 ),
            //                 SizedBox(height: 16,),
            //                 SizedBox(
            //                     width: 60,
            //                     child: LinearProgressIndicator(minHeight: 10,color: Colors.transparent.withOpacity(0.1),),)
            //                 //CustomSolidButton(buttonText: 'Book Now', onClick: (){},vPadding: 10,)
            //                 // Text16by400(text: '${controller.counsellingList[index]['counsellingType']}'.replaceAll(' ', '\n'),fontSize: 11,)
            //               ],
            //             ),
            //           ),
            //         );
            //       })
            //   ),
            // ),
            ///Banner
            controller.carousel_banner_list.isNotEmpty
                  ? CarouselSlider(
                      options: CarouselOptions(
                        height: 130.0,
                        // aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: false,
                        // autoPlayInterval: const Duration(seconds: 3),
                        // autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        // autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: false,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: controller.carousel_banner_list.map(
                              (item) => Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                                  decoration: BoxDecoration(
                                      color: AppColors.lightBlueBackground,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Image(
                                    image: AssetImage(item['image']),
                                    fit: BoxFit.fill,
                                  )
                              ),
                      ).toList(),
                    )
                  : SizedBox(
                      height: 150,
                      width: Get.width,
                      child: const Center(child: Text('Banner is loading')),
                    ),

            ///User Plans
            /*if (controller.doctorType.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const IntrinsicHeight(
                      child: Row(
                        children: [
                          VerticalDivider(
                            color: AppColors.tealColor,
                            thickness: 6,
                          ),
                          Text(
                            'My Plan',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        // aspectRatio: Get.pixelRatio,
                        viewportFraction: 1.0,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        // enlargeCenterPage: true,
                        // enlargeFactor: 0.3,
                        onPageChanged: (index, reason) {},
                        scrollDirection: Axis.horizontal,
                      ),
                      items: List.generate(
                        controller.doctorType.length,
                        (index) => InkWell(
                          onTap: () {
                            context.loaderOverlay.show();
                            try {
                              controller.provider.fetchDoctorListByDoctorType(controller.doctorType[index]['id'].toString()).then((value) {
                                if (value.value.results != null && value.value.results!.isNotEmpty) {
                                  context.loaderOverlay.hide();
                                  Get.to(() => DoctorListPageView(
                                        allTherapist: value,
                                        appbarTitle: controller.doctorType[index]['doctor_type'].toString(),
                                      ));
                                } else {
                                  context.loaderOverlay.hide();
                                  Fluttertoast.showToast(msg: 'Not available');
                                }
                              });
                            } catch (e) {
                              context.loaderOverlay.hide();
                              Fluttertoast.showToast(msg: 'Not available');
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
                            padding: EdgeInsets.all(5.0),
                            // width: Get.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage(AppImages.backgroundPngImage)),
                                gradient: LinearGradient(colors: [
                                  Colors.white70,
                                  Colors.white,
                                ],begin: Alignment.topLeft, end: Alignment.bottomRight),
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: [
                                  BoxShadow(offset: const Offset(1, 1), blurRadius: 2, spreadRadius: 3, color: AppColors.lightGreyTextColor.withOpacity(0.5))
                                ]),
                            child: Column(
                              // mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text16by700(text: controller.doctorType[index]['doctor_type'], color: Colors.black, fontSize: 18),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircularPercentIndicator(
                                      radius: 30.0,
                                      animation: true,
                                      animationDuration: 1200,
                                      linearGradient: const LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xFF44C3D4),
                                          Color(0xFF154688),
                                        ],
                                      ),
                                      lineWidth: 4.0,
                                      percent: 0.6,
                                      center: const Text(
                                        "60",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                                      ),
                                      circularStrokeCap: CircularStrokeCap.round,
                                      backgroundColor: AppColors.whiteColorShade,
                                      // progressColor: AppColors.tealColor,
                                      footer: const Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Column(
                                          children: [
                                            Text16by400(
                                              text: 'Session Left',
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    CircularPercentIndicator(
                                      radius: 30.0,
                                      animation: true,
                                      animationDuration: 1200,
                                      linearGradient: const LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xFF44C3D4),
                                          Color(0xFF154688),
                                        ],
                                      ),
                                      lineWidth: 4.0,
                                      percent: 0.6,
                                      center: const Text(
                                        "16",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                                      ),
                                      circularStrokeCap: CircularStrokeCap.round,
                                      backgroundColor: AppColors.whiteColorShade,
                                      // progressColor: AppColors.tealColor,
                                      footer: const Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Column(
                                          children: [
                                            Text16by400(
                                              text: 'Session Scheduled',
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    CircularPercentIndicator(
                                      radius: 30.0,
                                      animation: true,
                                      animationDuration: 1200,
                                      linearGradient: const LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xFF44C3D4),
                                          Color(0xFF154688),
                                        ],
                                      ),
                                      lineWidth: 4.0,
                                      percent: 0.6,
                                      center: const Text(
                                        "40",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                                      ),
                                      circularStrokeCap: CircularStrokeCap.round,
                                      backgroundColor: AppColors.whiteColorShade,
                                      // progressColor: AppColors.tealColor,
                                      footer: const Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Column(
                                          children: [
                                            Text16by400(
                                              text: 'Chat Session Left',
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: CustomSolidButton(
                                          fontSize: 14,
                                            buttonText: 'Buy More',
                                            onClick: () {
                                              // Get.to(() => const MyPlanPageView());
                                            })),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                        child: BorderButton(
                                          fontSize: 14,
                                            buttonText: 'View History',
                                            onClick: () {
                                              Get.to(() => ScheduleCallsPageView());
                                            }))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),*/
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const IntrinsicHeight(
                    child: Row(
                      children: [
                        VerticalDivider(
                          color: AppColors.tealColor,
                          thickness: 6,
                        ),
                        Text(
                          'My Plan',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                    padding: EdgeInsets.all(15.0),
                    height: 200,
                    // width: Get.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(AppImages.backgroundPngImage)),
                        gradient: LinearGradient(colors: [
                          Colors.white70,
                          Colors.white,
                        ],begin: Alignment.topLeft, end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(offset: const Offset(1, 1), blurRadius: 2, spreadRadius: 3, color: AppColors.lightGreyTextColor.withOpacity(0.5))
                        ]),
                    child: Column(
                      // mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text16by700(text: controller.doctorType[index]['doctor_type'], color: Colors.black, fontSize: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircularPercentIndicator(
                              radius: 30.0,
                              animation: true,
                              animationDuration: 1200,
                              linearGradient: const LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(0xFF44C3D4),
                                  Color(0xFF154688),
                                ],
                              ),
                              lineWidth: 4.0,
                              percent: 0.6,
                              center: const Text(
                                "60",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                              backgroundColor: AppColors.whiteColorShade,
                              // progressColor: AppColors.tealColor,
                              footer: const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Column(
                                  children: [
                                    Text16by400(
                                      text: 'Session Left',
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            CircularPercentIndicator(
                              radius: 30.0,
                              animation: true,
                              animationDuration: 1200,
                              linearGradient: const LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(0xFF44C3D4),
                                  Color(0xFF154688),
                                ],
                              ),
                              lineWidth: 4.0,
                              percent: 0.6,
                              center: const Text(
                                "16",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                              backgroundColor: AppColors.whiteColorShade,
                              // progressColor: AppColors.tealColor,
                              footer: const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Column(
                                  children: [
                                    Text16by400(
                                      text: 'Session Scheduled',
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            CircularPercentIndicator(
                              radius: 30.0,
                              animation: true,
                              animationDuration: 1200,
                              linearGradient: const LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(0xFF44C3D4),
                                  Color(0xFF154688),
                                ],
                              ),
                              lineWidth: 4.0,
                              percent: 0.6,
                              center: const Text(
                                "40",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                              backgroundColor: AppColors.whiteColorShade,
                              // progressColor: AppColors.tealColor,
                              footer: const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Column(
                                  children: [
                                    Text16by400(
                                      text: 'Chat Session Left',
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: CustomSolidButton(
                                    fontSize: 14,
                                    buttonText: 'Buy More',
                                    onClick: () {
                                      Get.to(() => const MyPlanPageView());
                                    })),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: BorderButton(
                                    fontSize: 14,
                                    buttonText: 'View History',
                                    onClick: () {
                                      Get.to(() => ScheduleCallsPageView());
                                    }))
                          ],
                        )
                      ],
                    ),
                  ),
                  /*CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      // aspectRatio: Get.pixelRatio,
                      viewportFraction: 1.0,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      // enlargeCenterPage: true,
                      // enlargeFactor: 0.3,
                      onPageChanged: (index, reason) {},
                      scrollDirection: Axis.horizontal,
                    ),
                    items: List.generate(
                      controller.doctorType.length,
                          (index) => InkWell(
                        onTap: () {
                          context.loaderOverlay.show();
                          try {
                            controller.provider.fetchDoctorListByDoctorType(controller.doctorType[index]['id'].toString()).then((value) {
                              if (value.value.results != null && value.value.results!.isNotEmpty) {
                                context.loaderOverlay.hide();
                                Get.to(() => DoctorListPageView(
                                  allTherapist: value,
                                  appbarTitle: controller.doctorType[index]['doctor_type'].toString(),
                                ));
                              } else {
                                context.loaderOverlay.hide();
                                Fluttertoast.showToast(msg: 'Not available');
                              }
                            });
                          } catch (e) {
                            context.loaderOverlay.hide();
                            Fluttertoast.showToast(msg: 'Not available');
                          }
                        },

                      ),
                    ),
                  ),*/
                ],
              ),
            ),

            ///Available Live therapists
            /*Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const IntrinsicHeight(
                    child: Row(
                      children: [
                        VerticalDivider(
                          color: AppColors.tealColor,
                          thickness: 6,
                        ),
                        Text(
                          'Live Therapist',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() => controller.therapists.value.results != null ?  CarouselSlider(
                      items: List.generate(
                        controller.therapists.value.results!.length,
                            (index) => InkWell(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                            // padding: EdgeInsets.only(left: 18.0,top: 18.0,right: 18.0),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.0), boxShadow: [
                              BoxShadow(offset: Offset(0.5, 1), blurRadius: 1, spreadRadius: 1, color: AppColors.lightGreyTextColor.withOpacity(0.5))
                            ]),
                            child: Obx(() => controller.therapists.value.results != null
                                ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0, top: 18.0, right: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
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
                                                // Get.to(() => ChatPageView());
                                              },
                                              child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.red,
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(140.0),
                                                      child: Image.network(controller.therapists.value.results != null &&
                                                          controller.therapists.value.results![index].avatar!.isNotEmpty
                                                          ? controller.therapists.value.results![index].avatar!
                                                          : ''))),
                                            ),
                                            circularStrokeCap: CircularStrokeCap.round,
                                            startAngle: 150,
                                            backgroundColor: Colors.transparent,
                                            footer: Row(
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
                                                if (controller.therapists.value.results != null &&
                                                    controller.therapists.value.results![index].degree != null)
                                                  Expanded(
                                                      child: Text(
                                                        controller.therapists.value.results![index].degree!,
                                                        style: TextStyle(
                                                            color: AppColors.greyTextColor,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500,
                                                            overflow: TextOverflow.ellipsis),
                                                        maxLines: 2,
                                                      ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text14by400(text: controller.therapists.value.results![index].name ?? ''),
                                                Text16by400(
                                                  text: 'Specialization',
                                                  fontSize: 12,
                                                  color: AppColors.greyColor676464,
                                                ),
                                                Wrap(
                                                  spacing: 2.0,
                                                  runSpacing: 2.0,
                                                  children: List.generate(
                                                      controller.therapists.value.results![index].specialization!.length > 4
                                                          ? 4
                                                          : controller.therapists.value.results![index].specialization!.length, (innerIndex) {
                                                    if (innerIndex >= 3) {
                                                      return Container(
                                                        padding: EdgeInsets.all(2.0),
                                                        child: Text16by400(
                                                          text: '+ ${controller.therapists.value.results![index].specialization!.length - 4}',
                                                          fontSize: 10,
                                                          color: AppColors.greyColor676464,
                                                          maxLine: 3,
                                                        ),
                                                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black12)),
                                                      );
                                                    }
                                                    return Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(12.0), border: Border.all(color: Colors.black12)),
                                                      child: Text16by400(
                                                        text: controller.therapists.value.results![index].specialization![innerIndex],
                                                        fontSize: 10,
                                                        color: AppColors.lightGreyTextColor,
                                                        maxLine: 3,
                                                      ),
                                                    );
                                                  }),
                                                ),
                                                if (controller.therapists.value.results![index].rate != null)
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                                                    child: Text16by400(
                                                      text: '₹ ${controller.therapists.value.results![index].rate} /mins',
                                                      fontSize: 12,
                                                      color: AppColors.lightGreyTextColor,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            // Spacer(),
                                            if (controller.therapists.value.results![index].title != null &&
                                                controller.therapists.value.results![index].title != '')
                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 6.0),
                                                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                                                decoration: ShapeDecoration(shape: StadiumBorder(), color: AppColors.containerColor),
                                                child: Text14by400(
                                                    text: controller.therapists.value.results![index].title!, color: AppColors.lightGreyTextColor),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  // onTap: () {
                                  //   context.loaderOverlay.show();
                                  //   WalletProvider().fetchWalletBalance().then((value) async {
                                  //     context.loaderOverlay.hide();
                                  //     var decodedData = jsonDecode(await value.stream.bytesToString());
                                  //     if (decodedData['wallet_details'] != null) {
                                  //       var walletBalance = num.parse(decodedData['wallet_details'][0]['amount'].toString());
                                  //       if (walletBalance < (30 * 300)) {
                                  //         Get.defaultDialog(
                                  //             titlePadding: EdgeInsets.zero,
                                  //             contentPadding: EdgeInsets.zero,
                                  //             title: '',
                                  //             middleText: '',
                                  //             content: Container(
                                  //               padding: EdgeInsets.symmetric(horizontal: 18.0),
                                  //               child: Column(
                                  //                 children: [
                                  //                   Icon(
                                  //                     Icons.warning_amber_rounded, size: 56, color: AppColors.greyTextColor,),
                                  //                   SizedBox(height: 10,),
                                  //                   Text16by600(text: 'Alert', fontSize: 20,),
                                  //                   SizedBox(height: 15,),
                                  //                   FooterTextWithCenterAligned(
                                  //                     text: 'You don’t have sufficient balance Minimum balance should for 15 min chat.', fontSize: 16,),
                                  //                   SizedBox(height: 10,),
                                  //                   CustomSolidButton(buttonText: 'Top Up Wallet', onClick: () {
                                  //                     Get.off(() => const WalletPageView());
                                  //                   }, fontSize: 16,)
                                  //                 ],
                                  //               ),
                                  //             )
                                  //         );
                                  //       } else {
                                  //         Get.to(() => const LiveCounselorView());
                                  //       }
                                  //
                                  //     } else {
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
                                  //                   Icons.warning_amber_rounded, size: 56, color: AppColors.greyTextColor,),
                                  //                 SizedBox(height: 10,),
                                  //                 Text16by600(text: 'Alert', fontSize: 20,),
                                  //                 SizedBox(height: 15,),
                                  //                 const FooterTextWithCenterAligned(
                                  //                   text: 'You don’t have sufficient balance Minimum balance of Rs${30 * 300} should for 15 min chat.', fontSize: 16,),
                                  //                 SizedBox(height: 10,),
                                  //                 CustomSolidButton(buttonText: 'Top Up Wallet', onClick: () {
                                  //                   Get.off(() => const WalletPageView());
                                  //                 }, fontSize: 16,)
                                  //               ],
                                  //             ),
                                  //           )
                                  //       );
                                  //     }
                                  //   });
                                  // },
                                  onTap: () {
                                    Get.to(() => CounselorProfileView(
                                      therapist: controller.therapists.value.results![index],
                                    ));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                    decoration: const BoxDecoration(
                                        color: AppColors.tealColor, borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0))),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'See Details',
                                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                                : Center(child: const CircularProgressIndicator())),
                          ),
                        ),
                      ),
                      options: CarouselOptions(
                        height: 198,
                        // aspectRatio: Get.pixelRatio,
                        viewportFraction: 1.0,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        // enlargeCenterPage: true,
                        // enlargeFactor: 0.3,
                        onPageChanged: (index, reason) {},
                        scrollDirection: Axis.horizontal,
                      )) : Row()),
                ],
              ),
            ),*/

            /// Activities
            const ActivitiesView(),
            // SizedBox(
            //   height: 250,
            //   child: Obx(() => ListView.builder(
            //       shrinkWrap: true,
            //       padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 18),
            //       scrollDirection: Axis.horizontal,
            //       // physics:ScrollPhysics(),
            //       itemCount: controller.counsellingList.length,
            //       // itemCount: 6,
            //       itemBuilder: (context, index) {
            //         return Container(
            //           margin: EdgeInsets.all(6.0),
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(12.0),
            //               border: Border.all(width: 1.0,color: AppColors.tealColor.withOpacity(0.5))
            //           ),
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: GestureDetector(
            //               onTap: (){
            //                 Get.to(()=>CounsellingPageView(title: '${controller.counsellingList[index]['counsellingType']}',id: index+1,));
            //               },
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: [
            //                   CircleAvatar(
            //                       radius: 40.0,
            //                       child: Text('image')),
            //                   SizedBox(height: 8,),
            //                   FooterTextWithCenterAligned(text: '${controller.counsellingList[index]['counsellingType']}'.replaceAll(' ', '\n'), fontSize: 12,),
            //                   CustomSolidButton(buttonText: 'Book Now', onClick: (){},vPadding: 10,)
            //                   // Text16by400(text: '${controller.counsellingList[index]['counsellingType']}'.replaceAll(' ', '\n'),fontSize: 11,)
            //                 ],
            //               ),
            //             ),
            //           ),
            //         );
            //       }),)
            // ),

            /// Doctor Session Booking
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height/4,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.doctor_image_list.length,
                  itemBuilder: (context, index) {
                    final item = controller.doctor_image_list[index];

                    final imageUrl = item['image'] as String?;
                    final doctorName = item['doctor_name'] as String? ?? '';
                    final price = item['price'] as String? ?? '';
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.lightBlueBackground, // Set the border color
                            width: 1.0, // Set the border width
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.white,
                              child: Image(
                                // image: AssetImage(item['image']),
                                image: AssetImage(imageUrl ?? ''),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Text(
                              // item['doctor_name'],
                              doctorName,
                              style: TextStyle(
                              color: AppColors.blackishTextColor,
                              fontSize: 14,
                            ), textAlign: TextAlign.center,),
                            Text(
                              // item['price'],
                              price,
                              style: TextStyle(
                              color: AppColors.blackish5E5E5E,
                              fontSize: 10,
                            ), textAlign: TextAlign.center,),
                            CustomSolidButton(
                                buttonText: 'Book Now',
                                vPadding: 6,
                                fontSize: 14,
                                onClick: (){
                                  context.loaderOverlay.show();
                                  getDoctorById('3').then((value){
                                    context.loaderOverlay.hide();
                                    Get.to(() => SlotsBookingPageView(
                                      doctorInfo: value,
                                    ));
                                  });
                                }),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            /// Self Assessment
            Column(
              children: [
                SizedBox(
                  height: 180,
                  child: GestureDetector(
                    onTap: (){
                      Get.to(() => QuizTypeView());
                    },
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      AppImages.assessment_banner,
                                  ),
                              fit: BoxFit.fill),
                              // gradient: LinearGradient(colors: [
                              //   Color(0xff90EE90).withOpacity(0.1),
                              //   Colors.white,
                              // ], begin: Alignment.bottomRight, end: Alignment.topLeft),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: const [BoxShadow(offset: Offset(0.5, 1.0), color: AppColors.whiteShadow, spreadRadius: -0.5, blurRadius: 1.0)]),
                          /*child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              const Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text14by500(
                                          text: 'Self Assesment score',
                                          fontSize: 24,
                                          color: Colors.black,
                                        ),
                                        FooterTextWithCenterAligned(
                                          text: 'Take our lifestyle quiz to have deeper insight!',
                                          fontSize: 12,
                                          textAlign: TextAlign.start,
                                        )
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                          AppImages().healthAssessment,
                                          height: 55,
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(() => const HealthAssessmentPageView());
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text14by500(
                                              text: 'Take Test',
                                              fontSize: 20,
                                              color: AppColors.tealColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          ),*/
                        ),
                        Positioned(
                          top: 20.0,
                          right: 30.0,
                          bottom: 20.0,
                          child: Image.asset(
                            AppImages.assessment_icon,
                            width: 40,
                            height: 80,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ...List.generate(
                  1,
                  (index) => Container(
                    child: BorderButton(
                        lMargin: 20,
                        rMargin: 20,
                        fontSize: 16,
                        buttonText: 'Intake Form',
                        onClick: () {
                          Get.to(() => IntakeFormPageView(
                            categoryId: controller.doctorType[index]['id'].toString(),
                          ));
                        }),
                  ),
                )
              ],
            ),
            SizedBox(height: 8,),

            ///Banners
            // Obx(() => BannerCarousel(
            //   animation: true,
            //
            //   viewportFraction: 0.5,
            //   showIndicator: false,
            //   spaceBetween: 8.0,
            //   customizedBanners: List.generate(
            //         controller.doctorBannersList.length,
            //             (index) => Container(
            //           width: MediaQuery.of(context).size.width,
            //               margin: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
            //               decoration: BoxDecoration(
            //                 boxShadow: [BoxShadow(offset: Offset(0.3, 0.1), blurRadius: 0.6, spreadRadius:0.5, color: AppColors.lightGreyTextColor.withOpacity(0.8))],
            //                 // border: Border.all(
            //                 //   color: Colors.green,
            //                 //   width: 3,
            //                 // ),
            //                 borderRadius: BorderRadius.circular(20),
            //
            //               ),
            //           child: Image.network(
            //             controller.doctorBannersList[index]["banner_image"],
            //             errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            //               return Center(child: Text("Image not available".tr));
            //             },
            //             fit: BoxFit.fill,
            //           ),
            //         )),
            //

            // )),
            // BorderButton(lMargin: 18.0,
            //   rMargin: 18.0,
            //   buttonText: 'Intake Form', onClick: (){
            //   Get.to(()=>const IntakeFormPageView());
            //   },),

            ///Our Live Stream Doctors
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: [
            //       ...List.generate(
            //           controller.doctorBannersList.length,
            //           (index) => Container(
            //                 width: MediaQuery.of(context).size.width / 3.5,
            //                 height: 100,
            //                 margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            //                 decoration: const BoxDecoration(color: Colors.grey),
            //                 child: Image.network(
            //                   controller.doctorBannersList[index]["banner_image"],
            //                   errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            //                     return Center(child: Text("Image not available".tr));
            //                   },
            //                   fit: BoxFit.fill,
            //                 ),
            //               )),
            //     ],
            //   ),
            // ),
            /*Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const IntrinsicHeight(
                    child: Row(
                      children: [
                        VerticalDivider(
                          color: AppColors.tealColor,
                          thickness: 6,
                        ),
                        Text(
                          'Our Live Stream Doctors',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/4,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.doctor_image_list.length,
                      itemBuilder: (context, index) {
                        final item = controller.doctor_image_list[index];
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.lightBlueBackground, // Set the border color
                                width: 0.8, // Set the border width
                              ),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Colors.white,
                                      child: Image(
                                        image: AssetImage(item['image']),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Positioned(
                                      // top: 10, // Adjust top position as needed
                                      // bottom: -5,
                                      bottom: -1,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.bluishColor,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 3,
                                              backgroundColor: Colors.green,
                                            ),
                                            const SizedBox(width: 4),
                                            const Text('Live', style: TextStyle(fontSize: 10, color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Text(item['doctor_name'], style: TextStyle(
                                  color: AppColors.blackishTextColor,
                                  fontSize: 14,
                                ), textAlign: TextAlign.center,),
                                CustomSolidButton(
                                    buttonText: 'Connect',
                                    vPadding: 6,
                                    fontSize: 14,
                                    onClick: (){
                                      Get.to(() => ChatConversationPageView(
                                        doctorId: '1',
                                        doctorAvatar: item['image'] ?? '',
                                        doctorName: item['doctor_name'] ?? '',
                                      ));
                                    }),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

class CounsellingCard extends StatelessWidget{
  final Map<String, dynamic> home_counselling_list;
  CounsellingCard(this.home_counselling_list);

  @override
  Widget build(BuildContext context){
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(home_counselling_list['image']),
          ),
          SizedBox(height: 8.0,),
          Text(
            home_counselling_list['activityName'],
            textAlign: TextAlign.center,
          )
        ],
    ),
    );
  }
}
