import 'package:school_app/models/subject_model.dart';
import 'package:school_app/models/task.dart';
import 'package:school_app/ui/views/create_task_view.dart';
import 'package:school_app/ui/views/table_view.dart';
import 'package:school_app/ui/views/tasks_of_subject_view.dart';
import 'package:school_app/ui/views/tasks_view.dart';
import 'package:school_app/ui/views/teacher_home_view.dart';
import 'package:school_app/ui/views/student_home_view.dart';
import 'package:school_app/ui/views/parent_home_view.dart';
import 'package:flutter/material.dart';
import 'package:school_app/ui/views/login_view.dart';
import 'package:school_app/ui/views/signup_view.dart';
import 'route_names.dart';

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
    case TeacherHomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: TeacherHomeView(),
      );
    case StudentHomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: StudentHomeView(),
      );
    case ParentHomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ParentHomeView(),
      );
    case TableViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: TableView(),
      );
    case TasksViewRoute:
        Task task = settings.arguments ;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: TasksView(task: task,),
      );
    case CreateTaskViewRoute:
      // var taskToEdit = settings.arguments as Task;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreateTaskView(
          // edittingTask: taskToEdit,
        ),
      );
    case TasksOfSubjectViewRout:
    Subject subj = settings.arguments;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: TasksOfSubjectView(
         subject: subj,
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
