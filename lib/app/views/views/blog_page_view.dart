import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/text_styles.dart';
import '../../appWidgets/universalAppBar.dart';
import '../../app_constants/app_images.dart';
import 'package:http/http.dart'as http;

import '../../app_constants/constants_end_points.dart';
class BlogPageView extends GetView {
  const BlogPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future callApiForBlog()async{
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${EndPoints.accessToken}'
      };
      var request = http.Request('GET', Uri.parse('${EndPoints.baseUrl}get-blogs'));


      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
       var decodedData= jsonDecode(await response.stream.bytesToString());
      return decodedData;
    }
    return Scaffold(
      appBar:CustomUniversalAppBar(title: 'Blog',appBar: AppBar(),),
      body: FutureBuilder(
          future: callApiForBlog(),
          builder: (builder,snapshot){
         if(snapshot.connectionState==ConnectionState.waiting){
           return const Center(child: Padding(
             padding: EdgeInsets.only(top: 28.0),
             child: CircularProgressIndicator(),
           ));
         }else if(snapshot.hasError){
           if (kDebugMode) {
             print('------------------------------BlogPageView------------------------------------');
             print(snapshot.data.toString());
           }
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(child: Text('Error Loading')),
              ],
            ),
          );
         }else if(snapshot.data['results']!=''){
           return Column(
             children: [
               Container(
                 height: 170,
                 width: Get.width,
                 child:Image.network(snapshot.data['results'][0]['banner'].toString(),width: Get.width,),
               ),
               SizedBox(height: 15,),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 6.0),
                 child: Column(
                   children: [
                     Row(
                       mainAxisSize: MainAxisSize.max,
                       children: [
                         Container(
                           height: 100,
                           width: 90,
                           child:ClipRRect(
                               borderRadius: BorderRadius.circular(16.0),
                               child: Image.asset(AppImages.marriage,fit: BoxFit.fitWidth,)),
                           decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(16.0),
                               boxShadow: [
                                 BoxShadow(
                                     offset: Offset(0.5, 6.0,),
                                     spreadRadius: 0.5,
                                     blurRadius: 8.0,
                                     color: Colors.black.withOpacity(0.5)
                                 )
                               ]
                           ),
                         ),
                         SizedBox(width: 10,),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisSize: MainAxisSize.max,
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Text14by400(text:snapshot.data['results'][0]['author'].toString(),fontSize: 12,),
                             Text14by400(text: snapshot.data['results'][0]['published_date'].toString(),fontSize: 12,),
                           ],
                         )
                       ],
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(vertical: 18.0),
                       child: Column(
                         children: [
                           Text( snapshot.data['results'][0]['description'].toString(),
                             style:TextStyle(fontSize: 13),softWrap: true,textAlign: TextAlign.justify,),
                           Padding(
                             padding: const EdgeInsets.symmetric(vertical: 18.0),
                             child: Row(
                               children: [
                                 Icon(Icons.thumb_up_alt_outlined,color: Colors.black,size: 13,),
                                 SizedBox(width: 5,),
                                 Text16by600(text: snapshot.data['results'][0]['likes_count'].toString(),fontSize: 12,),
                                 SizedBox(width: 15,),
                                 Icon(Icons.share,color: Colors.black,size: 13,),
                                 SizedBox(width: 5,),
                                 Text16by600(text: 'Share',fontSize: 12,),
                               ],
                             ),
                           )
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
             ],
           );
         }else{
           return Column(
             mainAxisAlignment: MainAxisAlignment.center,
             mainAxisSize: MainAxisSize.max,
             children: [
               Center(child: Text('No Data Found')),
             ],
           );
         }
      }),
    );
  }
}





