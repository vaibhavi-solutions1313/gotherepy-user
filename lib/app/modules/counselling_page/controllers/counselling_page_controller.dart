import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_constants/app_images.dart';
import '../../../app_constants/constants_appColors.dart';
import '../providers/counselling_provider.dart';

class CounsellingPageController extends GetxController {
  //TODO: Implement CounsellingPageController
  var isPressed=false.obs;
 RxList<Map<String, String>>counselingItem=[
   {'image':AppImages.relationship_issues,
     'title':'Relationship Issues'
   },
   {'image':AppImages.depression,
     'title':'Depression'
   },
   {'image':AppImages.career,
     'title':'Career'
   },
   {'image':AppImages.marriage,
     'title':'Marriage'
   },
   {'image':AppImages.abuse,
     'title':'Abuse'
   },
   {'image':AppImages.trauma,
     'title':'Trauma'
   },
   {'image':AppImages.anxiety,
     'title':'Anxiety'
   },
   {'image':AppImages.relationship_issues,
     'title':'Relationship Issues'
   },
 ].obs;
 Future getCounselingItem(int id)async{
   CounsellingProvider().getCounsellorsBySubCategory(id);
 }
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


}
