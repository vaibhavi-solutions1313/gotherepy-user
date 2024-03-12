import 'dart:math';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
const String appId = "3e6cffb3d889454daf2c1113fc422830";
class LiveCounselorView extends GetView {
  const LiveCounselorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String channelName = "bikram";
  String token ='007eJxTYHjYtbFQRfB9lULEX1Oj2xm1O/kcQrdI/dOUSVu/YJO653YFBuNUs+S0tCTjFAsLSxNTk5TENKNkQ0ND47RkEyMjC2MDb4melIZARgaeFREsjAwQCOKzMSRlZhcl5jIwAAAz9x5I';
  int uid = 0; // uid of the local user

  int? _remoteUid=1; // uid of the remote user
  var isJoined = false.obs; // Indicates if the local user has joined the channel
  RtcEngine agoraEngine = createAgoraRtcEngine(); // Agora engine instance
  var left=8.0.obs;
  var top=0.0.obs;

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold
  void join() async {
    await agoraEngine.startPreview();

    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token: token,
      channelId: channelName,
      options: options,
      uid: uid,
    );
  }

  void leave() {
    setState(() {
      isJoined.value = false;
      _remoteUid = null;
    });
    agoraEngine.leaveChannel();
  }

  Future<void> setupVideoSDKEngine() async {
    // retrieve or request camera and microphone permissions
    await [Permission.microphone, Permission.camera].request();

    //create an instance of the Agora engine
    // agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(appId: appId));

    await agoraEngine.enableVideo();

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage("Local user uid:${connection.localUid} joined the channel");
          setState(() {
            isJoined.value = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }

// Release the resources when you leave
  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    agoraEngine.release();
    super.dispose();
  }

  @override
  void initState() {
    setupVideoSDKEngine();
    super.initState();
    // Set up an instance of Agora engine

  }
// Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            children: [
              // Container for the local video
              Container(
                height: Get.height-10,
                decoration: BoxDecoration(),
                child: Center(child: _remoteVideo()),
                // child: Center(child: _localPreview()),
              ),
              Obx(() =>  Positioned(
                left: left.value,
                top: top.value,
                child: GestureDetector(
                  onPanUpdate: (detail){
                    left.value=max(0,left.value +detail.delta.dx);
                    top.value=max(0,top.value +detail.delta.dy);
                    setState(() {});
                  },
                  child: Container(
                    color: Colors.black,
                    height: 220,
                    width: 200,
                    child: Center(child: _localPreview()),
                  ),
                ),
              )),
              Obx(() => Positioned(
                width: Get.width,
                bottom: 0.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Draggable(
                      // axis: Axis.vertical,
                      feedback: TextButton(
                        style: TextButton.styleFrom(backgroundColor: isJoined.value ?Colors.red:Colors.grey),
                        onPressed: isJoined.value ? () => {
                          isJoined.value=false,
                          leave()} : null,
                        child: const Text("Leave"),
                      ),
                      child: TextButton(
                        style:  TextButton.styleFrom(backgroundColor: isJoined.value ?Colors.red:Colors.grey),
                        onPressed: isJoined.value ? () => {
                          isJoined.value=false,
                          leave()} : null,
                        child: const Text("Leave",style: TextStyle(color:Colors.white )),
                      ),
                    ),
                    Draggable(
                      axis: Axis.vertical,
                      feedback: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: isJoined.value ? Colors.grey.withOpacity(0.5):Colors.green
                        ),
                        onPressed: isJoined.value ? null : () => {
                          isJoined.value=true,
                          join()},
                        child: const Text("Join"),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: isJoined.value ? Colors.grey.withOpacity(0.5):Colors.green
                        ),
                        onPressed: isJoined.value ? null : () => {
                          isJoined.value=true,
                          join()},
                        child:  Text("Join",style: TextStyle(color:Colors.white ),),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ));
  }
  // Display local video preview
  Widget _localPreview() {
    if (isJoined.value) {
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: agoraEngine,
          canvas: VideoCanvas(uid: 0),
        ),
      );
    } else {
      return const Text(
        'Your Camera',style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      );
    }
  }

// Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: agoraEngine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: channelName),
        ),
      );
    } else {
      String msg = '';
      if (isJoined.value) msg = 'Waiting for a remote user to join';
      return Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black),
      );
    }
  }
  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }




}
