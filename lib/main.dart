import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:school_app/routers/router.dart';
import 'package:school_app/services/dialog_service.dart';
import 'package:school_app/services/navigation_service.dart';
import 'package:school_app/ui/views/startup_view.dart';
import 'package:school_app/utils/dialog_manager.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  await Hive.initFlutter('flutter_with_fireBase');

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eSchool',
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DialogManager(child: child),
        ),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
        primaryColor: Colors.indigo,//Color(0xff19c7c1),
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Tajawal',
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: StartUpView(),
      onGenerateRoute: generateRoute,
    );
  }
}

// taskkill /F /IM dart.exe
