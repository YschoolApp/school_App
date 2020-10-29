import 'package:firebase_database/firebase_database.dart';
import 'package:school_app/locator.dart';
import 'package:school_app/services/authentication_service.dart';
import 'package:school_app/services/navigation_service.dart';
import 'package:school_app/services/push_notification_service.dart';
import 'package:school_app/viewmodels/base_model.dart';
import '../routers/route_names.dart';

class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  final PushNotificationService _pushNotificationService =
  locator<PushNotificationService>();

  Future handleStartUpLogic() async {
    // Register for push notifications

    await _pushNotificationService.initialise();
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();
    await Future.delayed(Duration(seconds: 2));

    if (hasLoggedInUser) {
      if (currentUser.userRole.toLowerCase() != 'teacher') {
        registerSubscription();
      }
      _navigationService.routeToUserMainScreen(currentUser.userRole);
    } else {
      _navigationService.navigateWithReplacementTo(LoginViewRoute);
    }
  }

  void registerSubscription() {
    print('class id is ' + currentUser.classId);
    if (currentUser.classId != null) {
      _pushNotificationService
          .subscribeToTopicNotification(currentUser.classId);
    }
  }
}
