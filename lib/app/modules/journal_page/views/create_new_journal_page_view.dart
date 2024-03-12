import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotherepy/app/appWidgets/appButtons.dart';
import 'package:gotherepy/app/appWidgets/appTextField.dart';
import 'package:gotherepy/app/modules/journal_page/controllers/journsal_page_controller.dart';

import '../../../appWidgets/universalAppBar.dart';

class CreateNewJournalPageView extends GetView {
  const CreateNewJournalPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    JournalPageController createJournalController = Get.find<JournalPageController>();
    TextEditingController abc = TextEditingController();
    return Scaffold(
      appBar: CustomUniversalAppBar(
        title: 'Create Journal',
        appBar: AppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key:createJournalController.formKey,
                child: Obx(() => ListView.builder(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: createJournalController.createNewNotesList.value.records!.question!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomTextFieldWithoutBorderAndHeading(
                        textEditingController: createJournalController.textEditingController[index],
                        hintText: createJournalController.createNewNotesList.value.records!.question![index].question.toString(),
                        maxLine: 3,
                      );
                    })),
              ),
              Offstage(offstage: false,child: CustomSolidButton(
                  buttonText: 'Save',
                  onClick: () {
                    if (createJournalController.formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      createJournalController.crateNewJournal(context);

                    }
                  }),)
                  //    createJournalController.createNewNotesList.value.records!.question!.indexWhere((element) => createJournalController.textEditingController[element]!=null);
                  //   JournalProvider().saveNewNotes(1, 'note');
                  // })
            ],
          ),
        ),
      ),
    );
  }
}
