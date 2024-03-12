import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../app_constants/constants_appColors.dart';

  import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
class DoctorProfilePageView extends GetView<DoctorProfilePageController> {
  const DoctorProfilePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DoctorProfilePageController doctorProfilePageController = Get.put(DoctorProfilePageController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                    Text(
                      "@peppy_hug",
                      style: TextStyle(fontSize: 16,color: Colors.white),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white38,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Text(
                          "0",
                          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Icon(Icons.wallet),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              color: Colors.white10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        child: Image.network("https://picsum.photos/800/350"),
                      ),
                      Positioned(
                        bottom: -38,
                        left: 25,
                        child: Column(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                  color: Colors.pink.shade300, border: Border.all(color: Colors.black, width: 8), borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                  child: Text(
                                "P",
                                style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w900),
                              )),
                            ),
                            Text(
                              "John Doe",
                              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w900),
                            ),
                            Text(
                              "December 14, 2023",
                              style: TextStyle(fontSize: 14, color: Colors.white54, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          style: TextButton.styleFrom(backgroundColor: AppColors.appThemeColor),
                          onPressed: () {},
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white10,
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TabBar(
                        unselectedLabelStyle: TextStyle(color: Colors.white70),
                        unselectedLabelColor: Colors.white70,
                        indicatorColor: AppColors.appThemeColor,
                        labelColor: AppColors.appThemeColor,
                        tabs: [
                          Tab(text: 'Thoughts'),
                          Tab(text: 'Replies'),
                          Tab(text: 'Anonymous'),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.black,
                          child: TabBarView(
                            children: [
                              Center(
                                child: Text(
                                  'Content for Tab 1',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Content for Tab 2',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Content for Tab 3',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );


  }
}




class DoctorProfilePageController extends GetxController {
  //TODO: Implement DoctorProfilePageController

  var doctorDetail=[
    {
      'title':'Name',
      'value':'Doctor name here',
      'icon':Icons.edit,
    },
    {
      'title':'Gender',
      'value':'.....',
      'icon':Icons.person,
    },
    {
      'title':'About',
      'value':'ad',
      'icon':Icons.edit,
    },
    {
      'title':'Specialization',
      'value':"doctorInfo.records!.degree,",
      'icon':Icons.folder_special,
    },
    {
      'title':'Experience',
      'value':'fhbfg',
      'icon':Icons.timelapse_rounded,
    },

  ].obs;
  RxBool enableTexField = true.obs;
  Rx<String?> userImagePath=''.obs;
  Rx<String?> qualificationCertificateImagePath=''.obs;
  Rx<String?> identityProofImagePath=''.obs;
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


  List<DateTime> selectedDates = [];

  Future<void> selectDateAndTime({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

          selectedDates.add(selectedDateTime);

      }
    }
  }
  Future<String?> pickImageFromGallery()async{
    XFile? file=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(file!.path.isNotEmpty){
      if (kDebugMode) {
        print(file.path.toString());
      }
      return file.path;
    }else{
      return '';
    }
  }
}
