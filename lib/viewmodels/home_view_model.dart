import 'package:school_app/locator.dart';
import 'package:school_app/services/authentication_service.dart';
import 'package:school_app/services/navigation_service.dart';
import 'package:school_app/viewmodels/base_model.dart';
import '../routers/route_names.dart';

class HomeViewModel extends BaseModel {

  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();

  final NavigationService _navigationService = locator<NavigationService>();

  navigateToTasksScreen() {
    _navigationService.navigateTo(TasksViewRoute);
  }


  navigateToTableScreen() {
    _navigationService.navigateTo(TableViewRoute);
  }

  


}
