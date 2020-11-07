import 'package:school_app/locator.dart';
import 'package:school_app/models/user_model.dart';
import 'package:school_app/services/authentication_service.dart';
import 'package:flutter/widgets.dart';
import 'package:school_app/utils/connectivity_service.dart';


class BaseModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  MyUser get currentUser => _authenticationService.currentUser;

 bool checkIsTeacher(){
    return currentUser.userRole.toLowerCase() == 'teacher';
  }


  bool checkIsParent(){
    return currentUser.userRole.toLowerCase() == 'parent';
  }

  bool checkIsStudent(){
    return currentUser.userRole.toLowerCase() == 'student';
  }





  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }


  bool hasInternetConnection() {
    if (locator<ConnectivityServiceController>().currentConnectivityStatus ==
        ConnectivityStatus.Offline) {
      return false;
    } else {
      return true;
    }
  }


  

}


//class BaseModel extends GetxController {
//  bool _busy = false;
//
//  bool get busy => _busy;
//
//  void setBusy(bool value) {
//    _busy = value;
//    update();
//  }
//
//  final AuthenticationService _authenticationService =
//      locator<AuthenticationService>();
//
//  MyUser get currentUser => _authenticationService.currentUser;
//
//  bool hasInternetConnection() {
//    if (locator<ConnectivityServiceController>().currentConnectivityStatus ==
//        ConnectivityStatus.Offline) {
//      return false;
//    } else {
//      return true;
//    }
//  }
//
//}
