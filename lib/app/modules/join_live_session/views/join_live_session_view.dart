import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../appWidgets/universalAppBar.dart';
import '../controllers/join_live_session_controller.dart';

class JoinLiveSessionView extends GetView<JoinLiveSessionController> {
  const JoinLiveSessionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final JoinLiveSessionController liveSessionController = Get.put(JoinLiveSessionController());
    return Scaffold(
      appBar: CustomUniversalAppBar(title: 'Live Session', appBar: AppBar(),),
      body: Obx(() => ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        children: [
          // Container for the local video
          Container(
            height: 240,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(child: liveSessionController.videoPanel()),
          ),
          // Radio Buttons
          Row(children: <Widget>[
            Radio<bool>(
              value: true,
              groupValue:liveSessionController.isHost.value,
              onChanged: (value) => liveSessionController.handleRadioValueChange(value),
            ),
            const Text('Host'),
            Radio<bool>(
              value: false,
              groupValue:liveSessionController.isHost.value,
              onChanged: (value) =>liveSessionController.handleRadioValueChange(value),
            ),
            const Text('Audience'),
          ]),
          // Button Row
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: liveSessionController.isJoined.value?null:Colors.green
                  ),
                  child:  Text("Join",style: TextStyle(color: liveSessionController.isJoined.value?Colors.black:Colors.white),),
                  onPressed: () => {liveSessionController.join()},
                ),
              ),
              const SizedBox(width: 10),
              Expanded(

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: liveSessionController.isJoined.value?Colors.red:null
                  ),
                  child:  Text("Leave",style: TextStyle(color: liveSessionController.isJoined.value?Colors.white:Colors.black),),
                  onPressed: () => {liveSessionController.leave()},
                ),
              ),
            ],
          ),
          // Button Row ends
        ],
      )),
    );
  }
}
