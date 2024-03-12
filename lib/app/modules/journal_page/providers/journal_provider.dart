import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import '../../../app_constants/constants_end_points.dart';
import '../../chat_page/chat_list_model/chat_list_model.dart';
class JournalProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future getJournalNotes() async {
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    print(EndPoints.accessToken.toString());
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/user/get-journal-answers'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseData = jsonDecode(await response.stream.bytesToString());
    print(responseData['records'].toString());
    // return responseData["records"]['question'];
    // Get.find<JournalPageController>().newNotesList.value.records=List.from(responseData['records']);
    // Get.find<JournalPageController>().newNotesList.value=Records.fromJson(responseData['records']);
    return responseData['records'];
  }
  Future fetchJournalQuestionsList() async {
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('GET', Uri.parse('http://gotherapy.care/backend/public/api/user/get-journal-questions'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseData = jsonDecode(await response.stream.bytesToString());
    print(responseData.toString());
    // return responseData["records"]['question'];
    return responseData;
  }
  Future saveNewNotes({required int id, required String note}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/journal-submit'));
    request.body = json.encode({
      "journal": [
        {
          "question_id": "1",
          "answer": note
        },
      ]
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('tttttttttttttttttttttttttttttttttttttt');
      }
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }



  }
  Future updateNotes(int id,String note) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
    var request = http.Request('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/journal-answer-update'));
    request.body = json.encode({
      "id": id,
      "answer": note
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }


  }
  Future deleteNotes(int id)async{
    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };

    var request = http.MultipartRequest('POST', Uri.parse('http://gotherapy.care/backend/public/api/user/journal-answer-delete'));
    request.fields.addAll({
      'id': id.toString()
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }
  Future<ChatListModel> fetchChatList({required String userId})async{

    var headers = {
      'Authorization': 'Bearer ${EndPoints.accessToken}'
    };
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