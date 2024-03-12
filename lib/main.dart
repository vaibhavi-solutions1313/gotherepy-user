import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gotherepy/app/app_utils/notification_services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'app/app_constants/constants_appColors.dart';
import 'app/app_model/user_info.dart';
import 'app/app_utils/services.dart';
import 'app/routes/app_pages.dart';

@pragma('vm:entry-point')
Future<void>_firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  await Firebase.initializeApp();
}
GetUserInfo userInfo=GetUserInfo();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  NotificationServices notificationServices=NotificationServices();
  await GetStorage.init();
  await initServices();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.bluishColor, // navigation bar color
    statusBarColor: AppColors.tealColor, // status bar color
  ));
  // userInfo.userData.value=UserInfoModel.fromJson(Get.find<Services>().box.read('userInfo'));
  runApp(
    GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Center(
        child: SpinKitSpinningLines(
          color: Colors.teal,
          size: 40.0,
        ),
      ),
      child: ResponsiveSizer(
          builder: (context, orientation, screenType) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Application",
              theme: ThemeData(
                useMaterial3: true,
                primaryColor:  AppColors.blackishTextColor,
                fontFamily: GoogleFonts.roboto(color: Colors.red).fontFamily,
                primaryTextTheme: GoogleFonts.robotoTextTheme(),
                appBarTheme: AppBarTheme(
                  color: AppColors.tealColor,
                ),
                iconTheme: IconThemeData(
                    color: Colors.white
                ),
              ),
              defaultTransition: Transition.circularReveal,
              transitionDuration: Duration(milliseconds: 800),
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              // home: UserProfileView(),
              // home: const cameraScreen(),
            );
          }
      ),
    ),

  );
}

Future<void> initServices()async {
  await Get.putAsync<Services>(() async => Services());
}