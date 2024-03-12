import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/modules/journal_page/providers/journal_provider.dart';

import '../../../app_model/new_notes_list.dart'as new_list;
import '../../chat_page/chat_list_model/chat_list_model.dart';
import '../notesModel.dart';

class JournalPageController extends GetxController {
  //TODO: Implement JournalPageController
  var isSelectedAll=false.obs;
  var isRefreshScreen=false.obs;
  final formKey = GlobalKey<FormState>();
  JournalProvider journalProvider=JournalProvider();
  var createNewNotesList=CreateNewNotes().obs;
  var newNotesList=[].obs;
  TextEditingController editNotes=TextEditingController();
   late List<TextEditingController> textEditingController;
   var refreshJournal = false.obs;


  getQuestionsList(){
    JournalProvider().fetchJournalQuestionsList().then((value) {
      createNewNotesList.value = CreateNewNotes.fromJson(value);
      textEditingController=List.generate(createNewNotesList.value.records!.question!.length, (index) => TextEditingController());
    });
  }
  crateNewJournal(BuildContext context){
    journalProvider.saveNewNotes(id: 2,note: 'fjjfjdjk').then((value){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      Get.back();
    });

  }
  deleteNotes(BuildContext context,int index){
    journalProvider.updateNotes(index + 1, editNotes.text);
  }
  Future<ChatListModel> getAllChatList({required String userId})async {
    return await journalProvider.fetchChatList(userId: userId);
  }
  @override
  void onInit() {
    getQuestionsList();
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

 getJournal(){

 }
}