
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/appBar.dart';
import 'package:gotherepy/app/appWidgets/text_styles.dart';
import 'package:gotherepy/app/views/views/intake_form_page_view.dart';
import '../../../appWidgets/universalAppBar.dart';
import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../../schedule_calls_page/views/schedule_calls_page_view.dart';
import '../controllers/counselling_page_controller.dart';
import '../providers/counselling_provider.dart';

class CounsellingPageView extends GetView<CounsellingPageController> {
  final String title;
  final int id;
  const CounsellingPageView({required this.id, required this.title, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CounsellingPageController counsellingPageController=Get.put(CounsellingPageController());
    return Scaffold(
      appBar: CustomUniversalAppBar(title: title, appBar: AppBar()),
      body: FutureBuilder(
          future: CounsellingProvider().getCounsellorsBySubCategory(id),
          builder: (context,snapData){
            print(snapData);
            if(snapData.connectionState==ConnectionState.waiting){
              return SizedBox(
                  height: Get.height-100,
                  child: const Center(child: CircularProgressIndicator(),));
            }
            if(snapData.hasError){
              return const Center(child: Text('Something Error'),);
            }
            if(snapData.hasData){
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapData.data['records'].length,
                  itemBuilder: (context,index){
                    print(snapData.data['records'].length);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  InkWell(
                        onTap: (){
                          print('-------------pressed--------------------');
                          counsellingPageController.isPressed.value=true;
                          Future.delayed(const Duration(milliseconds: 60),(){
                            counsellingPageController.isPressed.value=false;
                          Get.to(()=>const IntakeFormPageView());
                          });
                        },
                        child: Container(
                          // margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: counsellingPageController.isPressed.value? Colors.white54:Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                counsellingPageController.isPressed.value?
                                BoxShadow(
                                    offset:Offset(-0.5, -0.5),
                                    color: AppColors.greyTextColor,
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5
                                )
                                    :BoxShadow(
                                    offset:Offset(2, 2),
                                    color: AppColors.greyTextColor,
                                    spreadRadius: 1,
                                    blurRadius: 1
                                ),
                              ]
                          ),
                          child: ListTile(
                            // onTap: (){},
                            horizontalTitleGap: 0.0,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            leading: Image.network('${snapData.data['records'][index]['icon']!}',height: 30,width: 30,
                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                              return const Icon(Icons.image_not_supported,color: Colors.deepOrange,);
                                }),
                            title:Text16by400(text: '${snapData.data['records'][index]['name']!}',fontSize: 14,color: AppColors.counsellingTextColor,),
                            trailing:const Icon(Icons.navigate_next),
                          ),
                        ),
                      ),
                    );
                  });
            }
            else {
              return const Center(
                child: Text('Something Error'),
              );
            }
          }),

    );
  }
}
