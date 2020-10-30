import 'package:school_app/locator.dart';
import 'package:school_app/models/lesson_model.dart';
import 'package:school_app/routers/route_names.dart';
import 'package:school_app/services/dialog_service.dart';
import 'package:school_app/services/lessons_service.dart';
import 'package:school_app/services/navigation_service.dart';
import 'package:school_app/viewmodels/base_model.dart';

class TableViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final LessonsService _lessonsService = locator<LessonsService>();

  // final TaskFireStoreService _firestoreService =
  // locator<TaskFireStoreService>();
  
  final DialogService _dialogService = locator<DialogService>();

  // final CloudStorageService _cloudStorageService =
  // locator<CloudStorageService>();

  List<Lesson> lessonsList;

  TableViewModel() {
    lessonsList = [];
  }

  List englishDays = [
    'sat',
    'sun',
    'mon',
    'tue',
    'wed',
  ];

  List arabicDays = [
    'السبت',
    'الاحد',
    'الاثنين',
    'الثلاثاء',
    'الاربعاء',
  ];

  Lesson getLessonAt(String passedDay, String lessonTime) {
    var matchedLesson = lessonsList.firstWhere(
        (element) =>
            element.lessonNo == lessonTime && element.lessonDay == passedDay,
        orElse: () {
      print('No matching element.');
      return null;
    });

    return matchedLesson;
  }

  startGetLessons() async {
    setBusy(true);
    String orderValue = currentUser.userRole.toLowerCase() == 'teacher'
        ? 'teacher_id'
        : 'class_id';
    String equalID = currentUser.userRole.toLowerCase() == 'teacher'
        ? currentUser.id
        : currentUser.classId;

    var lessons = await _lessonsService.getLessons(
        orderByValue: orderValue, equalToId: equalID);
    if (lessons is List)
      lessonsList = lessons;
    else {
      print(lessons.toString());
    }
    await Future.delayed(Duration(seconds: 2));
    setBusy(false);
  }

  void navigateToTasks(Lesson lesson) {
    if (checkIsTeacher()) {
      _navigationService.navigateTo(CreateTaskViewRoute, arguments: lesson);
    }
  }
}
