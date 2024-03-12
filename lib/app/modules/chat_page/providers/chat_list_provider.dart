import 'dart:convert';
import 'package:get/get.dart';
import 'package:gotherepy/app/app_constants/constants_end_points.dart';
import 'package:http/http.dart'as http;
import '../chat_list_model/chat_list_model.dart';

class ChatListProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<ChatListModel> fetchChatList({required String userId})async{

 var headers = {
   'Authorization': 'Bearer ${EndPoints.accessToken}'
 };
 print('${EndPoints.accessToken}');
 print(userId);
 var request = http.MultipartRequest('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/get-user-chat-sessions'));
 request.fields.addAll({
   'user_id': userId
 });

 request.headers.addAll(headers);

 http.StreamedResponse response = await request.send();
 ChatListModel chatListModel=ChatListModel();
 if (response.statusCode == 200) {
   var data =jsonDecode(await response.stream.bytesToString());
 chatListModel=ChatListModel.fromJson(data);
   return chatListModel;
 }
 else {
   print(response.reasonPhrase);
   return chatListModel;
 }
  }
}
