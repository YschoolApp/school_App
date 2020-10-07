import 'package:school_app/models/post.dart';
import 'file:///C:/Users/mushtaq/AndroidStudioProjects/school_app/lib/routers/route_names.dart';
import 'package:school_app/ui/views/create_post_view.dart';
import 'package:school_app/ui/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:school_app/ui/views/login_view.dart';
import 'package:school_app/ui/views/signup_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
      );
    case SignUpViewRoute:
      return _getPageRoute(

        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    case CreatePostViewRoute:
      var postToEdit = settings.arguments as Post;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreatePostView(
          edittingPost: postToEdit,
        ),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
