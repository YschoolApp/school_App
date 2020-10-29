import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive/hive.dart';
import 'package:school_app/utils/local_notification_set.dart';

import '../locator.dart';
import 'navigation_service.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  print('myBackgroundMessageHandler : $message');
  PushNotificationService.showNotification(message);
  return Future<void>.value();
}

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  static NavigationService _navigationService = locator<NavigationService>();

  // LocalNotificationInit _localNotification = LocalNotificationInit();

  Future initialise() async {
    // LocalNotificationInit().initializing();

    if (Platform.isIOS) {
      // request permissions if we're on android
      _fcm.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, badge: true, alert: true));
    }

    _fcm.configure(
      // Called when the app is in the foreground and we receive a push notification
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        showNotification(message);
      },

      onBackgroundMessage: myBackgroundMessageHandler,

      // Called when the app has been closed completelly and it's opened
      // from the push notification.
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        showNotification(message);
        // LocalNotificationInit.showNotification(message);
        // _serialiseAndNavigate(message);
      },
      // Called when the app is in the background and it's opened
      // from the push notification.
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        showNotification(message);
        // LocalNotificationInit.showNotification(message);
        // _serialiseAndNavigate(message);
      },
    );
  }

  subscribeToTopicNotification(String classId) async {
    await _fcm.subscribeToTopic(classId);
  }

 static showNotification(Map<String, dynamic> message) async{
    print('----------------------');
    print(message);
    print('----------------------');

    // var pushTitle;
    // var pushText;
    var view;
    var subjectName;
    var taskId;

    if (message.containsKey('data')) {
      var nodeNotification = message['notification'];
      var nodeData = message['data'];
      // pushTitle = nodeNotification['title'];
      // pushText = nodeNotification['body'];
      view = nodeData['view'];
      subjectName = nodeData['subjectName'];
      taskId = nodeData['taskId'];
    }
    // else {
    //   pushTitle = message['title'];
    //   pushText = message['body'];
    // }

   //      {data: {google.sent_time: 1588863942303, click_action: FLUTTER_NOTIFICATION_CLICK,
   // google.original_priority: high, collapse_key: YourPackageName, google.delivered_priority: high,
   // sound: default, from: YourSenderId, google.message_id: 0:1588863942508709%a91ceea4a91ceea4, google.ttl: 60}, notification: {}}


   if (view != null) {
      // _navigationService.navigateTo(CreatePostViewRoute)
      await Hive.openBox(subjectName).then((value) => value.put(taskId, false));
      print('Navigate to $view');
      print('sub Name ' + subjectName.toString());
    }
  }
}
