import 'package:get/get.dart';

import '../modules/auth_page/bindings/auth_page_binding.dart';
import '../modules/auth_page/views/auth_page_view.dart';
import '../modules/chat_page/bindings/chat_page_binding.dart';
import '../modules/chat_page/views/chat_page_view.dart';
import '../modules/counselling_page/bindings/counselling_page_binding.dart';
import '../modules/counselling_page/views/counselling_page_view.dart';
import '../modules/counselors_page/bindings/counselors_page_binding.dart';
import '../modules/counselors_page/views/counselors_page_view.dart';
import '../modules/doctor_list_view/bindings/doctor_list_view_binding.dart';
import '../modules/doctor_list_view/views/doctor_list_view_view.dart';
import '../modules/get_report_page/bindings/get_report_page_binding.dart';
import '../modules/get_report_page/views/get_report_page_view.dart';
import '../modules/health_assesment_page/bindings/health_assesment_page_binding.dart';
import '../modules/health_assesment_page/views/health_assesment_page_view.dart';
import '../modules/help_desk_page/bindings/help_desk_page_binding.dart';
import '../modules/help_desk_page/views/help_desk_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/intro_screen/bindings/intro_screen_binding.dart';
import '../modules/intro_screen/views/intro_screen_view.dart';
import '../modules/join_live_session/bindings/join_live_session_binding.dart';
import '../modules/join_live_session/views/join_live_session_view.dart';
import '../modules/journal_page/bindings/journal_page_binding.dart';
import '../modules/journal_page/views/journal_page_view.dart';
import '../modules/notification_page/bindings/notification_page_binding.dart';
import '../modules/notification_page/views/notification_page_view.dart';
import '../modules/order_history/bindings/order_history_binding.dart';
import '../modules/order_history/views/order_history_view.dart';
import '../modules/plan_and_pricing/bindings/plan_and_pricing_binding.dart';
import '../modules/plan_and_pricing/views/plan_and_pricing_view.dart';
import '../modules/profile_page/bindings/profile_page_binding.dart';
import '../modules/profile_page/views/profile_page_view.dart';
import '../modules/schedule_calls_page/bindings/schedule_calls_page_binding.dart';
import '../modules/schedule_calls_page/views/schedule_calls_page_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/wallet_page/bindings/wallet_page_binding.dart';
import '../modules/wallet_page/views/wallet_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
        name: _Paths.SPLASH_SCREEN,
        page: () => const SplashScreenView(),
        // binding: SplashScreenBinding(),
        bindings: [SplashScreenBinding(), HomeBinding()]),
    GetPage(
      name: _Paths.INTRO_SCREEN,
      page: () => const IntroScreenView(),
      binding: IntroScreenBinding(),
    ),
    GetPage(
        name: _Paths.AUTH_PAGE,
        page: () => const AuthPageView(),
        // binding: AuthPageBinding(),
        bindings: [AuthPageBinding(), HomeBinding(), SplashScreenBinding()]),
    GetPage(
      name: _Paths.COUNSELLING_PAGE,
      page: () => CounsellingPageView(
        title: '',
        id: 0,
      ),
      binding: CounsellingPageBinding(),
    ),
    GetPage(
      name: _Paths.SCHEDULE_CALLS_PAGE,
      page: () => const ScheduleCallsPageView(),
      binding: ScheduleCallsPageBinding(),
    ),
    GetPage(
      name: _Paths.WALLET_PAGE,
      page: () => const WalletPageView(),
      binding: WalletPageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => const ProfilePageView(),
      binding: ProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_HISTORY,
      page: () => const OrderHistoryView(),
      binding: OrderHistoryBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_PAGE,
      page: () => const NotificationPageView(),
      binding: NotificationPageBinding(),
    ),
    GetPage(
      name: _Paths.GET_REPORT_PAGE,
      page: () => const GetReportPageView(),
      binding: GetReportPageBinding(),
    ),
    GetPage(
      name: _Paths.HELP_DESK_PAGE,
      page: () => const HelpDeskPageView(),
      binding: HelpDeskPageBinding(),
    ),
    GetPage(
      name: _Paths.JOURNSAL_PAGE,
      page: () => const JournalPageView(),
      binding: JournalPageBinding(),
    ),
    GetPage(
      name: _Paths.PLAN_AND_PRICING,
      page: () => const PlanAndPricingView(),
      binding: PlanAndPricingBinding(),
    ),
    GetPage(
      name: _Paths.COUNSELORS_PAGE,
      page: () => const CounselorsPageView(),
      binding: CounselorsPageBinding(),
    ),
    GetPage(
      name: _Paths.HEALTH_ASSESMENT_PAGE,
      page: () => const HealthAssessmentPageView(),
      binding: HealthAssesmentPageBinding(),
    ),
    GetPage(
      name: _Paths.JOIN_LIVE_SESSION,
      page: () => const JoinLiveSessionView(),
      binding: JoinLiveSessionBinding(),
    ),
    GetPage(
      name: _Paths.DOCTOR_LIST_VIEW,
      page: () => const DoctorListPageView(),
      binding: DoctorListViewBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_PAGE,
      page: () => const ChatPageView(),
      binding: ChatPageBinding(),
    ),
  ];
}
