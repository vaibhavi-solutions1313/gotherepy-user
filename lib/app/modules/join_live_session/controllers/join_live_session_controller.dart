import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class JoinLiveSessionController extends GetxController {
  //TODO: Implement JoinLiveSessionController
  static const String appId = "3e6cffb3d889454daf2c1113fc422830";
  String channelName = "bikram";
  String token = "007eJxTYOBfLJg59WuKKmPli/Z/RqzmbQe8dBXO8tT8mbJqCyt/8zoFBuNUs+S0tCTjFAsLSxNTk5TENKNkQ0ND47RkEyMjC2MDcfm5KQ2BjAyubs8ZGKEQxGdjSMrMLkrMZWAAAOm4HcU=";
  int uid = 0; // uid of the local user
  int? remoteUid; // uid of the remote user
  RxBool isJoined = false.obs; // Indicates if the local user has joined the channel
  RxBool isHost = true.obs; // Indicates whether the user has joined as a host or audience
  late RtcEngine agoraEngine;

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey
  = GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }


  Widget videoPanel() {
    if (!isJoined.value) {
      return const Text(
        'Join a channel',
        textAlign: TextAlign.center,
      );
    } else if (isHost.value) {
      // Show local video preview
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: agoraEngine,
          canvas: VideoCanvas(uid: 0),
        ),
      );
    } else {
      // Show remote video
      if (remoteUid != null) {
        return AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: agoraEngine,
            canvas: VideoCanvas(uid: remoteUid),
            connection: RtcConnection(channelId: channelName),
          ),
        );
      } else {
        return const Text(
          'Waiting for a host to join',
          textAlign: TextAlign.center,
        );
      }
    }
  }
// Set the client role when a radio button is selected
  void handleRadioValueChange(bool? value) async {
      isHost.value = (value == true);
    if (isJoined.value) leave();
  }

  Future<void> setupVideoSDKEngine() async {
    // retrieve or request camera and microphone permissions
    await [Permission.microphone, Permission.camera].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(
        appId: appId
    ));

    await agoraEngine.enableVideo();

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage("Local user uid:${connection.localUid} joined the channel");

            isJoined.value = true;

        },
        onUserJoined: (RtcConnection connection, int remoteUid_, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
            remoteUid = remoteUid_;
        },
        onUserOffline: (RtcConnection connection, int remoteUid_,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
            remoteUid = null;
        },
      ),
    );
  }

  void join() async {

    // Set channel options
    ChannelMediaOptions options;

    // Set channel profile and client role
    if (isHost.value) {
      options = const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      );
      await agoraEngine.startPreview();
    } else {
      options = const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleAudience,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      );
    }

    await agoraEngine.joinChannel(
      token: token,
      channelId: channelName,
      options: options,
      uid: uid,
    );
  }
  void leave() {

      isJoined.value = false;
      remoteUid = null;

    agoraEngine.leaveChannel();
  }


  @override
  void onInit() {
    setupVideoSDKEngine();
    super.onInit();
  }
  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    agoraEngine.release();
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    // rtcEngine?.destroy();
  }

}



///////////////////////////////
//0733d9206edf447bb1ee4c51f3dde75c