import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/app_constants/app_images.dart';
import 'package:gotherepy/app/modules/auth_page/views/auth_page_view.dart';
import '../../../appWidgets/text_styles.dart';
import '../../../app_constants/constants_appColors.dart';
import '../controllers/intro_screen_controller.dart';
import 'dart:ui' as ui;
class IntroScreenView extends GetView<IntroScreenController> {
  const IntroScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    IntroScreenController introScreenController = Get.put(IntroScreenController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                scrollBehavior: ScrollBehavior(),
                scrollDirection: Axis.horizontal,
                controller: introScreenController.pageController,
                onPageChanged: (val) {
                   introScreenController.pageCurrentIndex.value=val;
                },
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomPaint(
                        size: Size(Get.width, (Get.width*1.283387622149837).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        painter: RPSCustomBackgroundPainter(),
                          child: Image.asset(AppImages.introScreen1Image,height: 450,)
                      ),
                      const Text('Talk. Resolve. Heal.',style: TextStyle(
                        color: AppColors.bluishColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                          height: 3
                      ),),
                      const Text16by400(text: 'Counselling Therapy Session With Top Experts.',),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomPaint(
                        size: Size(Get.width, (Get.width*1.283387622149837).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        painter: RPSCustomBackgroundPainter(),
                          child: Image.asset(AppImages.introScreen2Image,height: 450,)
                      ),
                      const Text('Talk. Resolve. Heal.',style: TextStyle(
                        color: AppColors.bluishColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                          height: 3
                      ),),
                      const Text16by400(text: 'Counselling Therapy Session With Top Experts.',),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomPaint(
                        size: Size(Get.width, (Get.width*1.283387622149837).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        painter: RPSCustomBackgroundPainter(),
                          child: Image.asset(AppImages.introScreen3aImage,height: 450,)
                      ),
                      const Text('Talk. Resolve. Heal.',style: TextStyle(
                        color: AppColors.bluishColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                          height: 3
                      ),),
                      const Text16by400(text: 'Counselling Therapy Session With Top Experts.',),
                    ],
                  ),

                ],
              ),
            ),
            Container(
              height: 70,
              child: Obx(() => introScreenController.pageCurrentIndex.value==0? GestureDetector(
                onTap: (){
                  introScreenController.pageCurrentIndex.value==1;
                  introScreenController.jumpToNextPage(1);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:  [
                    Text16by400(text: 'Next',color: AppColors.tealColor,),
                    SizedBox(width: 10,),
                    CircleAvatar(
                        backgroundColor: AppColors.whiteShadow,
                        radius: 16,
                        child: Icon(Icons.navigate_next))
                  ],
                ),
              )
                  :introScreenController.pageCurrentIndex.value==1?Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      GestureDetector(
                        onTap: (){
                          introScreenController.pageCurrentIndex.value==1;
                          introScreenController.jumpToNextPage(0);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.whiteShadow,
                              radius: 16,
                                child: Icon(Icons.navigate_before)),
                            SizedBox(width: 10,),
                            Text16by400(text: 'Back',color: AppColors.tealColor,),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          introScreenController.pageCurrentIndex.value==1;
                          introScreenController.jumpToNextPage(2);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text16by400(text: 'Next',color: AppColors.tealColor,),
                            SizedBox(width: 10,),
                            CircleAvatar(
                                backgroundColor: AppColors.whiteShadow,
                                radius: 16,
                                child: Icon(Icons.navigate_next)),
                          ],
                        ),
                      ),
                    ],
                  )
                  : InkWell(
                onTap: (){
                  Get.to(()=>const AuthPageView());
                },
                    child: CustomPaint(
                size: Size(Get.width, (Get.width*0.21035598705501618).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: RPSCustomPainter(),
                           child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text16by600(text: 'Get Started',color: Colors.white),
                        CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 16,
                            child: Icon(Icons.navigate_next))
                      ],
                    ),
                ),
              ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//Add this CustomPaint widget to the Widget Tree


//Copy this CustomPainter code to the Bottom of the File
class RPSCustomBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.02084759,size.height*0.3322284);
    path_0.cubicTo(size.width*-0.002349629,size.height*0.1692056,size.width*-0.01394824,size.height*0.08769442,size.width*0.04780098,size.height*0.03867716);
    path_0.cubicTo(size.width*0.1095505,size.height*-0.01034013,size.width*0.2143583,size.height*-0.002819594,size.width*0.4239739,size.height*0.01222152);
    path_0.lineTo(size.width*0.6563160,size.height*0.02889340);
    path_0.cubicTo(size.width*0.8235700,size.height*0.04089467,size.width*0.9071954,size.height*0.04689543,size.width*0.9560782,size.height*0.09066421);
    path_0.cubicTo(size.width*1.004961,size.height*0.1344332,size.width*1.001039,size.height*0.1997980,size.width*0.9931954,size.height*0.3305279);
    path_0.lineTo(size.width*0.9697720,size.height*0.7208832);
    path_0.cubicTo(size.width*0.9617883,size.height*0.8539467,size.width*0.9577980,size.height*0.9204797,size.width*0.9026319,size.height*0.9606497);
    path_0.cubicTo(size.width*0.8474691,size.height*1.000822,size.width*0.7620065,size.height*0.9994315,size.width*0.5910847,size.height*0.9966472);
    path_0.lineTo(size.width*0.4397329,size.height*0.9941853);
    path_0.cubicTo(size.width*0.2846883,size.height*0.9916599,size.width*0.2071664,size.height*0.9903985,size.width*0.1556078,size.height*0.9536701);
    path_0.cubicTo(size.width*0.1040492,size.height*0.9169416,size.width*0.09550456,size.height*0.8568909,size.width*0.07841498,size.height*0.7367919);
    path_0.lineTo(size.width*0.02084759,size.height*0.3322284);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(Offset(size.width*0.1482085,size.height*-2.030457), Offset(size.width*0.8648208,size.height*0.9746193), [Color(0xff10AAB4).withOpacity(1),Color(0xff44C3D4).withOpacity(1)], [0,1]);
    canvas.drawPath(path_0,paint_0_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.01394353,size.height*0.4026246);
    path_0.cubicTo(size.width*-0.01261757,size.height*0.2399108,size.width*0.01209553,size.height*0.003322815,size.width*0.05541780,size.height*0.005576446);
    path_0.lineTo(size.width*0.9483301,size.height*0.05202585);
    path_0.cubicTo(size.width*0.9824887,size.height*0.05380292,size.width*1.006932,size.height*0.2095800,size.width*0.9975534,size.height*0.3657400);
    path_0.lineTo(size.width*0.9701877,size.height*0.8214215);
    path_0.cubicTo(size.width*0.9638414,size.height*0.9271200,size.width*0.9435210,size.height,size.width*0.9203981,size.height);
    path_0.lineTo(size.width*0.1368178,size.height);
    path_0.cubicTo(size.width*0.1208191,size.height,size.width*0.1057184,size.height*0.9648415,size.width*0.09591003,size.height*0.9047554);
    path_0.lineTo(size.width*0.01394353,size.height*0.4026246);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xff10AAB4).withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}



