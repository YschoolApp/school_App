import 'package:school_app/routers/route_names.dart';
import 'package:school_app/services/authentication_service.dart';
import 'package:school_app/services/navigation_service.dart';
import '../locator.dart';
import 'base_model.dart';

class DrawerViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  final NavigationService _navigationService = locator<NavigationService>();

  signOut() async {
    await _authenticationService.signOut();
    navigateToLoginView();
  }

  Future navigateToLoginView() async {
    await _navigationService.navigateWithReplacementTo(LoginViewRoute);
  }

  Future navigateToHomeView() async {
    await _navigationService.pop();
    await _navigationService.routeToUserMainScreen(currentUser.userRole);
  }

  Future navigateToClaim() async {
    await _navigationService.pop();
    await _navigationService.navigateTo(SendClaimViewRoute);
  }

  Future navigateToTableView() async {
    await _navigationService.pop();
    await _navigationService.navigateTo(TableViewRoute);
  }

  Future navigateToTasksView() async {
    await _navigationService.pop();
    await _navigationService.navigateTo(TasksViewRoute);
  }
}
