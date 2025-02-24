import 'package:flutter/material.dart';
import '../routers/route_names.dart' show ParentHomeViewRoute, StudentHomeViewRoute, TeacherHomeViewRoute;

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

   pop() {
    return _navigationKey.currentState.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateWithReplacementTo(String routeName, {dynamic arguments}) {
    
    return _navigationKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  routeToUserMainScreen(String userRole){
    switch (userRole.toLowerCase()) {
      case "parent":
        navigateWithReplacementTo(ParentHomeViewRoute);
        break;
      case "student":
        navigateWithReplacementTo(StudentHomeViewRoute);
        break;
      case "teacher":
        navigateWithReplacementTo(TeacherHomeViewRoute);
        break;
    }
  }
}
