import 'package:school_app/all_constants/field_name_constant.dart';
import 'package:school_app/locator.dart';
import 'package:school_app/models/user_model.dart';
import 'package:school_app/services/authentication_service.dart';
import 'package:school_app/services/dialog_service.dart';
import 'package:school_app/services/navigation_service.dart';
import 'package:flutter/foundation.dart';
import 'base_model.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String _selectedRole = 'Select a User Role';

  String get selectedRole => _selectedRole;

  void setSelectedRole(dynamic role) {
    _selectedRole = role;
    notifyListeners();
  }

  Future signUp({
    @required MyUser newUser,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(
      passedUser: newUser,
      password: password,
    );

    setBusy(false);

    print('/// result is :   ${result.toString()}');

    if (result is bool) {
      if (result) {
       _navigationService.routeToUserMainScreen(_authenticationService.userRole());
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: result,
      );
    }
  }
}
