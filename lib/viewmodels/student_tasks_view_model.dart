import 'dart:async';
import 'package:hive/hive.dart';
import 'package:school_app/models/subject_model.dart';
import 'package:school_app/models/class_model.dart';
import 'package:school_app/routers/route_names.dart';
import 'package:school_app/services/dialog_service.dart';
import 'package:school_app/services/lessons_service.dart';
import 'package:school_app/services/user_firestore_service.dart';
import 'package:school_app/services/navigation_service.dart';
import 'package:firebase_database/firebase_database.dart';
import '../locator.dart';
import 'base_model.dart';

class StudentHomeViewModel extends BaseModel {

  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final LessonsService _lessonsService = locator<LessonsService>();

  List<Subject> subjectsList;


  navigateToTasksOfSubject(Subject subject) {
    _navigationService.navigateTo(
        TasksOfSubjectViewRout, arguments: subject);
  }

  startGetData({String childId})async{
    setBusy(true);
    await getSubjectsOfStudentClass(childId: childId);
    setBusy(false);
  }

  getSubjectsOfStudentClass({String childId}) async {
    String orderBy;
    String equelTo;

    if(currentUser.userRole == 'Student')
      {
        orderBy = 'class_id';
        equelTo = currentUser.classId;
      }else
        {
          orderBy = 'class_id';

          UserFireStoreService _userFireStoreService = UserFireStoreService();
          String classId = _userFireStoreService.getClassId(childId);
          print (classId);

         equelTo = classId;
        }
    var result = await _lessonsService.getLessons(
        orderByValue: orderBy , equalToId: equelTo );

    await Future.delayed(Duration(seconds: 1));

    if (result is List){
      subjectsList = List<Subject>();
      subjectsList.clear();
      subjectsList = _lessonsService.subjectsList;
      subjectsList.toSet();
      await openBoxes();
      await Future.delayed(Duration(seconds: 1));
    } else {
      await _dialogService.showDialog(
        title: 'you do not have any subject yet',
        description: result,
      );
      _navigationService.pop();
    }
    await Future.delayed(Duration(seconds: 1));
  }

  openBoxes()async{

    print(subjectsList.length.toString());
     subjectsList.forEach((element) async {
      await Hive.openBox(element.name);
    });
  }

}
