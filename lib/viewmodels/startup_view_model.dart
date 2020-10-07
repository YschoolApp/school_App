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
    await Future.delayed(Duration(seconds: 4));
    if (hasLoggedInUser) {
      _navigationService.navigateTo(HomeViewRoute);
    } else {
      _navigationService.navigateTo(LoginViewRoute);
    }
  }
}
