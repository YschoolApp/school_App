import 'dart:async';
import 'package:hive/hive.dart';
import 'package:school_app/models/subject_model.dart';
import 'package:school_app/routers/route_names.dart';
import 'package:school_app/services/dialog_service.dart';
import 'package:school_app/services/lessons_service.dart';
import 'package:school_app/services/navigation_service.dart';
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

  startGetData()async{
    setBusy(true);
    await getSubjectsOfStudentClass();
    setBusy(false);
  }

  getSubjectsOfStudentClass() async {

    var result = await _lessonsService.getLessons(
        orderByValue: 'class_id', equalToId: currentUser.classId);

    await Future.delayed(Duration(seconds: 1));

    if (result is List){
      subjectsList = List<Subject>();
      subjectsList.clear();
      subjectsList = _lessonsService.subjectsList;
      subjectsList.toSet();
      await openBoxes();
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
