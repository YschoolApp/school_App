import 'package:school_app/services/authentication_service.dart';
import 'package:school_app/services/child_fire_store_service.dart';
import 'package:school_app/services/cloud_storage_service.dart';
import 'package:school_app/services/dialog_service.dart';
import 'package:school_app/services/user_firestore_service.dart';
import 'package:school_app/services/lessons_service.dart';
import 'package:school_app/services/children_service.dart';
import 'package:school_app/services/navigation_service.dart';
import 'package:school_app/services/task_fire_store_services.dart';
import 'package:school_app/services/push_notification_service.dart';
import 'package:school_app/utils/image_selector.dart';
import 'package:school_app/utils/languages_and_localization/app_language.dart';
import 'package:school_app/utils/no_connection_flush_bar.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AppLanguage());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => UserFireStoreService());
  locator.registerLazySingleton(() => TaskFireStoreService());
  locator.registerLazySingleton(() => ChildrenService());
  locator.registerLazySingleton(() => ChildFireStoreService());
  locator.registerLazySingleton(() => LessonsService());
  locator.registerLazySingleton(() => CloudStorageService());
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => ImageSelector());
  locator.registerLazySingleton(() => NoConnectionFlushBar());
}
