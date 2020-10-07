import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:school_app/services/navigation_service.dart';

import '../locator.dart';


class LocalNotificationInit{

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;
   NavigationService navigationService = locator<NavigationService>();

  void initializing() async {
    //Initialisation should only be done once,and this can be done is in the
    // main function of your application. Alternatively, this can be done within
    // the first page shown in your app.
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    iosInitializationSettings = IOSInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);
      if (payload == 'create_post')
        navigationService.navigateTo('CreatePostViewRoute');
    }
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // return CupertinoAlertDialog(
    //   title: Text(title),
    //   content: Text(body),
    //   actions: <Widget>[
    //     CupertinoDialogAction(
    //         isDefaultAction: true,
    //         onPressed: () {
    //           print(" got pressed");
    //         },
    //         child: Text("Okay")),
    //   ],
    // );
  }

  static Future showNotification(Map<String, dynamic> message) async {
    print('----------------------');
    print(message);
    print('----------------------');

    var pushTitle;
    var pushText;
    var action;

    if (message.containsKey('data')) {
      var nodeNotification = message['notification'];
      var nodeData = message['data'];
      pushTitle = nodeNotification['title'];
      pushText = nodeNotification['body'];
      action = nodeData['view'];
    } else {
      pushTitle = message['title'];
      pushText = message['body'];
      action = message['view'];
    }

    print("params pushTitle : $pushTitle");
    print("params pushText : $pushText");
    print("params pushAction : $action");

    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'Channel ID', 'Channel title', 'channel body',
        playSound: true,
        priority: Priority.High,
        importance: Importance.Max,
        ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails(presentSound: false);

    NotificationDetails notificationDetails =
    NotificationDetails(androidNotificationDetails, iosNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      0, pushTitle, pushText, notificationDetails,payload: action,);

  }
}
