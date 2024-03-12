import 'package:flutter/material.dart';

import 'package:get/get.dart';

// class PlanContainerView extends GetWidget {
//   const PlanContainerView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PlanContainerView'),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text(
//           'PlanContainerView is working',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }
//Copy this CustomPainter code to the Bottom of the File
class RPSPlanAndPricingCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_2 = Path();
    path_2.moveTo(size.width*0.1551716,size.height*0.8264474);
    path_2.cubicTo(size.width*0.09196082,size.height*0.6911776,size.width*0.04155877,size.height*0.6983158,size.width*0.008614766,size.height*0.7270724);
    path_2.cubicTo(size.width*0.0009935877,size.height*0.7337303,size.width*-0.003765380,size.height*0.7502500,size.width*-0.004340292,size.height*0.7685987);
    path_2.cubicTo(size.width*-0.01047360,size.height*0.9643355,size.width*-0.01768497,size.height*1.323566,size.width*-0.003386257,size.height*1.400954);
    path_2.cubicTo(size.width*0.01542567,size.height*1.502763,size.width*0.1847330,size.height*1.546395,size.width*0.3002924,size.height*1.597303);
    path_2.cubicTo(size.width*0.3900058,size.height*1.636822,size.width*0.7721257,size.height*1.677257,size.width*0.9559211,size.height*1.604289);
    path_2.cubicTo(size.width*0.9656871,size.height*1.600408,size.width*0.9730380,size.height*1.582750,size.width*0.9742281,size.height*1.560599);
    path_2.cubicTo(size.width*0.9927807,size.height*1.214829,size.width*1.015652,size.height*0.3084513,size.width*0.9721462,size.height*0.3028454);
    path_2.cubicTo(size.width*0.9157105,size.height*0.2955730,size.width*0.7839064,size.height*0.4735875,size.width*0.6924094,size.height*0.8881053);
    path_2.cubicTo(size.width*0.5728187,size.height*1.429882,size.width*0.5257895,size.height*0.6953289,size.width*0.3927602,size.height*0.6117013);
    path_2.cubicTo(size.width*0.3166667,size.height*0.5638632,size.width*0.2267614,size.height*0.9796447,size.width*0.1551716,size.height*0.8264474);
    path_2.close();

    Paint paint_2_fill = Paint()..style=PaintingStyle.fill;
    paint_2_fill.color = Colors.white.withOpacity(0.2);
    canvas.drawPath(path_2,paint_2_fill);



  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}