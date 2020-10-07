import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:school_app/utils/local_notification_set.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  print('myBackgroundMessageHandler : $message');
  LocalNotificationInit.showNotification(message);
  return Future<void>.value();
}

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  // static NavigationService navigationService = locator<NavigationService>();
  // LocalNotificationInit _localNotification = LocalNotificationInit();

  Future initialise() async {

    LocalNotificationInit().initializing();

    if (Platform.isIOS) {
      // request permissions if we're on android
      _fcm.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, badge: true, alert: true));
    }

    _fcm.configure(
      // Called when the app is in the foreground and we receive a push notification
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        LocalNotificationInit.showNotification(message);
      },

      onBackgroundMessage: myBackgroundMessageHandler,

      // Called when the app has been closed completelly and it's opened
      // from the push notification.
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        LocalNotificationInit.showNotification(message);
        // _serialiseAndNavigate(message);
      },

      // Called when the app is in the background and it's opened
      // from the push notification.
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        LocalNotificationInit.showNotification(message);
        // _serialiseAndNavigate(message);
      },
    );
  }
}
