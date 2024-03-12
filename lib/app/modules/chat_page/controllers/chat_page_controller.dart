import 'package:get/get.dart';

import '../chat_list_model/chat_list_model.dart';
import '../providers/chat_list_provider.dart';

class ChatPageController extends GetxController {
  //TODO: Implement ChatPageController
  ChatListProvider chatListProvider=ChatListProvider();

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

Future<ChatListModel> getAllChatList({required String userId})async{
    return await chatListProvider.fetchChatList(userId: userId);
}
}
